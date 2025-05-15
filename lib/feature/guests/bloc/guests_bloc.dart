import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:jamt/feature/guests/guests.dart';
import 'package:jamt/constants/constants.dart';

part 'guests_event.dart';
part 'guests_state.dart';

class GuestsBloc extends Bloc<GuestsEvent, GuestsState> {
  GuestsBloc() : super(GuestsState()) {
    on<TabSelected>(_onTabSelected);
  }

  void _onTabSelected(TabSelected event,  Emitter<GuestsState> emit) {
    emit(state.copyWith(
        selectedIndex:  event.selectedIndex
    ));

  }
}
