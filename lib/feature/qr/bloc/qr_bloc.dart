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
    required RegisterSemiPlenaryCheckInUseCase
    registerSemiPlenaryCheckInUseCase,
    required RegisterSemiPlenaryCheckOutUseCase
    registerSemiPlenaryCheckOutUseCase,
  }) : _decryptSemiPlenaryQr = decryptSemiPlenaryQr,
       _registerSemiPlenaryCheckInUseCase = registerSemiPlenaryCheckInUseCase,
       _registerSemiPlenaryCheckOutUseCase = registerSemiPlenaryCheckOutUseCase,
       super(QrState()) {
    on<QRPageSubscriptionRequested>(_onQRPageSubscriptionRequested);
    on<CodeScanData>(_onCodeScanData);
    on<QRClearMessageRequested>(_onQRClearMessageRequested);
  }

  final DecryptSemiPlenaryQr _decryptSemiPlenaryQr;
  final RegisterSemiPlenaryCheckInUseCase _registerSemiPlenaryCheckInUseCase;
  final RegisterSemiPlenaryCheckOutUseCase _registerSemiPlenaryCheckOutUseCase;
  int readQr = 0;

  void _onQRPageSubscriptionRequested(
    QRPageSubscriptionRequested event,
    Emitter<QrState> emit,
  ) {
    readQr = 1;
    emit(state.copyWith(qrMessage: QRMessage.empty(), progress: false));
  }

  void _onCodeScanData(CodeScanData event, Emitter<QrState> emit) async {
    if (readQr == 1) {
      var result = await _decryptSemiPlenaryQr.call(event.code);
      await result.fold(
        (failure) async {
          if (failure is InvalidSemiPlenaryQr) {
            emit(
              state.copyWith(
                progress: false,
                qrMessage: QRMessage.error(
                  "El código QR no es válido o está dañado.",
                ),
              ),
            );
          } else if (failure is UnknownSemiPlenaryQr) {
            emit(
              state.copyWith(
                progress: false,
                qrMessage: QRMessage.warning(
                  "El QR pertenece a otro tipo de evento o acción no reconocida.",
                ),
              ),
            );
          }
        },
        (qrState) async {
          readQr = 0;
          emit(state.copyWith(qrMessage: QRMessage.empty(), progress: true));
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
          emit(
            state.copyWith(
              progress: false,
              qrMessage: QRMessage.error(
                'No pudimos reconocer tu usuario. Asegúrate de estar registrado en el evento.',
              ),
            ),
          );
        } else if (failure is SessionNotExist) {
          emit(
            state.copyWith(
              progress: false,
              qrMessage: QRMessage.error(
                'Tu sesión ha expirado. Vuelve a iniciar sesión para escanear el QR.',
              ),
            ),
          );
        } else if (failure is NoInternetRegisterSemiPlenary) {
          emit(
            state.copyWith(
              progress: false,
              qrMessage: QRMessage.warning(
                'Parece que no tienes conexión a internet. Conéctate y vuelve a intentarlo.',
              ),
            ),
          );
        } else if (failure is UnknownRegisterSemiPlenary ||
            failure is UnknownRegisterSemiPlenaryQr) {
          emit(
            state.copyWith(
              progress: false,
              qrMessage: QRMessage.warning(
                'Ocurrió un error inesperado al intentar registrar tu ingreso. Intenta nuevamente en unos segundos.',
              ),
            ),
          );
        } else if (failure is UserHasRegisteredInSemiPlenary) {
          emit(
            state.copyWith(
              progress: false,
              qrMessage: QRMessage.info(
                'Ya has registrado tu ingreso a esta semiplenaria.',
              ),
            ),
          );
        } else if (failure is UserHasNotRegisteredInSemiPlenary) {
          emit(
            state.copyWith(
              progress: false,
              qrMessage: QRMessage.warning(
                'Aún no has registrado tu ingreso a esta semiplenaria. Escanea el QR correcto para registrar tu asistencia.',
              ),
            ),
          );
        } else if (failure is InvalidServerTimestampRegisterSemiPlenaryQr) {
          emit(
            state.copyWith(
              progress: false,
              qrMessage: QRMessage.warning(
                'Este QR no está habilitado. El ingreso a esta semiplenaria solo se permite en el horario programado.',
              ),
            ),
          );
        } else {
          emit(
            state.copyWith(
              progress: false,
              qrMessage: QRMessage.error(
                'Algo salió mal. Por favor intenta escanear nuevamente o consulta con un voluntario.',
              ),
            ),
          );
        }
      },
      (right) {
        readQr = 0;
        print("right");
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
          emit(
            state.copyWith(
              progress: false,
              qrMessage: QRMessage.error(
                'No pudimos reconocer tu usuario. Asegúrate de estar registrado en el evento.',
              ),
            ),
          );
        } else if (failure is SessionNotExist) {
          emit(
            state.copyWith(
              progress: false,
              qrMessage: QRMessage.error(
                'Tu sesión ha expirado. Vuelve a iniciar sesión para escanear el QR.',
              ),
            ),
          );
        } else if (failure is NoInternetRegisterSemiPlenary) {
          emit(
            state.copyWith(
              progress: false,
              qrMessage: QRMessage.warning(
                'Parece que no tienes conexión a internet. Conéctate y vuelve a intentarlo.',
              ),
            ),
          );
        } else if (failure is UnknownRegisterSemiPlenary ||
            failure is UnknownRegisterSemiPlenaryQr) {
          emit(
            state.copyWith(
              progress: false,
              qrMessage: QRMessage.warning(
                'Ocurrió un error inesperado al intentar registrar tu ingreso. Intenta nuevamente en unos segundos.',
              ),
            ),
          );
        } else if (failure is UserHasRegisteredInSemiPlenary) {
          emit(
            state.copyWith(
              progress: false,
              qrMessage: QRMessage.info(
                'Ya has registrado tu ingreso a esta semiplenaria.',
              ),
            ),
          );
        } else if (failure is UserHasNotRegisteredInSemiPlenary) {
          emit(
            state.copyWith(
              progress: false,
              qrMessage: QRMessage.warning(
                'Aún no has registrado tu ingreso a esta semiplenaria. Escanea el QR correcto para registrar tu asistencia.',
              ),
            ),
          );
        } else if (failure is InvalidServerTimestampRegisterSemiPlenaryQr) {
          emit(
            state.copyWith(
              progress: false,
              qrMessage: QRMessage.warning(
                'Este QR no está habilitado. El ingreso a esta semiplenaria solo se permite en el horario programado.',
              ),
            ),
          );
        } else {
          emit(
            state.copyWith(
              progress: false,
              qrMessage: QRMessage.error(
                'Algo salió mal. Por favor intenta escanear nuevamente o consulta con un voluntario.',
              ),
            ),
          );
        }
      },
      (right) {
        readQr = 0;
        print("right");
      },
    );
  }
}
