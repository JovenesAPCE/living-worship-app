part of 'navigation_bloc.dart';

sealed class NavigationEvent extends Equatable{
  const NavigationEvent();
  @override
  List<Object?> get props => [];
}

final class AuthenticationSubscriptionRequested extends NavigationEvent {}

final class AuthenticationLogoutPressed extends NavigationEvent {}

final class NavigationPressed extends NavigationEvent {

  final Destination destination;
  @override
  List<Object?> get props => [destination];

  const NavigationPressed(this.destination);
}

final class NavigateToFromNotification extends NavigationEvent {

  final Destination destination;
  @override
  List<Object?> get props => [destination];

  const NavigateToFromNotification(this.destination);
}

