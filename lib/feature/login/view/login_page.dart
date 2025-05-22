import 'package:domain/domain.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jamt/constants/constants.dart';
import 'package:jamt/extensions/extensions.dart';
import 'package:jamt/feature/login/login.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});
  static const String routeName = '/login';
  static Route<void> route() {
    return MaterialPageRoute<void>(
      builder: (_) => const LoginPage(),
      settings: const RouteSettings(name: routeName),
    );
  }

  @override
  Widget build(BuildContext context) {
    context.setPWAThemeColor(AppColor.purpleDark2.toHex());
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              AppImages.loginBackground,
              fit: BoxFit.cover,
            ),
          ),
          Positioned(
            top: 40,
            left: 0,
            right: 0,
            child: Center(
              child: SizedBox(
                width:  MediaQuery.of(context).size.height * 0.23, // 50% del ancho de pantalla,
                child: Image.asset(
                  AppImages.logoWorship,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 16,
            left: 0,
            right: 0,
            child: Center(
              child: SizedBox(
                height: 80,
                child: Image.asset(
                  AppImages.logoMRNT,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          /*Positioned.fill(
            child: Container(
              color: Colors.black.withOpacity(0.4),
            ),
          ),*/
          SafeArea(
            child: BlocProvider(
              create: (context) => LoginBloc(
                logIn: LogInUseCase(
                    context.read<AuthenticationRepository>()
                ),
              ),
              child: const LoginForm(),
            ),
          )
        ],
      ),
    );
  }
}