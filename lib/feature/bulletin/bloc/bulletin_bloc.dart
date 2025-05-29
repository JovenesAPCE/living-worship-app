import 'package:bloc/bloc.dart';
import 'package:domain/domain.dart';
import 'package:entities/entities.dart';
import 'package:equatable/equatable.dart';
import 'package:jamt/feature/bulletin/model/bulletin_progress.dart';
import 'package:meta/meta.dart';

part 'bulletin_event.dart';
part 'bulletin_state.dart';

class BulletinBloc extends Bloc<BulletinEvent, BulletinState> {
  BulletinBloc({
    required UpdateNotificationUseCase updateNotificationUseCase,
    required GetNotificationUseCase getNotificationUseCase,
    required LogScreenUseCase logScreenUseCase,
  }) :_updateNotificationUseCase = updateNotificationUseCase,
     _getNotificationUseCase = getNotificationUseCase,
        _logScreenUseCase = logScreenUseCase,
        super(BulletinState()) {

    on<LoadBulletin>(_onLoadBulletin);
  }

  final UpdateNotificationUseCase _updateNotificationUseCase;
  final GetNotificationUseCase _getNotificationUseCase;
  final LogScreenUseCase _logScreenUseCase;

  _onLoadBulletin(LoadBulletin event, Emitter<BulletinState> emit) async {
    bool offline = false;

    emit(state.copyWith(
      notifications: [],
      offline: false,
      progress: BulletinProgress.loading("¡Cargando información oficial!")
    ));

    try{
      await _updateNotificationUseCase.call();
    }catch(e){
      offline = true;
    }
    var notifications = await _getNotificationUseCase.call();
    emit(state.copyWith(
      notifications: notifications,
      progress: offline && notifications.isEmpty ? const BulletinProgress.error("Sin conexión. Verifica tu internet.") : const BulletinProgress.empty(),
      offline: offline
    ));
    _logScreenUseCase.call("LoadBulletin", "BulletinBloc");
  }


}
