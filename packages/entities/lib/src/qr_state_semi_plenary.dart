class QrStateSemiPlenary {
  bool? hasRegister;
  String? userName;
  String userNumber;
  DateTime? checkInTime;
  String? semiPlenaryTitle;
  String? semiPlenaryTime;
  String semiPlenaryId;
  String? color;
  bool? copy;

  QrStateSemiPlenary({
    this.hasRegister, this.userName, required this.userNumber,
    this.checkInTime, this.semiPlenaryTitle, this.semiPlenaryTime,
    required this.semiPlenaryId, this.color, this.copy});

  QrStateSemiPlenary copyWith({
    bool? hasRegister,
    String? userName,
    String? userNumber,
    DateTime? checkInTime,
    String? semiPlenaryTitle,
    String? semiPlenaryTime,
    String? semiPlenaryId,
    String? color,
    bool? copy
  }) {
    return QrStateSemiPlenary(
      hasRegister: hasRegister ?? this.hasRegister,
      userName: userName ?? this.userName,
      userNumber: userNumber ?? this.userNumber,
      checkInTime: checkInTime ?? this.checkInTime,
      semiPlenaryTitle: semiPlenaryTitle ?? this.semiPlenaryTitle,
      semiPlenaryTime: semiPlenaryTime ?? this.semiPlenaryTime,
      semiPlenaryId: semiPlenaryId ?? this.semiPlenaryId,
      color: color ?? this.color,
      copy: copy ?? this.copy
    );
  }

}