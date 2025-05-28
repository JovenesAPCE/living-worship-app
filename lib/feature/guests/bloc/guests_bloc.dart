import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:jamt/feature/guests/guests.dart';
import 'package:jamt/constants/constants.dart';

part 'guests_event.dart';
part 'guests_state.dart';

class GuestsBloc extends Bloc<GuestsEvent, GuestsState> {
  GuestsBloc() : super(GuestsState()) {
    on<TabSelected>(_onTabSelected);
    on<GuestsSelected>(_onGuestsSelected);
  }

  void _onGuestsSelected(GuestsSelected event,  Emitter<GuestsState> emit) {
    final updatedTabs = state.tabs.map((tab) {
      final updatedGuests = tab.guests.map((guest) {
        if (guest == event.guestCard) {
          // Cambia el valor de selectCard (toggle)
          return guest.copyWith(selectCard: !guest.selectCard);
        }
        return guest;
      }).toList();

      return tab.copyWith(guests: updatedGuests);
    }).toList();
    emit(
      state.copyWith(
        tabs: updatedTabs
      )
    );
  }

  void _onTabSelected(TabSelected event,  Emitter<GuestsState> emit) {
    emit(state.copyWith(
        selectedIndex:  event.selectedIndex
    ));

  }
}
