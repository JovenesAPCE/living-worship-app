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
    required GetQrStatusUseCase getQrStatusUseCase,
    required WasOpenNotificationUseCase wasOpenNotificationUseCase,
    required NotificationReceivedUseCase notificationReceivedUseCase,
    required UnsubscribeNotificationUseCase unsubscribeNotificationUseCase,
  })  : _getAuthStatus = getAuthStatus,
        _logOutUseCase = logOutUseCase,
        _getUserUseCase = getUserUseCase,
        _getQrStatusUseCase = getQrStatusUseCase,
        _wasOpenNotificationUseCase = wasOpenNotificationUseCase,
        _notificationReceivedUseCase = notificationReceivedUseCase,
        _unsubscribeNotificationUseCase = unsubscribeNotificationUseCase,
        super(const NavigationState.unknown()) {
    on<AuthenticationSubscriptionRequested>(_onSubscriptionRequested);
    on<AuthenticationLogoutPressed>(_onLogoutPressed);
    on<NavigationPressed>(_onNavigationPressed);
    on<OnTapNotification>(_onNavigateToFromNotification);
    on<OnInitNotification>(_onInitNotification);
  }

  final GetAuthStatusUseCase _getAuthStatus;
  final LogOutUseCase _logOutUseCase;
  final GetUserUseCase _getUserUseCase;
  final GetQrStatusUseCase _getQrStatusUseCase;
  final WasOpenNotificationUseCase _wasOpenNotificationUseCase;
  final NotificationReceivedUseCase _notificationReceivedUseCase;
  final UnsubscribeNotificationUseCase _unsubscribeNotificationUseCase;

  bool _initNotification = false;

  Future<void> _onInitNotification(
      OnInitNotification event,
      Emitter<NavigationState> emit,
      ) async {
    if (!_initNotification) {
      await emit.onEach(
        _notificationReceivedUseCase.call(),
        onData: (notification) {
          emit(state.copyWith(notificationReceived: notification));
        },
      );
      _initNotification = true;
    }
  }

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
            case QrStatus.none:
              emit(state.copyWith(destination: Destination.none));
              break;
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
            final wasOpenNotification = await _isWasOpenNotification();
            print("wasOpenNotification: $wasOpenNotification");
            return emit(
              user != null
                  ? NavigationState.authenticated(user, wasOpenNotification)
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
      OnTapNotification event,
      Emitter<NavigationState> emit,
      )async{
    print("_onNavigateToFromNotification");
    emit(
        state.copyWith(
            destination: Destination.bulletins,
            initial: false,
            forceUpdate: DateTime.timestamp().millisecond,
            notificationReceived: Notification()
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
    await _unsubscribeNotificationUseCase.call();
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

  Future<bool> _isWasOpenNotification() async {
    try {
      return await _wasOpenNotificationUseCase.call();
    } catch (_) {
      return false;
    }
  }
}