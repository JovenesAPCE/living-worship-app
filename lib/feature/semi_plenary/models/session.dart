import 'package:equatable/equatable.dart';

class Session extends Equatable {

  final String id;
  final String title;
  final String group;
  final bool? checkIn;
  final bool? checkOut;



  @override
  List<Object?> get props => [id, title, group, checkIn, checkOut];

  const Session({
    this.id = '',
    this.title = '',
    this.group = '',
    this.checkIn,
    this.checkOut,
  });

  Session copyWith({
    String? id,
    String? title,
    String? group,
    bool? checkIn,
    bool? checkOut,
  }) {
    return Session(
      id: id ?? this.id,
      title: title ?? this.title,
      group: group ?? this.group,
      checkIn: checkIn ?? this.checkIn,
      checkOut: checkOut ?? this.checkOut,
    );
  }
}