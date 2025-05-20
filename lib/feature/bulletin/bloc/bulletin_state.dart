part of 'bulletin_bloc.dart';

class BulletinState extends Equatable {

  final List<Notification> notifications;
  final bool offline;
  final BulletinProgress progress;

  @override
  List<Object?> get props => [notifications, progress, offline];

  const BulletinState({
    this.notifications = const [],
    this.progress = const BulletinProgress.empty(),
    this.offline = false,
  });

  BulletinState copyWith({
    List<Notification>? notifications,
    bool? offline,
    BulletinProgress? progress,
  }) {
    return BulletinState(
      notifications: notifications ?? this.notifications,
      offline: offline ?? this.offline,
      progress: progress ?? this.progress,
    );
  }
}

