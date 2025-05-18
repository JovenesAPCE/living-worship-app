part of 'user_bloc.dart';

class UserState extends Equatable {

  final UserPageState pageState;
  final List<UserDecision> decisions;
  final bool close;


  @override
  List<Object?> get props => [pageState, decisions, close];

  const UserState({
    this.close = false,
    this.pageState = UserPageState.pageDecision,
    this.decisions = const [
      UserDecision(
        id: 1,
        selected: true,
        name: 'Sí, deseo ser un predicador CALEB'
      ),
      UserDecision(
          id: 2,
          selected: false,
          name: 'Tal vez más adelante'
      ),
      UserDecision(
          id: 3,
          selected: false,
          name: 'No, no me siento preparado'
      ),
    ],
  });

  UserState copyWith({
    UserPageState? pageState,
    List<UserDecision>? decisions,
    bool? close,
  }) {
    return UserState(
      pageState: pageState ?? this.pageState,
      decisions: decisions ?? this.decisions,
      close: close ?? this.close
    );
  }
}
