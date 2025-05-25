
import 'dart:math';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jamt/constants/constants.dart';
import 'package:equatable/equatable.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() :
        super(HomeState()) {
    on<TabHomeInitialize>(_onInitialize);
  }


  void _onInitialize(TabHomeInitialize event, Emitter<HomeState> emit) {
    final random = Random();

    final list = [
      AppImages.homeActivityOne,
      AppImages.homeActivityTwo,
      AppImages.homeActivityThree,
      AppImages.homeActivityFour,
      AppImages.homeActivityFive,
      AppImages.homeActivitySix,
      AppImages.homeActivitySeven,
      AppImages.homeActivityEight,
      AppImages.homeActivityNine,
      AppImages.homeActivityTen,
      AppImages.homeActivityEleven,
      AppImages.homeActivityTwelve
    ];

    list.shuffle();

    final Map<String, List<String>> allCards = {
      'Semiplenarias': [AppImages.homeWorkshops, AppImages.homeWorkshops2],
      'Invitados': [AppImages.homeGuests],
      'Boletín': [AppImages.homeBulletin],
      '¡Escanea tu asistencia!': [AppImages.homeQR],
      'Objetivos Principales': [AppImages.homeMainObjectives],
      'Mapa': [AppImages.homeStands],
    };

    final imageByTitle = {
      for (final entry in allCards.entries)
        entry.key: (entry.value.length == 1 || random.nextDouble() < 0.7)
            ? entry.value.first
            : entry.value[random.nextInt(entry.value.length)]
    };

    emit(state.copyWith(
      imageByTitle: imageByTitle,
      shuffledList: list
    ));
  }
}
