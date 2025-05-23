import 'dart:async';
import 'dart:io';
import 'dart:math';

import 'package:data/data.dart';
import 'package:data/src/data_sources/data_sources.dart';
import 'package:data/src/data_sources/table/register_semi_plenary_table.dart';
import 'package:domain/domain.dart';
import 'package:entities/entities.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';

class SemiPlenaryRepositoryImpl extends SemiPlenaryRepository {
  final db = FirebaseDatabase.instance.ref();
  final _controller = StreamController<QrStatus>();
  QRCheckInRepositoryImpl? _qrCheckInShared;

  @override
  Future<Either<RegisterSemiPlenaryFailure, QrState>> readQr(String fullQRText) async {
    _qrCheckInShared = null;
    final user = HiveService.userBox.values.cast<UserTable?>().firstOrNull;
    if (user == null) return Left(UserNotExist());
    QrPayload? qr = QRUtils.decryptQR(fullQRText);
    if (qr == null) return Left(InvalidSemiPlenaryQr());
    String semiPlenaryId = qr.uid;
    if(qr.type == QrConst.typeSemiPlenaryCheckIn){
      return Right(QrState(data: QRData(
          semiPlenary: semiPlenaryId, document: user.document),
          status: QrStatus.checkIn));
    }else if(qr.type == QrConst.typeSemiPlenaryCheckOut){
      print("typeSemiPlenaryCheckOut");
      return Right(QrState(data: QRData(
          semiPlenary: semiPlenaryId, document: user.document),
          status: QrStatus.checkOut));
    }else {
      return Left(UnknownSemiPlenaryQr());
    }
  }

  @override
  Future<List<SemiPlenary>> semiPlenaries() async {
    var list = HiveService.semiPlenaryBox.values.map((e) => e.toEntity()).toList();
    list.sort((a, b) => (a.title ?? "").compareTo(b.title ?? ""));
    return list;
  }

  @override
  Future<void> updateSemiPlenaries() async {
    final user = HiveService.userBox.values.cast<UserTable?>().firstOrNull;
    if(user!=null){
      final registerEventRef = db.child('${ConstFirebase.eventPath}/${ConstFirebase.registerPlenaryPath}/${user.document}');
      bool pendingUpdate = user.pendingUpdate??false;

      if(pendingUpdate){
        final List<RegisterSemiPlenary> registerSemiPlenaries = HiveService.registerSemiPlenaryTableBox.values.map((e) => e.toEntity())
            .toList();
        try{
          final map = <String, Object>{};
          for (final semiPlenary in registerSemiPlenaries) {
            map["${semiPlenary.semiPlenary}_${semiPlenary.document}"] = {
              'document': user.document,
              'group': semiPlenary.group,
              'title': semiPlenary.title,
              'timestamp': DateTime.now().toIso8601String(),
            };
          }

          await registerEventRef.set(map);
          final updatedUser = user
            ..pendingUpdate = false;
          await HiveService.userBox.put(user.document, updatedUser);
        }catch(e, stack){
          await FBUtils.tryLog('No se pudo volver a enlazar en el evento al usuario a');
          for (final semiPlenary in registerSemiPlenaries) {
            await FBUtils.tryLog('semiplenaria: ${semiPlenary.semiPlenary}');;
          }
          await FBUtils.tryRecordError(FirebaseSemiPlenaryException.from(e), stack: stack);
        }
      }
    }

    final DatabaseReference ref = FirebaseDatabase.instance.ref("${ConstFirebase.eventPath}/${ConstFirebase.plenaryPath}");
    final DataSnapshot snapshot = await ref.get();
    if (snapshot.exists && snapshot.value is Map) {
      await HiveService.semiPlenaryBox.clear();
      final data = snapshot.value as Map;

      data.entries.map((entry) async{
        final id = entry.key;
        final json = Map<String, dynamic>.from(entry.value);
        await HiveService.semiPlenaryBox.put(
            id,
            SemiPlenaryTable()
              ..id = id
              ..color = json['color']
              ..group = json['group']
              ..issue = json['issue']
              ..title = json['title']
              ..time = json['time']
              ..capacity = json['capacity']
              ..available = json["available"]
              ..gender = json["gender"]
        );
      }).toList();
    } else {
      // Firebase está accesible pero el nodo no existe
      await HiveService.semiPlenaryBox.clear();
    }

    final registerEventRef = db.child('${ConstFirebase.eventPath}/${ConstFirebase.registerPlenaryPath}/${user!.document}');
    final DataSnapshot registerEventSnapshot = await registerEventRef.get();
    if (registerEventSnapshot.exists && registerEventSnapshot.value is Map) {
      await HiveService.registerSemiPlenaryTableBox.clear();
      final data = registerEventSnapshot.value as Map;
      data.entries.map((entry) async{
        final id = entry.key;
        final json = Map<String, dynamic>.from(entry.value);
        await HiveService.registerSemiPlenaryTableBox.put(
            "${id}_${json['document']}",
            RegisterSemiPlenaryTable()
              ..semiPlenary = id
              ..group = json['group']
              ..document = json['document']
              ..title = json['title']
              ..checkOut = json['checkOut'] as bool?
              ..checkOutTimestamp = (json['checkOutTimestamp'] is int) ? DateTime.fromMillisecondsSinceEpoch(json['checkOutTimestamp']) : null
              ..checkIn = json['checkIn'] as bool?
              ..checkInTimestamp = (json['checkInTimestamp'] is int) ? DateTime.fromMillisecondsSinceEpoch(json['checkInTimestamp']) : null
              ..timestamp = DateTime.parse(json['timestamp'])
        );
      }).toList();
    } else {
      await HiveService.registerSemiPlenaryTableBox.clear();
    }
  }

