import 'dart:html' as html;

class LocalWebNotification {
  static final LocalWebNotification _instance = LocalWebNotification._internal();
  LocalWebNotification._internal();

  void Function(String? payload)? _onTapCallback;

  /// Establece un callback global cuando se hace clic en la notificación
  static void setOnTapCallback(void Function(String? payload) callback) {
    _instance._onTapCallback = callback;
  }

  /// Muestra una notificación del navegador
  static Future<void> show({
    required String title,
    required String body,
    String? payload,
  }) async {
    final permission = await html.Notification.requestPermission();
    if (permission == 'granted') {
      final notification = html.Notification(title, body: body, icon: 'icons/Icon-192.png', // ruta relativa a tu sitio
        tag: 'my-notification');

      // Maneja el clic
      notification.onClick.listen((_) {
        _instance._onTapCallback?.call(payload);
        notification.close(); // opcional
      });
    } else {
      print('🚫 Permiso denegado para mostrar notificaciones web');
    }
  }
}