sealed class LoginFailure {
  const LoginFailure();

  factory LoginFailure.invalidCredentials() = InvalidCredentials;
  factory LoginFailure.noInternet() = NoInternet;
  factory LoginFailure.unknown() = Unknown;
}

class InvalidCredentials extends LoginFailure {
  const InvalidCredentials();
}

class NoInternet extends LoginFailure {
  const NoInternet();
}

class Unknown extends LoginFailure {
  const Unknown();
}