class SemiPlenary {

  final String? color;
  final String? group;
  final String? issue;
  final String? time;
  final String? title;
  final String id;
  final int? capacity;
  final int? available;
  final String? gender;

  const SemiPlenary({
    this.color,
    this.group,
    this.issue,
    this.time,
    this.title,
    this.id = '',
    this.capacity,
    this.available,
    this.gender,
  });

  @override
  String toString() {
    return 'SemiPlenary{gender: $gender}';
  }
}