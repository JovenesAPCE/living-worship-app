//enum ProgressType { loading, success, error }
import 'package:equatable/equatable.dart';
import 'package:jamt/widget/widget.dart';

class SessionProgress extends Equatable {
  final ProgressType type;
  final bool show;
  final String message;
  const SessionProgress.loading(String message) : this._(show: true, type: ProgressType.loading, message: message);
  const SessionProgress.success(String message) : this._( show: true, type: ProgressType.success, message: message);
  const SessionProgress.error(String message) : this._(show: true,  type: ProgressType.error, message: message);

  const SessionProgress.empty() : this._(show: false, type: ProgressType.loading, message: "");

  const SessionProgress._({required this.show ,required this.type, required this.message});



  @override
  List<Object?> get props => [type, show, message];



}