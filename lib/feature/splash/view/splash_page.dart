import 'package:flutter/material.dart';
import 'package:jamt/constants/constants.dart';
import 'package:jamt/extensions/extensions.dart';
import 'package:web/web.dart';
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
    context.setPWAThemeColor(AppColor.blue2.toHex());
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              AppColor.blue2, // ← Color superior
              AppColor.purpleDark2, // ← Color inferior
            ],
          ),
        ),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Center(
                  child: Image(
                    image: AssetImage(AppImages.logoWorship),
                    width: 200,
                    height: 200,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(bottom: 24.0),
                child: Image(
                  image: AssetImage(AppImages.mainLogoWhite),
                  width: 120,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

