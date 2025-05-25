import 'dart:ui';

import 'package:bloc/bloc.dart';
import 'package:domain/domain.dart';
import 'package:equatable/equatable.dart';
import 'package:jamt/feature/tab_home/tab_home.dart';
import 'package:jamt/constants/constants.dart';

part 'tab_home_event.dart';
part 'tab_home_state.dart';

class TabHomeBloc extends Bloc<TabHomeEvent, TabHomeState> {
  TabHomeBloc({
    required SubscribeNotificationUseCase subscribeNotificationUseCase
}) : _subscribeNotificationUseCase = subscribeNotificationUseCase,
        super(TabHomeState()) {
    on<DestinationSelected>(_onDestinationSelected);
    on<IntTabHome>(_onIntTabHome);
  }

  final  SubscribeNotificationUseCase _subscribeNotificationUseCase;

  void _onIntTabHome(
      IntTabHome event,
      Emitter<TabHomeState> emit
      ) async{

    await _subscribeNotificationUseCase.call();

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
