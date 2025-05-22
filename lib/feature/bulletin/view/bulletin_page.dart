import 'dart:ui';

import 'package:domain/domain.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jamt/constants/app_color.dart';
import 'package:jamt/extensions/extensions.dart';
import 'package:jamt/feature/bulletin/bloc/bulletin_bloc.dart';
import 'package:jamt/feature/bulletin/bulletin.dart';
import 'package:jamt/feature/tab_home/tab_home.dart';
import 'package:jamt/navigation/navigation.dart';
import 'package:jamt/widget/home_app_bar.dart';
import 'package:jamt/widget/home_drawer.dart';

class BulletinPage extends StatelessWidget {
  const BulletinPage({super.key});

  static const String routeName = '/bulletin';

  static Route<void> route() {
    return MaterialPageRoute<void>(
        builder: (_) => const BulletinPage(),
        settings: const RouteSettings(name: routeName),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => BulletinBloc(
            updateNotificationUseCase: UpdateNotificationUseCase(
                context.read<NotificationRepository>()
            ),
            getNotificationUseCase: GetNotificationUseCase(
                context.read<NotificationRepository>()
            ))..add(LoadBulletin()),
        child:  Scaffold(
          drawer: const HomeDrawer(),
          body: Stack(
            children: [
              CustomScrollView(
                slivers: [
                  HomeAppBar(
                    color: AppColor.blue2,
                    isPop: true,
                  ),
                  SliverToBoxAdapter(
                    child: BulletinScreen(),
                  )
                ],
              )
            ],
          ),
        )
    );
  }
}

class _LogoutButton extends StatelessWidget {
  const _LogoutButton();

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      child: const Text('Logout'),
      onPressed: () {
        context.read<NavigationBloc>().add(AuthenticationLogoutPressed());
      },
    );
  }
}

