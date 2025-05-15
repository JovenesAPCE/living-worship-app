part of 'tab_home_bloc.dart';

final class TabHomeState extends Equatable {
  const TabHomeState({
    this.progress = false,
    this.destination = TabDestination.home,
    this.destinations = const [
      TabDestination.guide,
      TabDestination.schedule,
      TabDestination.home,
      TabDestination.map,
      TabDestination.menu,

      TabDestination.activities,
      TabDestination.guests,
      TabDestination.bulletin,
      TabDestination.workshops,
      TabDestination.sessions,
      TabDestination.tourism,
      TabDestination.stands,
      TabDestination.mainObjectives,
      TabDestination.event,

    ]
  });

  final bool progress;
  final List<TabDestination> destinations;
  final TabDestination destination;
  TabHomeState copyWith({
    bool? progress,
    List<TabDestination>? destinations,
    TabDestination? destination,
    List<TabDestination>? destinationsNavBar,
  }) {
    return TabHomeState(
        progress: progress ?? this.progress,
        destinations: destinations ?? this.destinations,
        destination: destination ?? this.destination,
    );
  }

  @override
  List<Object?> get props => [progress, destinations, destination];
}