  @override
  Future<Either<RegisterSemiPlenaryFailure, void>> registerSemiPlenary(List<SemiPlenary> semiPlenaries) async {

    final user = HiveService.userBox.values.cast<UserTable?>().firstOrNull;
    if (user?.document == null) return Left(UserNotExist());

    final session = FirebaseAuth.instance.currentUser?.uid;
    if (session == null) return Left(SessionNotExist());

    final registerEventRef = db.child('${ConstFirebase.eventPath}/${ConstFirebase.registerPlenaryPath}/${user!.document}');
    final existing = await registerEventRef.get();
    if (existing.exists) {
      return Left(UserHasRegisteredInSemiPlenary(user: user.name ?? ""));
    }

    final plenaryRef = db.child('${ConstFirebase.eventPath}/${ConstFirebase.plenaryPath}');
    List<String> plenaryIdsWithoutCapacity = [];
    Map<String, dynamic> plenariesData = {};
    TransactionResult? transactionResult;
    try{
      transactionResult = await plenaryRef.runTransaction((currentData) {
        if (currentData is Map) {
          plenariesData = Map<String, dynamic>.from(currentData);
        }

        // Verificar disponibilidad
        for (final entry in plenariesData.entries) {
          final exist = semiPlenaries.any((element) => element.id == entry.key);
          if (exist) {
            final plenary = Map<String, dynamic>.from(entry.value);
            final capacity = plenary['capacity'] ?? 0;
            final registered = plenary['registered'] ?? 0;
            final available = capacity - registered;

            if (available <= 0) {
              plenaryIdsWithoutCapacity.add(entry.key);
              return Transaction.abort();
            }
          }
        }

        // Actualizar sesiones válidas
        for (final entry in plenariesData.entries) {
          final exist = semiPlenaries.any((element) => element.id == entry.key);
          if (exist) {
            final plenary = Map<String, dynamic>.from(entry.value);
            final capacity = plenary['capacity'] ?? 0;
            final registered = plenary['registered'] ?? 0;
            final available = capacity - registered;

            plenary['available'] = available - 1;
            plenary['registered'] = registered + 1;
            plenariesData[entry.key] = plenary;
          }
        }

        return Transaction.success(plenariesData);
      });
    }catch(e){

      if (e is FirebaseException && e.code == 'unavailable') {
        return Left(NoInternetRegisterSemiPlenary());
      }
      return Left(UnknownRegisterSemiPlenary());
    }


    if (transactionResult.committed) {
      try {

        await HiveService.registerSemiPlenaryTableBox.clear();

        for (final semiPlenary in semiPlenaries) {

          await HiveService.registerSemiPlenaryTableBox.put(
            "${semiPlenary.id}_${user.document}",
            RegisterSemiPlenaryTable.fromEntity(RegisterSemiPlenary(
                semiPlenary: semiPlenary.id,
                document: user.document,
                timestamp: DateTime.now(),
                group: semiPlenary.group??"",
                title: semiPlenary.title??""
            )),
          );
        }

        final map = <String, Object>{};
        for (final semiPlenary in semiPlenaries) {
          map[semiPlenary.id] = {
            'document': user.document,
            'group': semiPlenary.group,
            'title': semiPlenary.title,
            'timestamp': DateTime.now().toIso8601String(),
          };
        }
        await registerEventRef.set(map);

        final updatedUser = user
          ..pendingUpdate = false;
        await HiveService.userBox.put(user.document, updatedUser);

        await HiveService.semiPlenaryBox.clear();
        for (final entry in plenariesData.entries){

          final plenary = Map<String, dynamic>.from(entry.value);

          var capacity = 0;
          if(plenary.containsKey("capacity")){
            capacity = plenary['capacity'] ?? 0;
          }
          var available = 0;
          if(plenary.containsKey("available")){
            available = plenary['available'] ?? 0;
          }
          final color =  plenary['color'] ?? "";
          final group =  plenary['group'] ?? "";
          final issue =  plenary['issue'] ?? "";
          final title =  plenary['title'] ?? "";
          final time =  plenary['time'] ?? "";
          final gender = plenary['gender'] ?? "";

          await HiveService.semiPlenaryBox.put(
              entry.key,
              SemiPlenaryTable()
                ..id =  entry.key
                ..group = group
                ..color = color
                ..issue = issue
                ..title = title
                ..time = time
                ..capacity = capacity
                ..available = available
                ..gender = gender
          );

        }

        return Right(null);
      } catch (e, stack) {

        await FBUtils.tryLog('No se pudo enlazar en el evento al usuario');
        for (final semiPlenary in semiPlenaries) {
          await FBUtils.tryLog('semiplenaria: ${semiPlenary.id}');;
        }
        await FBUtils.tryRecordError(FirebaseSemiPlenaryException.from(e), stack: stack);
        final updatedUser = user
          ..pendingUpdate = true;
        await HiveService.userBox.put(user.document, updatedUser);

        return Left(NoInternetRegisterSemiPlenary());
      }

    } else if (plenaryIdsWithoutCapacity.isNotEmpty) {
      return Left(NoCapacityInSemiPlenaries(plenaryIdsWithoutCapacity: plenaryIdsWithoutCapacity));
    }

    return Left(UnknownRegisterSemiPlenary());

  }

