import 'package:equatable/equatable.dart';

final class GuestCard extends Equatable{

  final String name;
  final String schedule;
  final String image;

  const GuestCard({this.name = "", this.schedule = "", this.image = ""});

  @override
  List<Object?> get props => [name, schedule, image];

}