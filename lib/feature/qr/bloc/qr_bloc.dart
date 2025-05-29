import 'package:bloc/bloc.dart';
import 'package:domain/domain.dart';
import 'package:entities/entities.dart';
import 'package:equatable/equatable.dart';
import 'package:jamt/feature/qr/models/models.dart';

part 'qr_event.dart';

part 'qr_state.dart';

class QrBloc extends Bloc<QrEvent, QrState> {
  QrBloc({
    required DecryptSemiPlenaryQr decryptSemiPlenaryQr,
    required RegisterSemiPlenaryCheckInUseCase registerSemiPlenaryCheckInUseCase,
    required RegisterSemiPlenaryCheckOutUseCase registerSemiPlenaryCheckOutUseCase,
    required  LogEventUseCase logEventUseCas,
  }) : _decryptSemiPlenaryQr = decryptSemiPlenaryQr,
       _registerSemiPlenaryCheckInUseCase = registerSemiPlenaryCheckInUseCase,
       _registerSemiPlenaryCheckOutUseCase = registerSemiPlenaryCheckOutUseCase,
        _logEventUseCas = logEventUseCas,
       super(QrState()) {
    on<QRPageSubscriptionRequested>(_onQRPageSubscriptionRequested);
    on<CodeScanData>(_onCodeScanData);
    on<QRClearMessageRequested>(_onQRClearMessageRequested);
  }

  final DecryptSemiPlenaryQr _decryptSemiPlenaryQr;
  final RegisterSemiPlenaryCheckInUseCase _registerSemiPlenaryCheckInUseCase;
  final RegisterSemiPlenaryCheckOutUseCase _registerSemiPlenaryCheckOutUseCase;
  final LogEventUseCase _logEventUseCas;
  int readQr = 0;
  Set<String> logs = <String>{};
  void _onQRPageSubscriptionRequested(
    QRPageSubscriptionRequested event,
    Emitter<QrState> emit,
  ) {
    logs.clear();
    readQr = 1;
    emit(state.copyWith(qrMessage: QRMessage.empty(), progress: false));
  }

  void _onCodeScanData(CodeScanData event, Emitter<QrState> emit) async {
    if (readQr == 1) {
      var result = await _decryptSemiPlenaryQr.call(event.code);
      await result.fold(
        (failure) async {
          if (failure is InvalidSemiPlenaryQr) {
            _emitMessageOnce(
                emit,
                QRMessage.error(
                  "El código QR no es válido o está dañado.",
                )
            );
          } else if (failure is UnknownSemiPlenaryQr) {
            _emitMessageOnce(
                emit,
                QRMessage.warning(
                  "El QR pertenece a otro tipo de evento o acción no reconocida.",
                )
            );
          }
        },
        (qrState) async {
          readQr = 0;
          if(state.qrMessage.show){
            await Future.delayed(Duration(seconds: 5));
          }else {
            await Future.delayed(Duration(seconds: 1));
          }
          emit(state.copyWith(progress: true));
          print("qrState.status: ${qrState.status}");
          if (qrState.status == QrStatus.checkIn) {
            await _registerCheckInSemiPlenary(qrState.data, emit);
          }else if(qrState.status == QrStatus.checkOut){
            await _registerCheckOutSemiPlenary(qrState.data, emit);
          }

        },
      );
    }
  }

  void _onQRClearMessageRequested(event, emit) {
    emit(
      state.copyWith(
        qrMessage: QRMessage.empty(),
        progress: false, // asume que tienes un constructor vacío
      ),
    );
  }

