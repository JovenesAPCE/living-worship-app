import 'package:bloc/bloc.dart';
import 'package:domain/domain.dart';
import 'package:entities/entities.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import '../models/models.dart';

part 'semi_plenary_event.dart';
part 'semi_plenary_state.dart';

class SemiPlenaryBloc extends Bloc<SemiPlenaryEvent, SemiPlenaryState> {
  SemiPlenaryBloc({
    required GetSemiPlenariesUseCase getSemiPlenariesUseCase,
    required UpdateSemiPlenariesUseCase updateSemiPlenariesUseCase,
    required RegisterSemiPlenariesUseCase registerSemiPlenariesUseCase,
    required GetRegisterSemiPlenariesUseCase getRegisterSemiPlenariesUseCase,
    required GetUserUseCase getUserUseCase,
    required ShowCheckInUseCase showCheckInUseCase,
    required ShowCheckOutUseCase showCheckOutUseCase
  }) :
        _getSemiPlenariesUseCase = getSemiPlenariesUseCase,
        _updateSemiPlenariesUseCase = updateSemiPlenariesUseCase,
        _registerSemiPlenariesUseCase = registerSemiPlenariesUseCase,
        _getRegisterSemiPlenariesUseCase = getRegisterSemiPlenariesUseCase,
        _getUserUseCase = getUserUseCase,
        _showCheckInUseCase = showCheckInUseCase,
        _showCheckOutUseCase = showCheckOutUseCase,
        super(SemiPlenaryState()) {
    on<LoadSemiPlenary>(_onSemiPlenarySubscriptionRequested);
    on<TabSelected>(_onTabSelected);
    on<SessionSelected>(_onOneSessionSelected);
    on<SessionSave>(_onOneSessionSave);
    on<SessionClose>(_onOneSessionClose);
    on<SessionRegister>(_onSessionRegister);
    on<OnCheckInPressed>(_onCheckInPressed);
    on<OnCheckOutPressed>(_onCheckOutPressed);

  }

  final GetSemiPlenariesUseCase _getSemiPlenariesUseCase;
  final UpdateSemiPlenariesUseCase _updateSemiPlenariesUseCase;
  final RegisterSemiPlenariesUseCase _registerSemiPlenariesUseCase;
  final GetRegisterSemiPlenariesUseCase _getRegisterSemiPlenariesUseCase;
  final GetUserUseCase _getUserUseCase;
  final ShowCheckInUseCase _showCheckInUseCase;
  final ShowCheckOutUseCase _showCheckOutUseCase;
  void _onCheckOutPressed(OnCheckOutPressed event, Emitter<SemiPlenaryState> emit) async {
    print("_onCheckOutPressed");
    if(event.groupSelected.selected != null){
      print("_showCheckOutUseCase");
      await _showCheckOutUseCase.call(SemiPlenary(
        id: event.groupSelected.selected?.id??""
      ));
    }

  }

  void _onCheckInPressed(OnCheckInPressed event, Emitter<SemiPlenaryState> emit) async {
    if(event.groupSelected.selected != null){
      await _showCheckInUseCase.call(SemiPlenary(
          id: event.groupSelected.selected?.id??""
      ));
    }
  }

  void _onSemiPlenarySubscriptionRequested(LoadSemiPlenary event,  Emitter<SemiPlenaryState> emit) async{
    bool offline = false;
    emit(state.copyWith(
        tabProgress: true,
        groupProgress: false,
        groupedSessions: const [],
        sessionProgress: SessionProgress.loading("¡Cargando semiplenaria!"),
        sessionMessage: SessionMessage.empty()
    ));

    List<RegisterSemiPlenary> registerSemiPlenaries = await _getRegisterSemiPlenariesUseCase.call();
    List<SessionGroup> groupedSessions = await _groupedSessions();

    emit(state.copyWith(
        groupedSessions: groupedSessions,
        tabProgress: false,
        groupProgress: true,
        tabs: await _getGroupedSessionTabs(),
        register: registerSemiPlenaries.isNotEmpty,
        sessionProgress: groupedSessions.isEmpty ? null: const SessionProgress.empty(),
    ));

    try{
      await _updateSemiPlenariesUseCase.call();
    }catch(e){
      offline = true;
    }
   registerSemiPlenaries = await _getRegisterSemiPlenariesUseCase.call();
   groupedSessions = await _groupedSessions();

    emit(
        state.copyWith(
            groupProgress: false,
            groupedSessions: groupedSessions,
            tabs: await _getGroupedSessionTabs(),
            sessionProgress: offline && groupedSessions.isEmpty ? const SessionProgress.error("Sin conexión. Verifica tu internet.") : const SessionProgress.empty(),
            tabProgress: false,
            register: registerSemiPlenaries.isNotEmpty
        ));
  }

