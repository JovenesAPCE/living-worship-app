import 'package:data/data.dart';
import 'package:data/src/data_sources/data_sources.dart';
import 'package:data/src/data_sources/table/notification_table.dart';
import 'package:domain/domain.dart';
import 'package:entities/src/notification.dart';
import 'package:firebase_database/firebase_database.dart';

class NotificationRepositoryImpl extends NotificationRepository{
  final db = FirebaseDatabase.instance.ref();

  @override
  Future<void> updateNotification() async{
    final user = HiveService.userBox.values.cast<UserTable?>().firstOrNull;

    final DatabaseReference ref = FirebaseDatabase.instance.ref("${ConstFirebase.eventPath}/${ConstFirebase.notification}");
    final DataSnapshot snapshot = await ref.get();
    if (snapshot.exists && snapshot.value is Map) {
      await HiveService.notificationTableBox.clear();
      final data = snapshot.value as Map;

      data.entries.map((entry) async{
        final id = entry.key;
        final json = Map<String, dynamic>.from(entry.value);
        await HiveService.notificationTableBox.put(
            id,
            NotificationTable()
              ..id = id
              ..body = json['body']
              ..image = json['image']
              ..row = json['row']
              ..date = json['date']
        );
      }).toList();
    } else {
      // Firebase está accesible pero el nodo no existe
      await HiveService.notificationTableBox.clear();
    }
  }

  @override
  Future<List<Notification>> notifications() async {
    var list = HiveService.notificationTableBox.values.map((e) => e.toEntity()).toList();
    list.sort((a, b) => (a.row).compareTo(b.row));
    return list;
  }

}