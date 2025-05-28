import 'package:equatable/equatable.dart';

final class GuestCard extends Equatable{

  final String name;
  final String schedule;
  final String image;
  final String review;
  final String issue;
  final bool selectCard;



  @override
  List<Object?> get props => [name, schedule, image, review, issue, selectCard];

  const GuestCard({
    this.name = '',
    this.schedule = '',
    this.image = '',
    this.review = '',
    this.issue = '',
    this.selectCard = false,
  });

  GuestCard copyWith({
    String? name,
    String? schedule,
    String? image,
    String? review,
    String? issue,
    bool? selectCard,
  }) {
    return GuestCard(
      name: name ?? this.name,
      schedule: schedule ?? this.schedule,
      image: image ?? this.image,
      review: review ?? this.review,
      issue: issue ?? this.issue,
      selectCard: selectCard ?? this.selectCard,
    );
  }
}