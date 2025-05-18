import 'package:equatable/equatable.dart';

class UserDecision extends Equatable{
  final int id;
  final String name;
  final bool selected;

  @override
  List<Object?> get props => [id, name, selected];

  const UserDecision({
    this.id = 0,
    this.name = '',
    this.selected = false,
  });

  UserDecision copyWith({
    int? id,
    String? name,
    bool? selected,
  }) {
    return UserDecision(
      id: id ?? this.id,
      name: name ?? this.name,
      selected: selected ?? this.selected,
    );
  }

}