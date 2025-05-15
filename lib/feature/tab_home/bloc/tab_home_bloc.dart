import 'dart:ui';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:jamt/feature/tab_home/tab_home.dart';
import 'package:jamt/constants/constants.dart';

part 'tab_home_event.dart';
part 'tab_home_state.dart';

class TabHomeBloc extends Bloc<TabHomeEvent, TabHomeState> {
  TabHomeBloc() : super(TabHomeState()) {
    on<DestinationSelected>(_onDestinationSelected);
  }

  void _onDestinationSelected(
      DestinationSelected event,
      Emitter<TabHomeState> emit
      ){
    emit(
      state.copyWith(
        destination: event.destination
      )
    );
  }
}
