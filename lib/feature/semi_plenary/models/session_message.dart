import 'package:equatable/equatable.dart';
import 'package:jamt/widget/widget.dart';

class SessionMessage extends Equatable {
  final MessageType type;
  final String message;
  final bool show;

  const SessionMessage.info(String message) : this._(show: true, type: MessageType.info, message: message);
  const SessionMessage.error(String message) : this._( show: true, type: MessageType.error, message: message);
  const SessionMessage.warning(String message) : this._(show: true,  type: MessageType.warning, message: message);
  const SessionMessage.success(String message) : this._(show: true,  type: MessageType.success, message: message);

  const SessionMessage.empty() : this._(show: false, type: MessageType.info, message: "");

  const SessionMessage._({required this.show ,required this.type, required this.message});



  @override
  List<Object?> get props => [type, message, show];



}