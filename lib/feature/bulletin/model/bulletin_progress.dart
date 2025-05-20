//enum ProgressType { loading, success, error }
import 'package:equatable/equatable.dart';
import 'package:jamt/widget/widget.dart';

class BulletinProgress extends Equatable {
  final ProgressType type;
  final bool show;
  final String message;
  const BulletinProgress.loading(String message) : this._(show: true, type: ProgressType.loading, message: message);
  const BulletinProgress.success(String message) : this._( show: true, type: ProgressType.success, message: message);
  const BulletinProgress.error(String message) : this._(show: true,  type: ProgressType.error, message: message);

  const BulletinProgress.empty() : this._(show: false, type: ProgressType.loading, message: "");

  const BulletinProgress._({required this.show ,required this.type, required this.message});



  @override
  List<Object?> get props => [type, show, message];



}