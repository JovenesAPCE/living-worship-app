import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:web/web.dart' as web;
import 'dart:js_interop';

extension ThemeColorExtension on BuildContext {
  void setPWAThemeColor(String hexColor) {
    if (kIsWeb) {
      final existingMeta = web.document.querySelector('meta[name="theme-color"]'.toJS.toString()) as web.HTMLMetaElement?;

      if (existingMeta != null) {
        existingMeta.content = hexColor;
      } else {
        final meta = web.document.createElement('meta'.toJS.toString()) as web.HTMLMetaElement;
        meta.name = 'theme-color';
        meta.content = hexColor;
        web.document.head!.appendChild(meta);
      }
    }
  }
}