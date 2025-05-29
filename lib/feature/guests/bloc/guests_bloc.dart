import 'package:bloc/bloc.dart';
import 'package:domain/domain.dart';
import 'package:equatable/equatable.dart';
import 'package:jamt/feature/guests/guests.dart';
import 'package:jamt/constants/constants.dart';

part 'guests_event.dart';
part 'guests_state.dart';

class GuestsBloc extends Bloc<GuestsEvent, GuestsState> {
  GuestsBloc({
    required  LogEventUseCase logEventUseCase
}) : _logEventUseCase = logEventUseCase,
        super(GuestsState()) {
    on<TabSelected>(_onTabSelected);
    on<GuestsSelected>(_onGuestsSelected);
  }

  final LogEventUseCase _logEventUseCase;

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
    _logEventUseCase.call(name: "GuestsSelected", parameters: {
      "name": event.guestCard.name
    });
  }

  void _onTabSelected(TabSelected event,  Emitter<GuestsState> emit) {
    emit(state.copyWith(
        selectedIndex:  event.selectedIndex
    ));
    _logEventUseCase.call(name: "GuestsTabSelected", parameters: {
      "selectedIndex": event.selectedIndex
    });
  }
}
