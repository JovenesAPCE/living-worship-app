import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jamt/constants/app_color.dart';
import 'package:jamt/feature/guests/guests.dart';
import 'package:jamt/widget/home_app_bar.dart';

class GuestsPage extends StatelessWidget {
  const GuestsPage({super.key});

  static const String routeName = '/guests';

  static Route<void> route() {
    return MaterialPageRoute<void>(
        builder: (_) => const GuestsPage(),
        settings: const RouteSettings(name: routeName),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => GuestsBloc(),
        child:  Scaffold(
          backgroundColor: AppColor.yellow,
        body: CustomScrollView(
          slivers: [
            HomeAppBar(
                isPop: true,
                color: AppColor.blueLight),
            SliverToBoxAdapter(
              child: GuestsScreen()),
          ],
        )
        )
    );
  }
}


