import 'package:domain/domain.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jamt/extensions/extensions.dart';
import 'package:jamt/feature/check_in/check_in.dart';

class CheckInPage extends StatelessWidget {
  const CheckInPage({super.key});
  static const String routeName = '/checkIn';
  static Route<void> route() {
    return PageRouteBuilder<void>(
        opaque: false, // 👈 Esto es lo clave para permitir transparencia
        pageBuilder: (_, __, ___) => const CheckInPage(),
      settings: const RouteSettings(name: routeName),
    );
  }



  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => CheckInBloc(
          getQrStateSemiPlenaryUseCase: GetQrStateSemiPlenaryUseCase(
              context.read<SemiPlenaryRepository>()
          )
        )
          ..add(CheckInPageSubscriptionRequested()),
        child:  CheckInScreen()
    );
  }
}