import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:domain/domain.dart';
import 'package:entities/entities.dart';
import 'package:equatable/equatable.dart';
import 'package:jamt/navigation/navigation.dart';

part 'navigation_event.dart';
part 'navigation_state.dart';

class NavigationBloc
    extends Bloc<NavigationEvent, NavigationState> {
  NavigationBloc({
    required GetAuthStatusUseCase getAuthStatus,
    required LogOutUseCase logOutUseCase,
    required GetUserUseCase getUserUseCase,
    required GetQrStatusUseCase getQrStatusUseCase
  })  : _getAuthStatus = getAuthStatus,
        _logOutUseCase = logOutUseCase,
        _getUserUseCase = getUserUseCase,
        _getQrStatusUseCase = getQrStatusUseCase,
        super(const NavigationState.unknown()) {
    on<AuthenticationSubscriptionRequested>(_onSubscriptionRequested);
    on<AuthenticationLogoutPressed>(_onLogoutPressed);
    on<NavigationPressed>(_onNavigationPressed);
    on<NavigateToFromNotification>(_onNavigateToFromNotification);
  }

  final GetAuthStatusUseCase _getAuthStatus;
  final LogOutUseCase _logOutUseCase;
  final GetUserUseCase _getUserUseCase;
  final GetQrStatusUseCase _getQrStatusUseCase;

  Future<void> _onSubscriptionRequested(
      AuthenticationSubscriptionRequested event,
      Emitter<NavigationState> emit,
      ) {

    emit.onEach(
        _getQrStatusUseCase.call(),
        onData: (status){
          switch(status){
            case QrStatus.scanning:
              return emit(state.copyWith(destination: Destination.qrScan));
            case QrStatus.checkIn:
              return emit(state.copyWith(destination: Destination.qrCheckIn));
            case QrStatus.checkOut:
              return emit(state.copyWith(destination: Destination.qrCheckOut));
            case QrStatus.hidden:
              return emit(state.copyWith(destination: Destination.tabHome));
            }
        });


    return emit.onEach(
      _getAuthStatus.call(),
      onData: (status) async {
        switch (status) {
          case AuthStatus.unauthenticated:
            return emit(const NavigationState.unauthenticated());
          case AuthStatus.authenticated:
            final user = await _tryGetUser();
            return emit(
              user != null
                  ? NavigationState.authenticated(user)
                  : const NavigationState.unauthenticated(),
            );
          case AuthStatus.unknown:
            return emit(const NavigationState.unknown());
        }
      },
      onError: addError,
    );
  }
  void _onNavigateToFromNotification(
      NavigateToFromNotification event,
      Emitter<NavigationState> emit,
      )async{

    print("_onNavigateToFromNotification");

    await Future.delayed(Duration(seconds: 1));
    emit(
        state.copyWith(
            destination: event.destination,
            initial: false,
            forceUpdate: DateTime.timestamp().millisecond
        )
    );
  }

  void _onNavigationPressed(
        NavigationPressed event,
        Emitter<NavigationState> emit,
      ){
    emit(
        state.copyWith(
            destination: event.destination,
            initial: false,
            forceUpdate: DateTime.timestamp().millisecond
        )
    );
  }

  void _onLogoutPressed(
      AuthenticationLogoutPressed event,
      Emitter<NavigationState> emit,
      ) async {
    await _logOutUseCase.call();
  }

  Future<User?> _tryGetUser() async {
    try {
      final user = await _getUserUseCase.call();
      return user;
    } catch (_) {
      return null;
    }
  }
}