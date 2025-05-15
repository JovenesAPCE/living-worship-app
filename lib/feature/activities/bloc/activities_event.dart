part of 'activities_bloc.dart';

sealed class ActivitiesEvent extends Equatable {
  const ActivitiesEvent();
  @override
  List<Object?> get props => [];
}

final class ActivitySelected extends ActivitiesEvent {
  const ActivitySelected(this.cardActivity);

  final CardActivity cardActivity;

  @override
  List<Object> get props => [cardActivity];
}
