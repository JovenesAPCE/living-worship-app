import 'package:web/web.dart' as web;
import 'dart:js_interop';

extension ThemeColorExtension on web.Document {
  void setThemeColor(String hexColor) {
    final existingMeta = this.querySelector('meta[name="theme-color"]'.toJS.toString()) as web.HTMLMetaElement?;

    if (existingMeta != null) {
      existingMeta.content = hexColor;
    } else {
      final meta = web.document.createElement('meta'.toJS.toString()) as web.HTMLMetaElement;
      meta.name = 'theme-color';
      meta.content = hexColor;
      this.head!.appendChild(meta);
    }
  }
}