  Future<List<SessionGroup>> _groupedSessions() async {
    List<RegisterSemiPlenary> registerSemiPlenaries = await _getRegisterSemiPlenariesUseCase.call();
    User? user = await _getUserUseCase.call();

    List<SemiPlenary> semiPlenaries = await  _getSemiPlenariesUseCase.call();
    print("document: ${user?.document}");
    print("name: ${user?.name}");
    print("gender: ${user?.gender}");
    semiPlenaries.removeWhere((element) =>
    element.gender != null &&
        element.gender!.isNotEmpty &&
        element.gender != user?.gender);

    List<Session> sessions = semiPlenaries.map((semiPlenary){
      return Session(
        id: semiPlenary.id,
        group: semiPlenary.group??"",
        title: semiPlenary.title??"",
      );
    }).toList();

    final Map<String, List<Session>> groupedMap = {};

    for (var session in sessions) {
      groupedMap.putIfAbsent(session.group, () => []).add(session);
    }

    final List<SessionGroup> groupedSessions = groupedMap.entries.map((entry) {
      var index = registerSemiPlenaries.indexWhere((register) => register.group == entry.key);
      Session? session;
      if(index != -1){
        RegisterSemiPlenary register = registerSemiPlenaries[index];
        session = Session(
            id: register.semiPlenary,
            group: register.group,
            title: register.title,
            checkIn: register.checkIn,
            checkOut: register.checkOut
        );
      }
      var list = entry.value;
      list.insert(0, Session(id: "", title: "SELECCIONE"));

      return SessionGroup(
          group: entry.key,
          register: session != null,
          selected: session,
          sessions: list
      );
    }).toList();

    groupedSessions.sort((a, b) => (a.group).compareTo((b.group)));
    return groupedSessions;
  }

  void _onTabSelected(TabSelected event,  Emitter<SemiPlenaryState> emit) {
    emit(state.copyWith(
        selectedIndex: event.selectedIndex
    ));
  }

  void _onOneSessionSelected(SessionSelected event,  Emitter<SemiPlenaryState> emit) {
    final updatedGroups = state.groupedSessions.map((group) {
      if (group == event.groupSelected) {
        return group.copyWith(
          selected: event.selected,
          error: ""
        );
      }
      return group;
    }).toList();
    emit(state.copyWith(
      groupedSessions: updatedGroups
    ));
  }

  Future<List<SemiPlenaryTab>> _getGroupedSessionTabs() async {
    var semiPlenaries = await _getSemiPlenariesUseCase.call();
    final Map<String, List<SemiPlenary>> groupedTabMap = {};
    for (var semiPlenary in semiPlenaries) {
      groupedTabMap.putIfAbsent(semiPlenary.group??"", () => []).add(semiPlenary);
    }

    final List<SemiPlenaryTab> groupedSessionTabs = groupedTabMap.entries.map((entry) {
      return SemiPlenaryTab(title: entry.key, session: entry.value.map((semiPlenary){
        return SessionCard(
            id: semiPlenary.id,
            title: semiPlenary.title??"",
            topic2: semiPlenary.time??"",
            color: hexToColor(semiPlenary.color??""),
            capacity: semiPlenary.capacity??0,
            available: semiPlenary.available??0
        );
      }).toList());
    }).toList();

    groupedSessionTabs.sort((a, b) => (a.title).compareTo((b.title)));

    return groupedSessionTabs;
  }

  void _onOneSessionSave(SessionSave event,  Emitter<SemiPlenaryState> emit) {
    if(event.groupSelected.selected?.id == null || event.groupSelected.selected?.id == ""){
      return;
    }
    final updatedGroups = state.groupedSessions.map((group) {
      if (group == event.groupSelected) {
        return group.copyWith(
            register: (group.selected?.id != null && group.selected?.id != "")? true: false,
          error: ""
        );
      }
      return group;
    }).toList();

    emit(state.copyWith(
      sessionMessage: SessionMessage.empty(),
        groupedSessions: updatedGroups,
    ));
  }

  void _onOneSessionClose(SessionClose event,  Emitter<SemiPlenaryState> emit) {
    final updatedGroups = state.groupedSessions.map((group) {
      if (group == event.groupSelected) {
        return group.copyWith(
            register: false,
            error: ""
        );
      }
      return group;
    }).toList();
    print("_onOneSessionClose");
    emit(state.copyWith(
        groupedSessions: updatedGroups
    ));
  }

