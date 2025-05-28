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
    on<OnInitTabHome>(_onIntTabHome);
    on<OnResumeTabHome>(_onResumeTabHome);
  }

  final  SubscribeNotificationUseCase _subscribeNotificationUseCase;
  bool _onInit = false;
  void _onIntTabHome(
      OnInitTabHome event,
      Emitter<TabHomeState> emit
      ) async{
     String toke = await _subscribeNotificationUseCase.call();
      emit(state.copyWith(notification: toke.isNotEmpty));
     _onInit = true;
  }

  void _onResumeTabHome(
      OnResumeTabHome event,
      Emitter<TabHomeState> emit
      ) async{
    if(_onInit){
      String toke = await _subscribeNotificationUseCase.call();
      emit(state.copyWith(notification: toke.isNotEmpty));
    }
  }

  void _onDestinationSelected(
      DestinationSelected event,
      Emitter<TabHomeState> emit
      ) async {
      emit(
        state.copyWith(
          destination: event.destination
        ));
      if(event.destination == TabDestination.bulletin){
        String toke = await _subscribeNotificationUseCase.call();
        emit(state.copyWith(notification: toke.isNotEmpty));
      }

  }
}