  Future<void> _registerCheckInSemiPlenary(
    QRData qrData,
    Emitter<QrState> emit,
  ) async {
    var result = await _registerSemiPlenaryCheckInUseCase.call(qrData);
    result.fold(
      (failure) {
        readQr = 1;
        print("failure $failure");
        if (failure is UserNotExist) {
          _emitMessageOnce(
            emit,
              QRMessage.error(
                'No pudimos reconocer tu usuario. Asegúrate de estar registrado en el evento.',
              )
          );
        } else if (failure is SessionNotExist) {
          _emitMessageOnce(
            emit,
            QRMessage.error(
              'Tu sesión ha expirado. Vuelve a iniciar sesión para escanear el QR.',
            ),
          );
        } else if (failure is NoInternetRegisterSemiPlenary) {
          _emitMessageOnce(
            emit,
            QRMessage.warning(
              'Parece que no tienes conexión a internet. Conéctate y vuelve a intentarlo.',
            ),
          );
        } else if (failure is UnknownRegisterSemiPlenary ||
            failure is UnknownRegisterSemiPlenaryQr) {
          _emitMessageOnce(
            emit,
            QRMessage.warning(
              'Ocurrió un error inesperado al intentar registrar tu ingreso. Intenta nuevamente en unos segundos.',
            ),
          );
        } else if (failure is UserHasRegisteredInSemiPlenary) {
          _emitMessageOnce(
            emit,
            QRMessage.info(
              'Ya has registrado tu ingreso a esta semiplenaria.',
            ),
          );
        } else if (failure is UserHasNotRegisteredInSemiPlenary) {
          _emitMessageOnce(
            emit,
            QRMessage.warning(
              'Aún no has registrado tu ingreso a esta semiplenaria. Escanea el QR correcto para registrar tu asistencia.',
            ),
          );
        } else if (failure is InvalidServerTimestampRegisterSemiPlenaryQr) {
          _emitMessageOnce(
            emit,
            QRMessage.warning(
              'Este QR no está habilitado. El ingreso a esta semiplenaria solo se permite en el horario programado.',
            ),
          );
        } else {
          _emitMessageOnce(
            emit,
            QRMessage.error(
              'Algo salió mal. Por favor intenta escanear nuevamente o consulta con un voluntario.',
            ),
          );
        }
      },
      (right) {
        readQr = 0;
        emit(state.copyWith(qrMessage: QRMessage.empty()));
        print("right");
        _messageOnce("Success");
      },
    );
  }

  Future<void> _registerCheckOutSemiPlenary(
    QRData qrData,
    Emitter<QrState> emit,
  ) async {
    var result = await _registerSemiPlenaryCheckOutUseCase.call(qrData);
    result.fold(
      (failure) {
        readQr = 1;
        print("failure $failure");
        if (failure is UserNotExist) {
          _emitMessageOnce(
            emit,
            QRMessage.error(
              'No pudimos reconocer tu usuario. Asegúrate de estar registrado en el evento.',
            ),
          );
        } else if (failure is SessionNotExist) {
          _emitMessageOnce(
            emit,
            QRMessage.error(
              'Tu sesión ha expirado. Vuelve a iniciar sesión para escanear el QR.',
            ),
          );
        } else if (failure is NoInternetRegisterSemiPlenary) {
          _emitMessageOnce(
            emit,
            QRMessage.warning(
              'Parece que no tienes conexión a internet. Conéctate y vuelve a intentarlo.',
            ),
          );
        } else if (failure is UnknownRegisterSemiPlenary ||
            failure is UnknownRegisterSemiPlenaryQr) {
          _emitMessageOnce(
            emit,
            QRMessage.warning(
              'Ocurrió un error inesperado al intentar registrar tu ingreso. Intenta nuevamente en unos segundos.',
            ),
          );
        } else if (failure is UserHasRegisteredInSemiPlenary) {
          _emitMessageOnce(
            emit,
            QRMessage.info(
              'Ya has registrado tu ingreso a esta semiplenaria.',
            ),
          );
        } else if (failure is UserHasNotRegisteredInSemiPlenary) {
          _emitMessageOnce(
            emit,
            QRMessage.warning(
              'Aún no has registrado tu ingreso a esta semiplenaria. Escanea el QR correcto para registrar tu asistencia.',
            ),
          );
        } else if (failure is InvalidServerTimestampRegisterSemiPlenaryQr) {
          _emitMessageOnce(
            emit,
            QRMessage.warning(
              'Este QR no está habilitado. El ingreso a esta semiplenaria solo se permite en el horario programado.',
            ),
          );
        } else {
          _emitMessageOnce(
            emit,
            QRMessage.error(
              'Algo salió mal. Por favor intenta escanear nuevamente o consulta con un voluntario.',
            ),
          );
        }
      },
      (right) {
        readQr = 0;
        _messageOnce("Success");
        print("right");
      },
    );
  }

  void _messageOnce(String message,) {
    if (!logs.contains(message)) {
      logs.add(message);
    }
  }
  void _emitMessageOnce(
      Emitter<QrState> emit,
      QRMessage message,
      ) {
    if (!logs.contains(message.message)) {
      logs.add(message.message);
    }
    emit(state.copyWith(progress: false, qrMessage: message));
  }

  @override
  Future<void> close() async {
    for (var log in logs) {
      await _logEventUseCas.call(name: log);
    }
    logs.clear();
    return super.close();
  }
}
