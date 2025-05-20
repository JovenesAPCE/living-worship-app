import 'package:equatable/equatable.dart';
import 'package:jamt/widget/widget.dart';

class UserMessage extends Equatable {
  final TimedMessageType type;
  final String message;
  final bool show;

  const UserMessage.info(String message) : this._(show: true, type: TimedMessageType.info, message: message);
  const UserMessage.error(String message) : this._( show: true, type: TimedMessageType.error, message: message);
  const UserMessage.warning(String message) : this._(show: true,  type: TimedMessageType.warning, message: message);
  const UserMessage.success(String message) : this._(show: true,  type: TimedMessageType.success, message: message);

  const UserMessage.empty() : this._(show: false, type: TimedMessageType.info, message: "");

  const UserMessage._({required this.show ,required this.type, required this.message});



  @override
  List<Object?> get props => [type, message, show];



}