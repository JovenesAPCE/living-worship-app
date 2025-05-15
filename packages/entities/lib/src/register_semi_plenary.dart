class RegisterSemiPlenary {

  final DateTime? timestamp;
  final String semiPlenary;
  final String document;
  final String group;
  final String title;
  final bool? checkOut;
  final DateTime? checkOutTimestamp;
  final bool? checkIn;
  final DateTime? checkInTimestamp;

  RegisterSemiPlenary({this.timestamp, required this.semiPlenary, required this.document,
    required this.group, required this.title, this.checkOut, this.checkOutTimestamp,
    this.checkIn, this.checkInTimestamp});


}