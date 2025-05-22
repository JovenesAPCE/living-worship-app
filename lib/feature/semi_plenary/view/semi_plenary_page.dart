import 'dart:ui';

import 'package:domain/domain.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jamt/constants/app_color.dart';
import 'package:jamt/feature/semi_plenary/bloc/semi_plenary_bloc.dart';
import 'package:jamt/feature/semi_plenary/semi_plenary.dart';
import 'package:jamt/feature/tab_home/tab_home.dart';
import 'package:jamt/navigation/navigation.dart';
import 'package:jamt/widget/home_app_bar.dart';

class SemiPlenaryPage extends StatelessWidget {
  const SemiPlenaryPage({super.key});

  static const String routeName = '/semi_plenary';

  static Route<void> route() {
    return MaterialPageRoute<void>(
        builder: (_) => const SemiPlenaryPage(),
        settings: const RouteSettings(name: routeName),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => SemiPlenaryBloc(
            getSemiPlenariesUseCase: GetSemiPlenariesUseCase(
                context.read<SemiPlenaryRepository>()
            ),
            updateSemiPlenariesUseCase: UpdateSemiPlenariesUseCase(
                context.read<SemiPlenaryRepository>()
            ),
            registerSemiPlenariesUseCase: RegisterSemiPlenariesUseCase(
                context.read<SemiPlenaryRepository>()
            ),
            getRegisterSemiPlenariesUseCase: GetRegisterSemiPlenariesUseCase(
                context.read<SemiPlenaryRepository>()
            ),
            getUserUseCase: GetUserUseCase(
                context.read<UserRepository>()
            ),
            showCheckInUseCase: ShowCheckInUseCase(
                context.read<SemiPlenaryRepository>()
            ),
            showCheckOutUseCase: ShowCheckOutUseCase(
                context.read<SemiPlenaryRepository>()
            )
        )..add(LoadSemiPlenary()),
        child:  Scaffold(
        body: CustomScrollView(
          slivers: [
            HomeAppBar(
                isPop: true,
                color: AppColor.blue2),
            SliverToBoxAdapter(
              child: SessionScreen()),
          ],
        )
        )
    );
  }
}


