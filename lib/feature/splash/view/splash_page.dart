import 'package:flutter/material.dart';
import 'package:jamt/constants/constants.dart';
class SplashPage extends StatelessWidget {
  const SplashPage({super.key});
  static const String routeName = '/splash';
  static Route<void> route() {
    return MaterialPageRoute<void>(
      builder: (_) => const SplashPage(),
      settings: const RouteSettings(name: routeName),
    );
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
                child: Center(
                  child: Image(
                    image: AssetImage(AppImages.logoWorship), // ← tu imagen central
                    width: 200,
                    height: 200,
                  ),
                )
            ),
            Padding(
              padding: EdgeInsets.only(bottom: 24.0),
              child: Image(
                image: AssetImage(AppImages.mainLogoWhite), // ← logo inferior
                width: 120,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

