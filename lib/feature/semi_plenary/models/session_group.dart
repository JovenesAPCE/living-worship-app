import 'package:equatable/equatable.dart';
import '../models/models.dart';

class SessionGroup extends Equatable{

  final String group;
  final List<Session> sessions;
  final Session? selected;
  final bool register;
  final String error;

  const SessionGroup({this.group = "", this.sessions = const [], this.selected, this.register = false, this.error = ""});

  SessionGroup copyWith({
    String? group,
    List<Session>? sessions,
    Session? selected,
    bool? register,
    String? error
  }){
    return SessionGroup(
      group: group??this.group,
      sessions: sessions??this.sessions,
      selected: selected??this.selected,
      register: register??this.register,
      error: error??this.error
    );
  }
  @override
  List<Object?> get props => [group, sessions, selected, register, error];
}