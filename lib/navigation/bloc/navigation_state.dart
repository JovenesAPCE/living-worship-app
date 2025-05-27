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
      Destination.mana,
      Destination.updateUserDate,
      Destination.logout,
    ],
    this.notificationReceived = const Notification()
  });

  const NavigationState.unknown() : this._();

  const NavigationState.authenticated(User user, bool wasOpenNotification)
      : this._(status: AuthStatus.authenticated, user: user, destination: wasOpenNotification? Destination.bulletins: Destination.tabHome, initial: true);

  const NavigationState.unauthenticated()
      : this._(status: AuthStatus.unauthenticated);

  final AuthStatus status;
  final User user;
  final List<Destination> destinations;
  final Destination destination;
  final bool initial;
  final int forceUpdate;
  final Notification notificationReceived;



  @override
  List<Object> get props => [status, user, destinations, destination, initial, forceUpdate, notificationReceived];

   NavigationState copyWith({
     AuthStatus? status,
     User? user,
     List<Destination>? destinations,
     Destination? destination,
     bool? initial,
     int? forceUpdate,
     Notification? notificationReceived
   }) {
     return NavigationState._(
       status: status ?? this.status,
       user: user ?? this.user,
       destinations: destinations ?? this.destinations,
       destination: destination ?? this.destination,
       initial: initial ?? this.initial,
       forceUpdate: forceUpdate ?? this.forceUpdate,
         notificationReceived: notificationReceived??this.notificationReceived
     );
   }
}