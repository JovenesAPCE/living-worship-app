sealed class RegisterSemiPlenaryFailure {

}
class UserNotExist extends RegisterSemiPlenaryFailure {}
class SessionNotExist extends RegisterSemiPlenaryFailure {}
class SessionNotFound extends RegisterSemiPlenaryFailure {}
class UserHasRegisteredInSemiPlenary extends RegisterSemiPlenaryFailure {
  final String user;
  UserHasRegisteredInSemiPlenary({required this.user});
  @override
  String toString() {
    return 'El usuario ya se registro a la semiplenaria: $user}';
  }
}
class NoCapacityInSemiPlenaries extends RegisterSemiPlenaryFailure {
  final List<String> plenaryIdsWithoutCapacity;

  NoCapacityInSemiPlenaries({required this.plenaryIdsWithoutCapacity});

  @override
  String toString() {
    return 'No hay cupos disponibles en las siguientes sesiones: ${plenaryIdsWithoutCapacity.join(', ')}';
  }
}

class NoInternetRegisterSemiPlenary extends RegisterSemiPlenaryFailure {}

class UnknownRegisterSemiPlenary extends RegisterSemiPlenaryFailure {}

class UserHasNotRegisteredInSemiPlenary extends RegisterSemiPlenaryFailure {}

class InvalidSemiPlenaryQr extends RegisterSemiPlenaryFailure {}

class UnknownSemiPlenaryQr extends RegisterSemiPlenaryFailure {}

class UnknownRegisterSemiPlenaryQr extends RegisterSemiPlenaryFailure {}

class InvalidServerTimestampRegisterSemiPlenaryQr extends RegisterSemiPlenaryFailure {}
