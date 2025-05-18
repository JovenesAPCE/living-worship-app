import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import '../user.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  UserBloc() : super(UserState()) {
    on<OnSelectedDecision>(_onSelectedDecision);
    on<OnCompleteDecision>(_onCompleteDecision);
    on<OnUserScreenClose>(_onUserScreenClose);
  }

  _onSelectedDecision(OnSelectedDecision event, Emitter<UserState> emit){
      UserDecision select = event.userDecision;
      UserDecision oldSelect = state.decisions.singleWhere((element) {
        return element.selected;
      },
        orElse: () => UserDecision(id: 0, name: "", selected: false)
      );
      var list = state.decisions.map((decision){
        if(decision == select){
          return decision.copyWith(
            selected: true
          );
        }else if(decision == oldSelect){
          return decision.copyWith(
              selected: false
          );
        }
        return decision;
      }).toList();


      emit(state.copyWith(
        decisions: list
      ));
  }

  _onCompleteDecision(OnCompleteDecision event, Emitter<UserState> emit){
    UserDecision select = state.decisions.singleWhere((element) {
      return element.selected;
    },
        orElse: () => UserDecision(id: 0, name: "", selected: false)
    );
    if(select.id == 1){
      emit(state.copyWith(
        pageState: UserPageState.pageTwo
      ));
    }else if(select.id == 2){
      emit(state.copyWith(
          pageState: UserPageState.pageTwoVariant
      ));
    }else if(select.id == 3){
      emit(state.copyWith(
          close: true
      ));
    }
  }

  _onUserScreenClose(OnUserScreenClose event, Emitter<UserState> emit){
    if(state.pageState == UserPageState.pageDecision){
      emit(state.copyWith(
          close: true
      ));
    }else {
      emit(state.copyWith(
        pageState: UserPageState.pageDecision
      ));
    }
  }


}
