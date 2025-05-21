
enum QrStatus {
  none,
  hidden,
  scanning,
  checkIn,
  checkOut
}

class QrState {
  final QrStatus status;
  final QRData data;
  final String? message;

  const QrState({
    required this.status,
    required this.data,
    this.message
  });

  QrState copyWith({
    QrStatus? status,
    QRData? data,
    String? message,
  }) {
    return QrState(
      status: status ?? this.status,
      data: data ?? this.data,
      message: message ?? this.message,
    );
  }

}

class QRData {
  final String? document;
  final String? semiPlenary;
  const QRData({this.document, this.semiPlenary});
}