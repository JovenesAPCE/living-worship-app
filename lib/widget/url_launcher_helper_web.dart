import 'dart:html' as html;

Future<void> openSmartUrl(String url) async {
  html.window.open(url, '_blank');
}