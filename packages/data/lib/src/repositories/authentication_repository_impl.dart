import 'dart:async';

import 'package:data/data.dart';
import 'package:domain/domain.dart';
import 'package:entities/entities.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:uuid/uuid.dart';
import '../data_sources/data_sources.dart';


class AuthenticationRepositoryImpl extends AuthenticationRepository {
  final _controller = StreamController<AuthStatus>();
  final DatabaseReference _dbRef = FirebaseDatabase.instance.ref();
  final FirebaseAnalytics _analytics = FirebaseAnalytics.instance;

  AuthenticationRepositoryImpl();

  @override
  Future<Either<LoginFailure, void>> logIn(String document, String year) async {


    try {

      await FBUtils.trySetCrashlyticsUser(document);
      final userSnapshot = await _dbRef.child('${ConstFirebase.eventPath}/${ConstFirebase.userPath}/${document}_$year').get();
      if (!userSnapshot.exists) {
        await FBUtils.tryLog('Intento fallido de login: contraseña incorrecta');
        await FBUtils.tryRecordError(
            FirebaseAuthException('Contraseña incorrecta para usuario $document $document $year')
        );
        return Left(LoginFailure.invalidCredentials());
      }
      final sessionId = Uuid().v4();

      final user = Map<String, dynamic>.from(userSnapshot.value as Map);
      if (user['year'].toString() == year) {

        await _analytics.setUserId(id: document);
        await _analytics.setUserProperty(name: 'nombre', value: user['name'] ?? '');

        await signUpOrLogin(document, year);

        await _dbRef.child('${ConstFirebase.eventPath}/${ConstFirebase.sessionPath}/${auth.FirebaseAuth.instance.currentUser?.uid}').set({
          'document': document,
          'timestamp': DateTime.now().toIso8601String(),
        });

        await HiveService.userBox.put(
          document,
          UserTable.fromEntity(User(
            document: document,
            name: user['name'].toString(),
            session: sessionId,
          )),
        );

        _controller.add(AuthStatus.authenticated);
        return Right(null);
      }else{
        FBUtils.tryLog('Intento fallido de login: usuario bloqueado por el año');
        await FBUtils.tryRecordError(
            FirebaseAuthException('Contraseña incorrecta para usuario $document $document $year')
        );
        return Left(LoginFailure.invalidCredentials());
      }
    }catch (e, stack) {
      if (e is auth.FirebaseException && e.code == 'unavailable') {
        return Left(LoginFailure.noInternet());
      }

      await FBUtils.tryRecordError(FirebaseAuthException.from(e), stack: stack);
      return Left(LoginFailure.unknown());
    }
  }

  @override
  Future<void> logOut() async {
    await _analytics.logEvent(name: 'logout');
    await FBUtils.trySetCrashlyticsUser('');
    await _analytics.setUserId(id: null);
    await HiveService.userBox.clear();
    await auth.FirebaseAuth.instance.signOut();
    _controller.add(AuthStatus.unauthenticated);
  }

  @override
  Stream<AuthStatus> get status async* {
    final user = HiveService.userBox.values.cast<UserTable?>().firstOrNull;
    print("status user: $user");
    await Future<void>.delayed(const Duration(seconds: 1));
    if (user != null) {
      yield AuthStatus.authenticated;
    } else {
      yield AuthStatus.unauthenticated;
    }
    yield* _controller.stream;
  }

  @override
  void dispose() => _controller.close();


  Future<auth.UserCredential> signUpOrLogin(String document, String birthYear) async {
    final email = '$document@jamt.app';
    final password = '$document$birthYear';

    try {
      return await auth.FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on auth.FirebaseAuthException catch (e) {
      if (e.code == 'email-already-in-use') {
        return await auth.FirebaseAuth.instance.signInWithEmailAndPassword(
          email: email,
          password: password,
        );
      } else {
        rethrow;
      }
    }
  }

}