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