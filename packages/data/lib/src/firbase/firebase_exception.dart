abstract class FirebaseExceptionBase implements Exception {
  final String message;
  final String? context;

  FirebaseExceptionBase(this.message, {this.context});

  @override
  String toString() =>
      '${runtimeType.toString()}: $message${context != null ? " [Context: $context]" : ""}';
}

class FirebaseAuthException extends FirebaseExceptionBase {
  FirebaseAuthException(super.message, {super.context});

  FirebaseAuthException.from(dynamic exception, {String? context})
      : super(exception.toString(), context: context);
}

class FirebaseSemiPlenaryException extends FirebaseExceptionBase {
  FirebaseSemiPlenaryException(super.message, {super.context});

  FirebaseSemiPlenaryException.from(dynamic exception, {String? context})
      : super(exception.toString(), context: context);
}