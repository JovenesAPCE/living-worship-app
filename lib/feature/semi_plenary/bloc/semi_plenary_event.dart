part of 'semi_plenary_bloc.dart';

class SemiPlenaryEvent extends Equatable {

  const SemiPlenaryEvent();

  @override
  List<Object?> get props => [];

}

final class LoadSemiPlenary extends SemiPlenaryEvent {}

final class TabSelected extends SemiPlenaryEvent {
  const TabSelected(this.selectedIndex);

  final int selectedIndex;

  @override
  List<Object> get props => [selectedIndex];

}

final class SessionSelected extends SemiPlenaryEvent {
  const SessionSelected({required this.selected, required this.groupSelected});

  final Session selected;
  final SessionGroup groupSelected;

  @override
  List<Object> get props => [selected, groupSelected];

}


final class SessionSave extends SemiPlenaryEvent {
  final SessionGroup groupSelected;

  const SessionSave({required this.groupSelected});

  @override
  List<Object> get props => [ groupSelected];
}

final class SessionClose extends SemiPlenaryEvent {
  const SessionClose({ required this.groupSelected});
  final SessionGroup groupSelected;
  @override
  List<Object> get props => [groupSelected];
}


final class SessionRegister extends SemiPlenaryEvent {
  final int refreshId;
  const SessionRegister(this.refreshId);
  @override
  List<Object> get props => [refreshId];
}
