part of 'qr_bloc.dart';


sealed class QrEvent extends Equatable {
  const QrEvent();
  @override
  List<Object> get props => [];
}

final class QRPageSubscriptionRequested extends QrEvent { }

final class CodeScanData extends QrEvent {

  const CodeScanData(this.code);

  final String code;

  @override
  List<Object> get props => [code];
}

class QRClearMessageRequested extends QrEvent {}