part of 'check_in_bloc.dart';

class CheckInState extends Equatable{

  final bool progress;
  final bool isSuccess;
  final String? fullName;
  final DateTime? checkInTime;
  final String? action; // Ej: "INGRESO"
  final String? semiPlenaryTitle; // Ej: "ALVA Y ALVA"
  final String? semiPlenaryTime;  // Ej: "Sábado 8:40 HS"
  final String? message;
  final bool hasRegister;
  final Color color;
  final bool copy;



  @override
  List<Object?> get props => [
    progress,
    isSuccess,
    fullName,
    checkInTime,
    action,
    semiPlenaryTitle,
    semiPlenaryTime,
    message,
    hasRegister,
    color
  ];

  const CheckInState({
    this.progress = false,
    this.isSuccess = false,
    this.fullName,
    this.checkInTime,
    this.action,
    this.semiPlenaryTitle,
    this.semiPlenaryTime,
    this.message,
    this.hasRegister = false,
    this.color = Colors.black,
    this.copy = false,
  });

  CheckInState copyWith({
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
    bool? copy,
  }) {
    return CheckInState(
      progress: progress ?? this.progress,
      isSuccess: isSuccess ?? this.isSuccess,
      fullName: fullName ?? this.fullName,
      checkInTime: checkInTime ?? this.checkInTime,
      action: action ?? this.action,
      semiPlenaryTitle: semiPlenaryTitle ?? this.semiPlenaryTitle,
      semiPlenaryTime: semiPlenaryTime ?? this.semiPlenaryTime,
      message: message ?? this.message,
      hasRegister: hasRegister ?? this.hasRegister,
      color: color ?? this.color,
      copy: copy ?? this.copy,
    );
  }

}
