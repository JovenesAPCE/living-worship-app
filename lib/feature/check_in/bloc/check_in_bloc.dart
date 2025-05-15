import 'package:bloc/bloc.dart';
import 'package:domain/domain.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

part 'check_in_event.dart';
part 'check_in_state.dart';

class CheckInBloc extends Bloc<CheckInEvent, CheckInState> {

  CheckInBloc({
  required GetQrStateSemiPlenaryUseCase getQrStateSemiPlenaryUseCase
  }) :
        _getQrStateSemiPlenaryUseCase = getQrStateSemiPlenaryUseCase,
        super(CheckInState()) {
    on<CheckInPageSubscriptionRequested>(_onQRPageSubscriptionRequested);
  }

  final GetQrStateSemiPlenaryUseCase _getQrStateSemiPlenaryUseCase;
  void _onQRPageSubscriptionRequested(
      CheckInPageSubscriptionRequested event,
      Emitter<CheckInState> emit
      ) async {
    var result =  await _getQrStateSemiPlenaryUseCase.call();
    result.fold((failure){

    },(success){
     print("checkInTime: ${success.checkInTime}");
      emit(state.copyWith(
        hasRegister: success.hasRegister,
        progress: false,
        isSuccess: true,
        fullName: success.userName,
        checkInTime: success.checkInTime,
        action: "INGRESO",
        semiPlenaryTitle: success.semiPlenaryTitle,
        semiPlenaryTime: success.semiPlenaryTime,
        message: "Gracias por escanear\nTe registraste con éxito",
        color: hexToColor(success.color)
      ));
    });
  }

  Color? hexToColor(String? hex) {
    if(hex == null)return null;
    hex = hex.replaceFirst('#', '');
    if (hex.length == 6) {
      hex = 'FF$hex'; // Añade opacidad completa si no está
    }
    return Color(int.parse(hex, radix: 16));
  }

}
