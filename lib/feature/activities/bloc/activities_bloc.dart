import 'package:bloc/bloc.dart';
import 'package:domain/domain.dart';
import 'package:equatable/equatable.dart';
import 'package:jamt/feature/activities/activities.dart';
import 'package:jamt/constants/constants.dart';

part 'activities_event.dart';
part 'activities_state.dart';

class ActivitiesBloc extends Bloc<ActivitiesEvent, ActivitiesState> {
  ActivitiesBloc({
    required LogEventUseCase logEventUseCase,
  }): _logEventUseCase = logEventUseCase,
        super(ActivitiesState()) {
    on<ActivitySelected>(_onActivitySelected);
  }

  final LogEventUseCase _logEventUseCase;

  void _onActivitySelected(ActivitySelected event,  Emitter<ActivitiesState> emit) {
    if(event.cardActivity !=  state.selectCardActivities){
      emit(state.copyWith(
          selectCardActivities: event.cardActivity
      ));
    }else{
      emit(state.copyWith(
          selectCardActivities: CardActivity()
      ));
    }
    _logEventUseCase.call(name: "ActivitySelected", parameters: {
      "title": event.cardActivity.title
    });
  }
}
