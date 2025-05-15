import 'package:equatable/equatable.dart';
import 'package:jamt/feature/guests/models/guest_card.dart';

final class GuestTab extends Equatable {

  final String title;
  final List<GuestCard> guests;

  const GuestTab({this.title = "", this.guests = const []});

  @override
  List<Object?> get props => [title, guests];

}