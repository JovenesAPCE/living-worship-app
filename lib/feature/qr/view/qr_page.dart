import 'package:domain/domain.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jamt/constants/app_color.dart';
import 'package:jamt/extensions/extensions.dart';
import 'package:jamt/feature/qr/bloc/qr_bloc.dart';
import 'package:jamt/feature/qr/qr.dart';

class QRPage extends StatelessWidget {
  const QRPage({super.key});
  static const String routeName = '/qr';
  static Route<void> route() {
    return MaterialPageRoute<void>(
      builder: (_) => const QRPage(),
      settings: const RouteSettings(name: routeName),
    );
  }

  @override
  Widget build(BuildContext context) {
    context.setPWAThemeColor(AppColor.orangeMain.toHex());
    return BlocProvider(
        create: (context) => QrBloc(
          decryptSemiPlenaryQr: DecryptSemiPlenaryQr(
              context.read<SemiPlenaryRepository>()
          ),
          registerSemiPlenaryCheckInUseCase: RegisterSemiPlenaryCheckInUseCase(
              context.read<SemiPlenaryRepository>()
          ),
          registerSemiPlenaryCheckOutUseCase: RegisterSemiPlenaryCheckOutUseCase(
              context.read<SemiPlenaryRepository>()
          )
        )
          ..add(QRPageSubscriptionRequested()),
        child:  ScanQrScreen()
    );
  }
}