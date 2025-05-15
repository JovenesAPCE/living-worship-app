part of 'qr_bloc.dart';

final class QrState extends Equatable{

  const QrState({
    this.progress = true,
    this.qrMessage = const QRMessage.empty()
  });


  final QRMessage qrMessage;
  final bool progress;

  @override
  List<Object?> get props => [ qrMessage, progress];

  QrState copyWith({QRMessage? qrMessage, bool? progress}) {
    return QrState(
      qrMessage: qrMessage ?? this.qrMessage,
      progress: progress ?? this.progress,
    );
  }
}