  @override
  Future<List<RegisterSemiPlenary>> getRegisterSemiPlenaries() async {
    final List<RegisterSemiPlenary> registerSemiPlenaries = HiveService.registerSemiPlenaryTableBox.values.map((e) => e.toEntity()).toList();

    return registerSemiPlenaries;
  }

  @override
  Stream<QrStatus> get qrStatus  async* {
    await Future<void>.delayed(const Duration(seconds: 1));
    yield QrStatus.hidden;
    yield* _controller.stream;
  }

  @override
  void qrStatusDispose() => _controller.close();

  @override
  Future<Either<RegisterSemiPlenaryFailure, void>> registerSemiPlenaryCheckIn(QRData qRData)  => registerSemiPlenaryCheck(qRData, true);

  Future<Either<RegisterSemiPlenaryFailure, void>> registerSemiPlenaryCheck(QRData qRData, bool modeCheckIn) async {
    final user = HiveService.userBox.values.cast<UserTable?>().firstOrNull;
    if (user == null) return Left(UserNotExist());

    final session = FirebaseAuth.instance.currentUser?.uid;
    if (session == null) return Left(SessionNotExist());

    final registerEventRef = db.child('${ConstFirebase.eventPath}/${ConstFirebase.registerPlenaryPath}/${user.document}/${qRData.semiPlenary}');
    final snapshot = await registerEventRef.get();
    if(!snapshot.exists){
      await FBUtils.tryLog('user ${user.document} not register semi plenary');
      await FBUtils.tryRecordError(FirebaseSemiPlenaryException.from(e));
      return Left(UserHasNotRegisteredInSemiPlenary());
    }

    var currentRegisterData = snapshot.value;
    Map<String, dynamic> registerPlenaryData = {};
    if (currentRegisterData is Map) {
      registerPlenaryData = Map<String, dynamic>.from(currentRegisterData);
    }

    final plenaryRef = db.child('${ConstFirebase.eventPath}/${ConstFirebase.plenaryPath}/${qRData.semiPlenary}');
    DataSnapshot plenaryDataSnap = await plenaryRef.get();
    if(!plenaryDataSnap.exists){
      await FBUtils.tryLog('unknown semi plenary');
      await FBUtils.tryRecordError(FirebaseSemiPlenaryException.from(e));
      return Left(UnknownRegisterSemiPlenaryQr());
    }

    var currentData = plenaryDataSnap.value;
    Map<String, dynamic> plenaryData = {};
    if (currentData is Map) {
      plenaryData = Map<String, dynamic>.from(currentData);
    }

    print("modeCheckIn: $modeCheckIn");
    final timestamp = modeCheckIn
        ? registerPlenaryData['checkInTimestamp']
        : registerPlenaryData['checkOutTimestamp'];
    print("timestamp: $timestamp");
    DateTime? checkTimestamp =
    (timestamp is int) ? DateTime.fromMillisecondsSinceEpoch(timestamp) : null;
    print("checkTimestamp: $checkTimestamp");
    _qrCheckInShared = QRCheckInRepositoryImpl(
        semiPlenaryId:  qRData.semiPlenary??"",
        color: plenaryData['color'],
        group:  plenaryData['group'] ,
        issue: plenaryData['issue'],
        title:  plenaryData['title'],
        time: plenaryData['time'],
        timestamp: checkTimestamp,
        qrState: QrState(
            status: QrStatus.checkIn,
            data: qRData),
        hasRegister: true
    );

    bool? check;
    if(modeCheckIn){
      check = registerPlenaryData['checkIn'] as bool?;
    }else {
      check = registerPlenaryData['checkOut'] as bool?;
    }

    print("check: $check");
    if(check??false){
      _qrCheckInShared = _qrCheckInShared?.copyWith(
        hasRegister: true,
      );
      _controller.add(modeCheckIn ?QrStatus.checkIn: QrStatus.checkOut);
      return Left(UserHasRegisteredInSemiPlenary(user: user.name ?? ""));
    }

    final startTimeStr = plenaryData['startTime'] as String?;
    final endTimeStr = plenaryData['endTime'] as String?;

    if (startTimeStr == null || endTimeStr == null) {
      await FBUtils.tryLog('Semiplenaria missing time fields');
      await FBUtils.tryRecordError(FirebaseSemiPlenaryException.from(e));
      return Left(InvalidServerTimestampRegisterSemiPlenaryQr());
    }

    try{

      final checkInTime = (await getDateUTCGlobal()).toLocal();
      final startTime = DateTime.parse(startTimeStr);
      final endTime = DateTime.parse(endTimeStr);

      if (checkInTime.isBefore(startTime) || checkInTime.isAfter(endTime)) {
        await FBUtils.tryLog('Check-in not allowed at this time.');
        await FBUtils.tryRecordError(FirebaseSemiPlenaryException.from(e));
        return Left(InvalidServerTimestampRegisterSemiPlenaryQr());
      }
      _qrCheckInShared = _qrCheckInShared?.copyWith(
          timestamp: checkInTime
      );

      if(modeCheckIn){
        await registerEventRef.update({
          'checkIn': true,
          'checkInTimestamp': ServerValue.timestamp
        });
        var register = HiveService.registerSemiPlenaryTableBox.get("${qRData.semiPlenary}_${user.document}");
        if(register!=null){
          await HiveService.registerSemiPlenaryTableBox.put(
              "${qRData.semiPlenary}_${user.document}",
              register
                ..checkIn = true
                ..checkInTimestamp = startTime
          );
        }
      }else{
        await registerEventRef.update({
          'checkOut': true,
          'checkOutTimestamp': ServerValue.timestamp
        });
        var register = HiveService.registerSemiPlenaryTableBox.get("${qRData.semiPlenary}_${user.document}");
        if(register!=null){
          await HiveService.registerSemiPlenaryTableBox.put(
              "${qRData.semiPlenary}_${user.document}",
              register
                ..checkOut = true
                ..checkOutTimestamp = startTime.toLocal()
          );
        }

      }


    }catch(e,stack){
      await FBUtils.tryRecordError(FirebaseSemiPlenaryException.from(e), stack: stack);
      if (e is FirebaseException && e.code == 'unavailable') {
        return Left(NoInternetRegisterSemiPlenary());
      }else if(e is SocketException){
        return Left(NoInternetRegisterSemiPlenary());
      }
      return Left(UnknownRegisterSemiPlenaryQr());
    }

    _qrCheckInShared = _qrCheckInShared?.copyWith(
      hasRegister: false,
    );
    _controller.add(modeCheckIn ?QrStatus.checkIn: QrStatus.checkOut);
    return Right(null);
  }

