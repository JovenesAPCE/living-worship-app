part of 'navigation_bloc.dart';

class NavigationState extends Equatable {
   const NavigationState._({
    this.initial = false,
    this.status = AuthStatus.unknown,
    this.user = User.empty,
    this.destination = Destination.tabHome,
    this.forceUpdate = 0,
    this.destinations = const [
      Destination.tabHome,
      Destination.qrScan,
      Destination.profile,
      Destination.logout,
    ]
  });

  const NavigationState.unknown() : this._();

  const NavigationState.authenticated(User user)
      : this._(status: AuthStatus.authenticated, user: user, destination: Destination.tabHome, initial: true);

  const NavigationState.unauthenticated()
      : this._(status: AuthStatus.unauthenticated);

  final AuthStatus status;
  final User user;
  final List<Destination> destinations;
  final Destination destination;
  final bool initial;
  final int forceUpdate;




  @override
  List<Object> get props => [status, user, destinations, destination, initial, forceUpdate];

   NavigationState copyWith({
     AuthStatus? status,
     User? user,
     List<Destination>? destinations,
     Destination? destination,
     bool? initial,
     int? forceUpdate,
   }) {
     return NavigationState._(
       status: status ?? this.status,
       user: user ?? this.user,
       destinations: destinations ?? this.destinations,
       destination: destination ?? this.destination,
       initial: initial ?? this.initial,
       forceUpdate: forceUpdate ?? this.forceUpdate,
     );
   }
}