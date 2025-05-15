class QrPayload {
  final String uid;
  final String description;
  final String type;
  final String code;

  QrPayload({
    required this.uid,
    required this.type,
    required this.code,
    required this.description
  });

  factory QrPayload.fromJson(Map<String, dynamic> json) {
    return QrPayload(
      uid: json['uid'],
      type: json['type'],
      code: json['code'],
      description: json['description']
    );
  }

  Map<String, dynamic> toJson() => {
    'uid': uid,
    'type': type,
    'code': code,
    'description': description
  };
}