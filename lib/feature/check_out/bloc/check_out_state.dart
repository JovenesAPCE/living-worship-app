part of 'check_out_bloc.dart';

class CheckOutState extends Equatable {

  final bool progress;
  final bool isSuccess;
  final String? fullName;
  final DateTime? checkTime;
  final String? action; // Ej: "INGRESO"
  final String? semiPlenaryTitle; // Ej: "ALVA Y ALVA"
  final String? semiPlenaryTime;  // Ej: "Sábado 8:40 HS"
  final String? message;
  final bool hasRegister;
  final Color color;

  const CheckOutState({
    this.progress = false,
    this.isSuccess = false,
    this.fullName,
    this.checkTime,
    this.action,
    this.semiPlenaryTitle,
    this.semiPlenaryTime,
    this.message,
    this.hasRegister = false,
    this.color = Colors.black
  });

  @override
  List<Object?> get props => [
    progress,
    isSuccess,
    fullName,
    checkTime,
    action,
    semiPlenaryTitle,
    semiPlenaryTime,
    message,
    hasRegister,
    color
  ];

  CheckOutState copyWith({
    bool? progress,
    bool? isSuccess,
    String? fullName,
    DateTime? checkInTime,
    String? action,
    String? semiPlenaryTitle,
    String? semiPlenaryTime,
    String? message,
    bool? hasRegister,
    Color? color,
  }) {
    return CheckOutState(
      progress: progress ?? this.progress,
      isSuccess: isSuccess ?? this.isSuccess,
      fullName: fullName ?? this.fullName,
      checkTime: checkInTime ?? this.checkTime,
      action: action ?? this.action,
      semiPlenaryTitle: semiPlenaryTitle ?? this.semiPlenaryTitle,
      semiPlenaryTime: semiPlenaryTime ?? this.semiPlenaryTime,
      message: message ?? this.message,
      hasRegister: hasRegister ?? this.hasRegister,
      color: color ?? this.color,
    );
  }

}
