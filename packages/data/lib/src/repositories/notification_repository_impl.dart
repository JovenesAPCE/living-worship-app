import 'package:data/data.dart';
import 'package:data/src/data_sources/data_sources.dart';
import 'package:data/src/data_sources/table/notification_table.dart';
import 'package:domain/domain.dart';
import 'package:entities/entities.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class NotificationRepositoryImpl extends NotificationRepository{
  final db = FirebaseDatabase.instance.ref();
  late bool _wasOpenNotification;

  @override
  Future<void> updateNotification() async{
    final user = HiveService.userBox.values.cast<UserTable?>().firstOrNull;

    final DatabaseReference ref = FirebaseDatabase.instance.ref("${ConstFirebase.eventPath}/${ConstFirebase.notification}");
    final DataSnapshot snapshot = await ref.get();
    if (snapshot.exists && snapshot.value is Map) {
      await HiveService.notificationTableBox.clear();
      final data = snapshot.value as Map;

      data.entries.map((entry) async{
        final id = entry.key;
        final json = Map<String, dynamic>.from(entry.value);
        await HiveService.notificationTableBox.put(
            id,
            NotificationTable()
              ..id = id
              ..body = json['body']
              ..image = json['image']
              ..row = json['row']
              ..date = json['date']
        );
      }).toList();
    } else {
      // Firebase está accesible pero el nodo no existe
      await HiveService.notificationTableBox.clear();
    }
  }

  @override
  Future<List<Notification>> notifications() async {
    var list = HiveService.notificationTableBox.values.map((e) => e.toEntity()).toList();
    list.sort((a, b) => (b.row).compareTo(a.row));
    return list;
  }

  @override
  Future<bool> wasOpenNotification() async {
    // Se almacena en memoria ya que la funcion wasOpenedFromNotification se limpia después de usarlo
    //if(!_wasOpenNotification){
      _wasOpenNotification = NotificationHandler.wasOpenedFromNotification();
    //}
    return _wasOpenNotification;
  }

  @override
  Stream<Notification> get notificationReceived async* {
    final messaging = FirebaseMessaging.instance;
    final settings = await messaging.requestPermission();
    print('🔐 Permiso de notificación: ${settings.authorizationStatus}');
    yield* FirebaseMessaging.onMessage.map((message) => message.toEntity());
  }

  @override
  Future<void> unsubscribeNotification() async{
    try {
      //await FirebaseMessaging.instance.deleteToken();
     // print('🔕 Token FCM eliminado, no se recibirán más notificaciones');
    } catch (e) {
      print('❌ Error al eliminar token: $e');
    }
  }

  @override
  Future<String> subscribeNotification() async{
    String fcmToken = "";
    try{
      fcmToken = await FirebaseMessaging.instance.getToken()??"";
    }catch(e, stack){
      FBUtils.tryRecordError(e, stack: stack);
    }
    return fcmToken;
  }

}