  @override
  Future<Either<RegisterSemiPlenaryFailure, QrStateSemiPlenary>> getQrStateSemiPlenary() async {
    if(_qrCheckInShared==null) return Left(UnknownSemiPlenaryQr());
    final user = HiveService.userBox.values.cast<UserTable?>().firstOrNull;
    print("_qrCheckInShared?.timestamp: ${_qrCheckInShared?.timestamp}");
    return Right(QrStateSemiPlenary(
        semiPlenaryId: _qrCheckInShared!.semiPlenaryId,
        semiPlenaryTitle:  _qrCheckInShared!.title,
        semiPlenaryTime: _qrCheckInShared!.time,
        userNumber: user?.document??"",
        userName: user?.name,
        checkInTime: _qrCheckInShared?.timestamp,
        color: _qrCheckInShared?.color,
        hasRegister: _qrCheckInShared?.hasRegister));
  }

  Future<DateTime> getDateUTCGlobal() async {
    try {
      final url = Uri.parse('https://timeapi.io/api/Time/current/zone?timeZone=UTC');
      final response = await http.get(url).timeout(const Duration(seconds: 3));

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        String raw = data['dateTime']; // ej: "2025-05-23T03:36:35.3049888"

      // Asegura que termine con "Z" para que Dart lo trate como UTC
        if (!raw.endsWith('Z')) raw += 'Z';
        return DateTime.parse(raw);
      } else {
        print('Error de la API: ${response.statusCode}');
      }
    } on SocketException {
      // 🔴 Sin internet
      throw SocketException('No hay conexión a internet');
    } on TimeoutException {
      print('La solicitud a worldtimeapi.org tardó demasiado.');
    } catch (e) {
      print('Error al obtener la hora desde internet: $e');
    }

