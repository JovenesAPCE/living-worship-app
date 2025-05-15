part of 'tab_home_bloc.dart';

sealed class TabHomeEvent extends Equatable {
  const TabHomeEvent();

  @override
  List<Object> get props => [];

}

final class DestinationSelected extends TabHomeEvent {
  const DestinationSelected(this.destination);

  final TabDestination destination;

  @override
  List<Object> get props => [destination];
}
