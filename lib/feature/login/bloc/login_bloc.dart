import 'package:bloc/bloc.dart';
import 'package:domain/domain.dart';
import 'package:equatable/equatable.dart';
import 'package:jamt/feature/login/login.dart';
import 'package:formz/formz.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc({
    required LogInUseCase logIn,
    required ConfigUserUseCase configUserUseCase,
  })  : _logIn = logIn,
        _configUserUseCase = configUserUseCase,
        super(const LoginState()) {
    on<LoginUsernameChanged>(_onUsernameChanged);
    on<LoginBirthYearChanged>(_onPasswordChanged);
    on<LoginSubmitted>(_onSubmitted);
    on<IntLogin>(_onIntLogin);
  }

  final LogInUseCase _logIn;
  final ConfigUserUseCase  _configUserUseCase;

  void _onIntLogin(
      IntLogin event,
      Emitter<LoginState> emit,
      ){

  }

  void _onUsernameChanged(
      LoginUsernameChanged event,
      Emitter<LoginState> emit,
      ) {
    final username = Username.pure(event.username);
    emit(
      state.copyWith(
        username: username,
        loginToast: LoginToast.hide(),
      ),
    );
  }

  void _onPasswordChanged(
      LoginBirthYearChanged event,
      Emitter<LoginState> emit,
      ) {
    final birthYear = BirthYear.pure(event.birthYear);
    emit(
      state.copyWith(
        birthYear: birthYear,
        loginToast: LoginToast.hide(),
      ),
    );
  }

  Future<void> _onSubmitted(
      LoginSubmitted event,
      Emitter<LoginState> emit,
      ) async {
    final username = Username.dirty(state.username.value);
    final birthYear = BirthYear.dirty(state.birthYear.value);

    emit(state.copyWith(
      username: username,
      birthYear: birthYear,
      loginToast: LoginToast.hide(),
      isValid: Formz.validate([username, birthYear]),
    ));

    if (state.isValid) {
      emit(state.copyWith(
          progress: true,
          loginToast: LoginToast.hide()));
      var result = await _logIn.call(state.username.value, state.birthYear.value,);
      result.fold(
              (failure) => {
            if (failure is InvalidCredentials) {
              emit(state.copyWith(
                  progress: false,
                  loginToast: LoginToast.show("Documento incorrecto o no registrado para este evento")))
            } else if (failure is NoInternet) {
              emit(state.copyWith(
                  progress: false,
                  loginToast: LoginToast.show( "No hay conexión a internet.")))
            } else if (failure is Timeout) {
              emit(state.copyWith(
                  progress: false,
                  loginToast: LoginToast.show( "Tiempo de espera agotado. Inténtalo nuevamente.")))
            } else {
              emit(state.copyWith(
                  progress: false,
                  loginToast: LoginToast.show( "Error inesperado")))
            }
          },
              (right) {
                emit(state.copyWith(
                    progress: false,
                    loginToast: LoginToast.hide()
                ));
                _configUserUseCase.call(state.username.value,  state.birthYear.value);
              });
    }
  }
}