    // ✅ Fallback si la API falló pero hay internet
    return DateTime.now().toUtc();
  }

  @override
  Future<Either<RegisterSemiPlenaryFailure, void>> registerSemiPlenaryCheckOut(QRData qRData)  => registerSemiPlenaryCheck(qRData, false);

  @override
  Future<void> showCheckIn(String semiPlenary) async{
    final user = HiveService.userBox.values.cast<UserTable?>().firstOrNull;
    var plenaryData = HiveService.semiPlenaryBox.get(semiPlenary);
    var register = HiveService.registerSemiPlenaryTableBox.get("${semiPlenary}_${user?.document}");

    _qrCheckInShared = QRCheckInRepositoryImpl(
        semiPlenaryId:  semiPlenary,
        color: plenaryData?.color,
        group:  plenaryData?.group ,
        issue: plenaryData?.issue,
        title:  plenaryData?.title,
        time: plenaryData?.time,
        timestamp: register?.checkInTimestamp,
        qrState: QrState(
            status: QrStatus.checkIn,
            data: QRData(
              semiPlenary: semiPlenary,
              document: user?.document
            )),
        hasRegister: false
    );

    _controller.add(QrStatus.none);
    _controller.add(QrStatus.checkIn);

  }

  @override
  Future<void> showCheckOut(String semiPlenary) async {
    final user = HiveService.userBox.values.cast<UserTable?>().firstOrNull;
    var plenaryData = HiveService.semiPlenaryBox.get(semiPlenary);

    var register = HiveService.registerSemiPlenaryTableBox.get("${semiPlenary}_${user?.document}");

    _qrCheckInShared = QRCheckInRepositoryImpl(
        semiPlenaryId:  semiPlenary,
        color: plenaryData?.color,
        group:  plenaryData?.group ,
        issue: plenaryData?.issue,
        title:  plenaryData?.title,
        time: plenaryData?.time,
        timestamp: register?.checkInTimestamp,
        qrState: QrState(
            status: QrStatus.checkIn,
            data: QRData(
                semiPlenary: semiPlenary,
                document: user?.document
            )),
        hasRegister: true
    );

    _controller.add(QrStatus.none);
    _controller.add(QrStatus.checkOut);

  }



}

class QRCheckInRepositoryImpl {
  String semiPlenaryId;
  String? color;
  String? group;
  String? issue;
  String? time;
  String? title;
  DateTime? timestamp;
  bool hasRegister;
  QrState qrState;

  QRCheckInRepositoryImpl({required this.semiPlenaryId, this.color, this.group,
    this.issue, this.time, this.title, required this.hasRegister, required this.qrState, this.timestamp});

  QRCheckInRepositoryImpl copyWith({
    String? semiPlenaryId,
    String? color,
    String? group,
    String? issue,
    String? time,
    String? title,
    bool? hasRegister,
    QrState? qrState,
    DateTime? timestamp
  }) {
    return QRCheckInRepositoryImpl(
        semiPlenaryId: semiPlenaryId ?? this.semiPlenaryId,
        color: color ?? this.color,
        group: group ?? this.group,
        issue: issue ?? this.issue,
        time: time ?? this.time,
        title: title ?? this.title,
        qrState: qrState ?? this.qrState,
        hasRegister: hasRegister ?? this.hasRegister,
        timestamp: timestamp?? this.timestamp
    );
  }

}