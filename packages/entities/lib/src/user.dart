class User {

  final String document;
  final String? name;
  final String? session;
  final String? gender;

  static const empty = User(
    document: ""
  );

  const User({
    this.document = '',
    this.name,
    this.session,
    this.gender,
  });
}