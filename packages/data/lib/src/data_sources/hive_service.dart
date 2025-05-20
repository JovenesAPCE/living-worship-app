import 'package:data/src/data_sources/table/notification_table.dart';
import 'package:data/src/data_sources/table/register_semi_plenary_table.dart';
import 'package:data/src/data_sources/table/table.dart';
import 'package:hive_flutter/adapters.dart';

class HiveService {
  static bool _initialized = false;
  static late Box<UserTable> _userBox;
  static late Box<SemiPlenaryTable> _semiPlenaryBox;
  static late Box<RegisterSemiPlenaryTable> _registerSemiPlenaryTableBox;
  static late Box<NotificationTable> _notificationTableBox;

  static Future<void> init() async {
    if (_initialized) return;

    await Hive.initFlutter(); // Esto maneja Web y Móvil automáticamente
    Hive.registerAdapter(UserTableAdapter());
    Hive.registerAdapter(SemiPlenaryTableAdapter());
    Hive.registerAdapter(RegisterSemiPlenaryTableAdapter());
    Hive.registerAdapter(NotificationTableAdapter());
    _userBox = await Hive.openBox<UserTable>('users');
    _semiPlenaryBox = await Hive.openBox<SemiPlenaryTable>('semiPlenaries');
    _registerSemiPlenaryTableBox = await Hive.openBox<RegisterSemiPlenaryTable>('RegisterSemiPlenary');
    _notificationTableBox = await Hive.openBox<NotificationTable>('Notifications');
    _initialized = true;
  }

  static Box<UserTable> get userBox {
    if (!_initialized) {
      throw Exception('HiveService not initialized. Call init() first.');
    }
    return _userBox;
  }

  static Box<SemiPlenaryTable> get semiPlenaryBox {
    if (!_initialized) {
      throw Exception('HiveService not initialized. Call init() first.');
    }
    return _semiPlenaryBox;
  }

  static Box<RegisterSemiPlenaryTable> get registerSemiPlenaryTableBox {
    if (!_initialized) {
      throw Exception('HiveService not initialized. Call init() first.');
    }
    return _registerSemiPlenaryTableBox;
  }

  static Box<NotificationTable> get notificationTableBox {
    if (!_initialized) {
      throw Exception('HiveService not initialized. Call init() first.');
    }
    return _notificationTableBox;
  }

  static bool get isInitialized => _initialized;
}