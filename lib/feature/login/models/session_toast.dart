import 'package:equatable/equatable.dart';

class LoginToast extends Equatable {

  final String message;
  final bool show;

  const LoginToast.hide() : this._(message: "", show: false);
  const LoginToast.show(String message) : this._(message: message, show: true);

  const LoginToast._({required this.message, required this.show});

  @override
  List<Object?> get props => [message];

}