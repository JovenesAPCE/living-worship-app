class InvalidQrException implements Exception {
  final String message;
  final String? context;

  InvalidQrException(this.message, {this.context});

  @override
  String toString() => 'InvalidQrException: $message ${context != null ? "[Context: $context]" : ""}';
}