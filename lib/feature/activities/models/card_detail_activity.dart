 import 'package:equatable/equatable.dart';

final class CardDetailActivity extends Equatable{

  final String body;
  final String image;

  const CardDetailActivity({this.body = "", this.image = ""});

  @override
  List<Object?> get props => [body, image];

}