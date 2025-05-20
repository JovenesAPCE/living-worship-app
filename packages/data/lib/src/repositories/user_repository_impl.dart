import 'dart:io';

import 'package:data/data.dart';
import 'package:domain/domain.dart';
import 'package:entities/entities.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:firebase_database/firebase_database.dart';
import '../data_sources/data_sources.dart';

class UserRepositoryImpl extends UserRepository {
  final db = FirebaseDatabase.instance.ref();
  @override
  Future<User?> getUser() async {
    final user = HiveService.userBox.values.cast<UserTable?>().firstOrNull;
    if(user == null) return null;
    return User(
      document: user.document,
      name: user.name
    );
  }

  @override
  Future<Either<RegisterUserDecisionFailure, void>> registerUserDecision(RegisterUserDecision decision) async {
   final user = HiveService.userBox.values.cast<UserTable?>().firstOrNull;
    if (user?.document == null) return Left(UserNotExistRegisterUserDecision());

    try{
      final session = auth.FirebaseAuth.instance.currentUser?.uid;
      if (session == null) return Left(SessionNotExistRegisterUserDecision());


      final registerEventRef = db.child('${ConstFirebase.eventPath}/${ConstFirebase.registerUserDecisionPath}/${user!.document}');
      await registerEventRef.set(decision.copyWith(
        number: user.document,
        name: user.name
      ).toMap());

      var register = HiveService.userBox.get(user.document);
      if(register!=null){
        await HiveService.userBox.put(
            user.document,
            register
              ..yesIPreacher = true
        );
      }

      return Right(null);
    }catch(e,stack){
      await FBUtils.tryRecordError(FirebaseSemiPlenaryException.from(e), stack: stack);
      if (e is auth.FirebaseException && e.code == 'unavailable') {
        return Left(NoInternetRegisterUserDecision());
      }else if(e is SocketException){
        return Left(NoInternetRegisterUserDecision());
      }
      return Left(UnknownRegisterUserDecision());
    }
  }

  @override
  Future<Either<RegisterUserDecisionFailure, String>> getPathWhatsAppGroup() async{
    final user = HiveService.userBox.values.cast<UserTable?>().firstOrNull;
    if (user?.document == null) return Left(UserNotExistRegisterUserDecision());

    try{
      final session = auth.FirebaseAuth.instance.currentUser?.uid;
      if (session == null) return Left(SessionNotExistRegisterUserDecision());

      final parameterWhatsappPathRef = db.child('${ConstFirebase.eventPath}/${ConstFirebase.parameterWhatsappPath}');

      var  result = await parameterWhatsappPathRef.get();
      String? url = "";
      if(result.exists){
        url = result.value as String?;
      }
      return Right(url??"");
    }catch(e,stack){
      await FBUtils.tryRecordError(FirebaseSemiPlenaryException.from(e), stack: stack);
      if (e is auth.FirebaseException && e.code == 'unavailable') {
        return Left(NoInternetRegisterUserDecision());
      }else if(e is SocketException){
        return Left(NoInternetRegisterUserDecision());
      }
      return Left(UnknownRegisterUserDecision());
    }
  }

  @override
  Future<Either<RegisterUserDecisionFailure, bool>> getUserDecision() async{
    final user = HiveService.userBox.values.cast<UserTable?>().firstOrNull;
    if (user?.document == null) return Left(UserNotExistRegisterUserDecision());

    try{
      final session = auth.FirebaseAuth.instance.currentUser?.uid;
      if (session == null) return Left(SessionNotExistRegisterUserDecision());

      final registerEventRef = db.child('${ConstFirebase.eventPath}/${ConstFirebase.registerUserDecisionPath}/${user!.document}');
      final DataSnapshot registerEventSnapshot = await registerEventRef.get();
      if (registerEventSnapshot.exists && registerEventSnapshot.value is Map) {

        var register = HiveService.userBox.get(user.document);
        if(register!=null){
          await HiveService.userBox.put(
              user.document,
              register
                ..yesIPreacher = true
          );
        }

      }else {
        var register = HiveService.userBox.get(user.document);
        if(register!=null){
          await HiveService.userBox.put(
              user.document,
              register
                ..yesIPreacher = false
          );
        }
      }
      var register = HiveService.userBox.get(user.document);

      return Right(register?.yesIPreacher??false);
    }catch(e,stack){
      await FBUtils.tryRecordError(FirebaseSemiPlenaryException.from(e), stack: stack);
      if (e is auth.FirebaseException && e.code == 'unavailable') {
        return Left(NoInternetRegisterUserDecision());
      }else if(e is SocketException){
        return Left(NoInternetRegisterUserDecision());
      }
      return Left(UnknownRegisterUserDecision());
    }
  }


}