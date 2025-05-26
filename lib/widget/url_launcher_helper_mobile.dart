import 'package:url_launcher/url_launcher.dart';

Future<void> openSmartUrl(String url) async {
  final uri = Uri.parse(url);
  if (await canLaunchUrl(uri)) {
    await launchUrl(uri, mode: LaunchMode.externalApplication);
  } else {
    throw 'No se pudo abrir $url';
  }
}