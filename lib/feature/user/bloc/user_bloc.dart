import 'package:bloc/bloc.dart';
import 'package:domain/domain.dart';
import 'package:entities/entities.dart';
import 'package:equatable/equatable.dart';
import '../user.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  UserBloc({
    required SaveUserDecisionUseCase saveUserDecisionUseCase,
    required GetPathWhatsAppGroupUseCase getPathWhatsAppGroupUseCase,
    required GetUserDecisionUseCase getUserDecisionUseCase,
  }) :
        _saveUserDecisionUseCase = saveUserDecisionUseCase,
        _getPathWhatsAppGroupUseCase = getPathWhatsAppGroupUseCase,
        _getUserDecisionUseCase = getUserDecisionUseCase,
        super(UserState()) {
    on<OnSelectedDecision>(_onSelectedDecision);
    on<OnCompleteDecision>(_onCompleteDecision);
    on<OnUserScreenClose>(_onUserScreenClose);
    on<OnEmailChanged>(_onEmailChanged);
    on<OnCellphoneChanged>(_onCellphoneChanged);
    on<OnReConfirmDecision>(_onReConfirmDecision);
    on<OnMaybeLaterDecision>(_onMaybeLaterDecision);
    on<ClearMessageRequested>(_onClearMessageRequested);
    on<OpenWhatsAppGroup>(_openWhatsAppGroup);
    on<RequestAddUser>(_requestAddUser);
  }
  final GetPathWhatsAppGroupUseCase _getPathWhatsAppGroupUseCase;
  final SaveUserDecisionUseCase _saveUserDecisionUseCase;
  final GetUserDecisionUseCase _getUserDecisionUseCase;

  _requestAddUser(RequestAddUser event, Emitter<UserState> emit) async{
    emit(state.copyWith(
       progress: true,
    ));
   var result = await _getPathWhatsAppGroupUseCase.call();

   await result.fold((error) async {
     String errorMessage;

     if (error is UserNotExistRegisterUserDecision) {
       errorMessage = "El usuario no existe. Verifica tu sesión.";
     } else if (error is SessionNotExistRegisterUserDecision) {
       errorMessage = "La sesión del usuario no existe.";
     } else if (error is SessionNotFoundRegisterUserDecision) {
       errorMessage = "Sesión no encontrada. Intenta ingresar de nuevo.";
     } else if (error is NoInternetRegisterUserDecision) {
       errorMessage = "Sin conexión a internet. Por favor verifica tu red.";
     } else if (error is UnknownRegisterUserDecision) {
       errorMessage = "Ocurrió un error inesperado. Intenta más tarde.";
     } else {
       errorMessage = "Error desconocido.";
     }

     emit(state.copyWith(
       progress: false,
       userMessage: UserMessage.error(errorMessage),
     ));
   }, (success) async {
     emit(state.copyWith(
       progress: false,
       whatsAppGroup: success,
     ));
   });

    var result2 = await _getUserDecisionUseCase.call();
    await result2.fold((error) async {
      String errorMessage;

      if (error is UserNotExistRegisterUserDecision) {
        errorMessage = "El usuario no existe. Verifica tu sesión.";
      } else if (error is SessionNotExistRegisterUserDecision) {
        errorMessage = "La sesión del usuario no existe.";
      } else if (error is SessionNotFoundRegisterUserDecision) {
        errorMessage = "Sesión no encontrada. Intenta ingresar de nuevo.";
      } else if (error is NoInternetRegisterUserDecision) {
        errorMessage = "Sin conexión a internet. Por favor verifica tu red.";
      } else if (error is UnknownRegisterUserDecision) {
        errorMessage = "Ocurrió un error inesperado. Intenta más tarde.";
      } else {
        errorMessage = "Error desconocido.";
      }

      emit(state.copyWith(
        progress: false,
        userMessage: UserMessage.error(errorMessage),
      ));
    }, (success) async {
      emit(state.copyWith(
        progress: false,
        pageState: success? UserPageState.pageSuccess: UserPageState.pageDecision,
      ));
    });

  }

  _openWhatsAppGroup(OpenWhatsAppGroup event, Emitter<UserState> emit){
    emit(state.copyWith(
      openLaunchUrlNative: state.whatsAppGroup
    ));
  }

  void _onClearMessageRequested(event, emit) {
    emit(
      state.copyWith(
        userMessage: UserMessage.empty(),
      ),
    );
  }

  _onReConfirmDecision(OnReConfirmDecision event, Emitter<UserState> emit) async{
    if(!state.phoneError && !state.emailError){
      if(state.phone.isEmpty){
        emit(state.copyWith(
            emailError: true,
            emailErrorText: "Este campo es obligatorio"
        ));
      }
      if(state.email.isEmpty){
        emit(state.copyWith(
          phoneError: true,
          emailErrorText: "Este campo es obligatorio",
        ));
      }
      if(state.phone.isNotEmpty && state.email.isNotEmpty){
        emit(state.copyWith(
            progress: true
        ));
        await Future.delayed(const Duration(seconds: 1));
        var result = await _saveUserDecisionUseCase.call(RegisterUserDecision(
            cellPhone: state.phone,
            email: state.email,
            decision: CalebDecision.yesIPreacher
        ));
        result.fold((error){
          String errorMessage;

          if (error is UserNotExistRegisterUserDecision) {
            errorMessage = "El usuario no existe. Verifica tu sesión.";
          } else if (error is SessionNotExistRegisterUserDecision) {
            errorMessage = "La sesión del usuario no existe.";
          } else if (error is SessionNotFoundRegisterUserDecision) {
            errorMessage = "Sesión no encontrada. Intenta ingresar de nuevo.";
          } else if (error is NoInternetRegisterUserDecision) {
            errorMessage = "Sin conexión a internet. Por favor verifica tu red.";
          } else if (error is UnknownRegisterUserDecision) {
            errorMessage = "Ocurrió un error inesperado. Intenta más tarde.";
          } else {
            errorMessage = "Error desconocido.";
          }

          emit(state.copyWith(
            progress: false,
            userMessage: UserMessage.error(errorMessage),
          ));
        }, (success){

          emit(state.copyWith(
              progress: false,
              close: false,
              pageState: UserPageState.pageSuccess,
              openLaunchUrlNative: ''
          ));
        });
      }else{
        emit(state.copyWith(
            progress: false,
            userMessage: UserMessage.info("Revisa los campos: celular y correo electrónico.")
        ));
      }
    }else{
      emit(state.copyWith(
          progress: false,
          userMessage: UserMessage.info("Revisa los campos: celular y correo electrónico.")
      ));
    }
  }

  _onMaybeLaterDecision(OnMaybeLaterDecision event, Emitter<UserState> emit) async{
    if(!state.phoneError && !state.emailError){
      if(state.phone.isEmpty){
        emit(state.copyWith(
            emailError: true,
            emailErrorText: "Este campo es obligatorio"
        ));
      }
      if(state.email.isEmpty){
        emit(state.copyWith(
          phoneError: true,
          emailErrorText: "Este campo es obligatorio",
        ));
      }
      if(state.phone.isNotEmpty && state.email.isNotEmpty){
        emit(state.copyWith(
            progress: true
        ));
        await Future.delayed(const Duration(seconds: 1));
        var result = await _saveUserDecisionUseCase.call(RegisterUserDecision(
            cellPhone: state.phone,
            email: state.email,
            decision: CalebDecision.maybeLater
        ));
        result.fold((error){
          String errorMessage;

          if (error is UserNotExistRegisterUserDecision) {
            errorMessage = "El usuario no existe. Verifica tu sesión.";
          } else if (error is SessionNotExistRegisterUserDecision) {
            errorMessage = "La sesión del usuario no existe.";
          } else if (error is SessionNotFoundRegisterUserDecision) {
            errorMessage = "Sesión no encontrada. Intenta ingresar de nuevo.";
          } else if (error is NoInternetRegisterUserDecision) {
            errorMessage = "Sin conexión a internet. Por favor verifica tu red.";
          } else if (error is UnknownRegisterUserDecision) {
            errorMessage = "Ocurrió un error inesperado. Intenta más tarde.";
          } else {
            errorMessage = "Error desconocido.";
          }

          emit(state.copyWith(
            userMessage: UserMessage.error(errorMessage),
            progress: false,
          ));
        }, (success){

            emit(state.copyWith(
                progress: false,
                close: false,
                pageState: UserPageState.pageSuccess,
                openLaunchUrlNative: ''
            ));
        });
      }else{
        emit(state.copyWith(
            progress: false,
            userMessage: UserMessage.info("Revisa los campos: celular y correo electrónico.")
        ));
      }
    }else{
      emit(state.copyWith(
          progress: false,
          userMessage: UserMessage.info("Revisa los campos: celular y correo electrónico.")
      ));
    }
  }

  _onCellphoneChanged(OnCellphoneChanged event, Emitter<UserState> emit){
    String value = event.cellphone;
    bool phoneError = false;
    String phoneErrorText = "";
    final cleaned = value.replaceAll(RegExp(r'^\+51\s*'), '');
    //final fullNumber = '+51 $cleaned';
    if (!RegExp(r'^\d{9}$').hasMatch(cleaned)) {
      phoneError = true;
      phoneErrorText = 'Número inválido';
    } else {
      phoneError = false;
      phoneErrorText = "";
    }
    emit(state.copyWith(
      phone: event.cellphone,
      phoneErrorText: phoneErrorText,
      phoneError: phoneError
    ));
  }


  _onEmailChanged(OnEmailChanged event, Emitter<UserState> emit){
    bool emailError = false;
    String emailErrorText = "";
    if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(event.email)) {
      emailError = true;
      emailErrorText = 'Correo inválido';
    } else {
      emailError = false;
      emailErrorText = "";
    }
    print("error: $emailErrorText");
    emit(state.copyWith(
        email: event.email,
      emailError: emailError,
      emailErrorText: emailErrorText
    ));
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
    }else if(state.pageState == UserPageState.pageSuccess){
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
