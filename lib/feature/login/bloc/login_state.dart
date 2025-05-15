part of 'login_bloc.dart';

final class LoginState extends Equatable {
  const LoginState({
    this.loginToast = const LoginToast.hide(),
    this.username = const Username.pure(),
    this.birthYear = const BirthYear.pure(),
    this.isValid = false,
    this.progress = false
  });

  final LoginToast loginToast;
  final Username username;
  final BirthYear birthYear;
  final bool isValid;
  final bool progress;

  LoginState copyWith({
    LoginToast? loginToast,
    Username? username,
    BirthYear? birthYear,
    bool? isValid,
    bool? progress,
  }) {
    return LoginState(
      loginToast: loginToast ?? this.loginToast,
      username: username ?? this.username,
      birthYear: birthYear ?? this.birthYear,
      isValid: isValid ?? this.isValid,
        progress: progress??this.progress
    );
  }

  @override
  List<Object> get props => [loginToast, username, birthYear, progress];
}

