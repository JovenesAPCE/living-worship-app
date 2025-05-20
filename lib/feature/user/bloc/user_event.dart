part of 'user_bloc.dart';

sealed class UserEvent extends Equatable {

  @override
  List<Object?> get props => [];

  const UserEvent();
}

class OnSelectedDecision extends UserEvent {

  final UserDecision userDecision;

  const OnSelectedDecision(this.userDecision);

  @override
  List<Object?> get props => [userDecision];
}

class OnCompleteDecision extends UserEvent {}

class OnUserScreenClose extends UserEvent {}

class OnEmailChanged extends UserEvent {
  final String email;
  const OnEmailChanged(this.email);

  @override
  List<Object> get props => [email];
}

class OnCellphoneChanged extends UserEvent {
  final String cellphone;
  const OnCellphoneChanged(this.cellphone);

  @override
  List<Object> get props => [cellphone];
}

class OnReConfirmDecision extends UserEvent {}

class OnMaybeLaterDecision extends UserEvent {}

class ClearMessageRequested extends UserEvent {}

class OpenWhatsAppGroup extends UserEvent {}

class RequestAddUser extends UserEvent {}