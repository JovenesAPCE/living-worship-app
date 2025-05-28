import 'dart:html' as html;

Future<bool> checkAndRequestPermission() async {
  final permiso = html.Notification.permission;
  if (permiso == 'default') {
    final result = await html.Notification.requestPermission();
    print("permiso: $permiso");
    return false;
  } else {
    print('Permiso ya es: $permiso');
    return true;
  }
}