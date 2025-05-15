import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jamt/constants/app_color.dart';
import 'package:jamt/feature/privacy/view/privacy_screen.dart';
import 'package:jamt/feature/user/user.dart';
import 'package:jamt/widget/widget.dart';

class privacyPage extends StatelessWidget {
  const privacyPage({super.key});
  static const String routeName = '/privacy2';

  static Route<void> route() {
    return MaterialPageRoute<void>(
      builder: (_) => const privacyPage(),
      settings: const RouteSettings(name: routeName),
    );
  }

  @override
  Widget build(BuildContext context) {
    return PrivacyScreen();
  }
}