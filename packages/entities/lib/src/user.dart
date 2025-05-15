class User {
  const User({
    required this.document,
    this.name,
    this.session
  });

  final String document;
  final String? name;
  final String? session;

  static const empty = User(
    document: ""
  );

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is User &&
          runtimeType == other.runtimeType &&
          document == other.document &&
          name == other.name;

  @override
  int get hashCode => document.hashCode ^ name.hashCode;
}