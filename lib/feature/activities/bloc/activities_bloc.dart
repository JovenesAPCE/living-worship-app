import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:jamt/feature/activities/activities.dart';
import 'package:jamt/constants/constants.dart';

part 'activities_event.dart';
part 'activities_state.dart';

class ActivitiesBloc extends Bloc<ActivitiesEvent, ActivitiesState> {
  ActivitiesBloc() : super(ActivitiesState()) {
    on<ActivitySelected>(_onActivitySelected);
  }

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

  }
}
