part of 'login_bloc.dart';

sealed class LoginEvent extends Equatable {
  const LoginEvent();

  @override
  List<Object> get props => [];
}

final class LoginUsernameChanged extends LoginEvent {
  const LoginUsernameChanged(this.username);

  final String username;

  @override
  List<Object> get props => [username];
}

final class LoginBirthYearChanged extends LoginEvent {
  const LoginBirthYearChanged(this.birthYear);

  final String birthYear;

  @override
  List<Object> get props => [birthYear];
}

final class LoginSubmitted extends LoginEvent {
  const LoginSubmitted();
}