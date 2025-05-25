class SemiPlenary {

  final String? color;
  final String? group;
  final String? topic;
  final String? speaker;
  final String? time;
  final String? title;
  final String id;
  final int? capacity;
  final int? available;
  final String? gender;

  const SemiPlenary({
    this.color,
    this.group,
    this.topic,
    this.time,
    this.title,
    this.id = '',
    this.capacity,
    this.available,
    this.gender,
    this.speaker
  });

  @override
  String toString() {
    return 'SemiPlenary{gender: $gender}';
  }
}