  void _onSessionRegister(SessionRegister event,  Emitter<SemiPlenaryState> emit) async {
    var validationSelected = true;
    for(var item in state.groupedSessions){
      if(!item.register){
        validationSelected = false;
      }
    }
    if(!validationSelected){
      emit(state.copyWith(
          sessionMessage: SessionMessage.info("Falta elegir una Semiplenaria. Revisa tu selección.")
      ));
      return;
    }
    List<SessionGroup> list = List.from(state.groupedSessions);

    emit(state.copyWith(
        register: true,
       groupedSessions: [],
        sessionMessage: SessionMessage.empty(),
       sessionProgress: SessionProgress.success("¡Guardando tus Semiplenarias!"),
    ));

    List<SemiPlenary> semiPlenaries = [];
    for(var group in list){
        if(group.selected?.id != null&&group.selected?.id != ""){
          semiPlenaries.add(SemiPlenary(id: group.selected!.id, title: group.selected?.title, group: group.selected!.group));
        }
    }
    if(semiPlenaries.isEmpty){
      emit(state.copyWith(
          sessionMessage: SessionMessage.warning("Falta elegir una Semiplenaria.")
      ));
      return;
    }
    var result = await _registerSemiPlenariesUseCase.call(semiPlenaries);

    await result.fold((failure) async {
      if (failure is UserNotExist) {
        emit(state.copyWith(
          register: false,
          groupedSessions: list,
          sessionMessage: SessionMessage.error("¡Usted no está registrado!"),
          sessionProgress: SessionProgress.empty(),
        ));
      } else if (failure is SessionNotExist) {
        emit(state.copyWith(
          register: false,
          groupedSessions: list,
          sessionMessage: SessionMessage.error("La sesión no existe"),
          sessionProgress: SessionProgress.empty(),
        ));
      } else if (failure is SessionNotFound) {
        emit(state.copyWith(
          register: false,
          groupedSessions: list,
          sessionMessage: SessionMessage.error("Error no reconocido"),
          sessionProgress: SessionProgress.empty(),
        ));
      } else if (failure is UserHasRegisteredInSemiPlenary) {
        print('⚠️ ${failure.toString()}');
        emit(state.copyWith(
          register: false,
          groupedSessions: list,
          sessionMessage: SessionMessage.warning("¡Ya estás registrado!"),
          sessionProgress: SessionProgress.empty(),
        ));
      } else if (failure is NoCapacityInSemiPlenaries) {
        print('🚫 ${failure.toString()}');

        final updatedGroups = list.map((group) {
          for (var sessionId in failure.plenaryIdsWithoutCapacity){
            for(var session in group.sessions){
              if (session.id == sessionId) {
                return group.copyWith(
                    register: false,
                    error: "¡Ya no tenemos vacantes!"
                );
              }
            }
          }
          return group;
        }).toList();

        emit(state.copyWith(
          register: false,
          groupedSessions: updatedGroups,
          sessionMessage: SessionMessage.warning("¡Ya no tenemos vacantes para estas Semiplenarias!"),
          sessionProgress: SessionProgress.empty(),
        ));

      } else if (failure is UnknownRegisterSemiPlenary) {
        emit(state.copyWith(
          register: false,
          groupedSessions: list,
          sessionMessage: SessionMessage.error("Ocurrió un error desconocido al registrar en semiplenaria"),
          sessionProgress: SessionProgress.empty(),
        ));
        print('❓ Ocurrió un error desconocido al registrar en semiplenaria');
      }else if(failure is NoInternetRegisterSemiPlenary){
        emit(state.copyWith(
          register: false,
          groupedSessions: const [],
          sessionMessage: SessionMessage.empty(),
          sessionProgress: SessionProgress.error("Sin conexión. Verifica tu internet para completar el registro."),
        ));
      }else {
        emit(state.copyWith(
          register: false,
          groupedSessions: list,
          sessionMessage: SessionMessage.error("Error no reconocido"),
          sessionProgress: SessionProgress.empty(),
        ));
        print('❌ Error no reconocido');
      }
    },(success) async {
      List<SemiPlenary> semiPlenaries = await _getSemiPlenariesUseCase.call();
      var tabs = state.tabs.map((tab){
        return tab.copyWith(
          session: tab.session.map((session){
           final index = semiPlenaries.indexWhere((register) => register.id == session.id);
            if(index != -1){
              return session.copyWith(
                  available: semiPlenaries[index].available,
                  capacity: semiPlenaries[index].capacity,
              );
            }
           return session;
          }).toList()
        );
      }).toList();

      emit(state.copyWith(
        register: true,
        tabs: tabs,
        groupedSessions: list,
        sessionMessage: SessionMessage.success("¡Felicitaciones, estás registrado en las semiplenarias!"),
        sessionProgress: SessionProgress.empty(),
      ));
    });

  }

  Color hexToColor(String hex) {
    hex = hex.replaceFirst('#', '');
    if (hex.length == 6) {
      hex = 'FF$hex'; // Añade opacidad completa si no está
    }
    return Color(int.parse(hex, radix: 16));
  }
}
