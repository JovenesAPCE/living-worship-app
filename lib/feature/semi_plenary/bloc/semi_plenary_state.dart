part of 'semi_plenary_bloc.dart';

class SemiPlenaryState extends Equatable {

  final List<SemiPlenaryTab> tabs;
  final List<SessionGroup> groupedSessions;
  final bool register;
  final int selectedIndex;
  final SessionMessage sessionMessage;
  final SessionProgress sessionProgress;
  final bool tabProgress;
  final bool groupProgress;
  final String disableRegister;
  const SemiPlenaryState({
    this.register = false,
    this.groupedSessions = const [],
    this.selectedIndex = 0,
    this.tabs = const [],
    this.sessionMessage = const SessionMessage.empty(),
    this.sessionProgress = const SessionProgress.empty(),
    this.tabProgress = false,
    this.groupProgress = false,
    this.disableRegister = ""
  });




  @override
  List<Object?> get props => [groupedSessions, tabs, register, selectedIndex, sessionMessage, sessionProgress, groupProgress, tabProgress, disableRegister];

  SemiPlenaryState copyWith({
    List<SemiPlenaryTab>? tabs,
    List<SessionGroup>? groupedSessions,
    bool? register,
    int? selectedIndex,
    SessionMessage? sessionMessage,
    SessionProgress? sessionProgress,
    bool? tabProgress,
    bool? groupProgress,
    String? disableRegister,
  }) {
    return SemiPlenaryState(
      tabs: tabs ?? this.tabs,
      groupedSessions: groupedSessions ?? this.groupedSessions,
      register: register ?? this.register,
      selectedIndex: selectedIndex ?? this.selectedIndex,
      sessionMessage: sessionMessage ?? this.sessionMessage,
      sessionProgress: sessionProgress ?? this.sessionProgress,
      tabProgress: tabProgress ?? this.tabProgress,
      groupProgress: groupProgress ?? this.groupProgress,
      disableRegister: disableRegister ?? this.disableRegister,
    );
  }

}
