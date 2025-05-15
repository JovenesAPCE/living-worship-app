 import 'package:equatable/equatable.dart';
import 'package:jamt/feature/activities/models/card_detail_activity.dart';

final class CardActivity extends Equatable{
  final String title;
  final List<CardDetailActivity> details;

  const CardActivity({this.title = "", this.details = const []});

  @override
  List<Object?> get props => [title, details];

}