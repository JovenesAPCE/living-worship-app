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

  const SemiPlenaryState({
    this.register = false,
    this.groupedSessions = const [],
    this.selectedIndex = 0,
    this.tabs = const [],
    this.sessionMessage = const SessionMessage.empty(),
    this.sessionProgress = const SessionProgress.empty(),
    this.tabProgress = false,
    this.groupProgress = false
  });

  SemiPlenaryState copyWith({
    List<SemiPlenaryTab>? tabs,
    int? selectedIndex,
    SessionSelected? saveOneSession,
    SessionSelected? saveTwoSession,
    bool? register,
    List<SessionGroup>? groupedSessions,
    bool? tabProgress,
    SessionMessage? sessionMessage,
    SessionProgress? sessionProgress,
    bool? groupProgress
  }){
    return SemiPlenaryState(
        tabs: tabs??this.tabs,
        register: register??this.register,
        groupedSessions: groupedSessions ?? this.groupedSessions,
        selectedIndex: selectedIndex??this.selectedIndex,
        sessionMessage: sessionMessage??this.sessionMessage,
        sessionProgress:  sessionProgress??this.sessionProgress,
        tabProgress: tabProgress??this.tabProgress,
        groupProgress: groupProgress??this.groupProgress
    );
  }


  @override
  List<Object?> get props => [groupedSessions, tabs, register, selectedIndex, sessionMessage, sessionProgress, groupProgress, tabProgress];

}
