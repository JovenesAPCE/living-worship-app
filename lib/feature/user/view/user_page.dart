import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jamt/constants/app_color.dart';
import 'package:jamt/feature/user/user.dart';
import 'package:jamt/widget/widget.dart';

class UserPage extends StatelessWidget {
  const UserPage({super.key});
  static const String routeName = '/user';

  static Route<void> route() {
    return MaterialPageRoute<void>(
      builder: (_) => const UserPage(),
      settings: const RouteSettings(name: routeName),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => UserBloc(),
        child: Scaffold(
          drawer: const HomeDrawer(),
          body: NestedScrollView(
            headerSliverBuilder: (context, innerBoxIsScrolled) => [
              HomeAppBar(
                color: AppColor.orangeMain,
              ),
            ],
            body: UserScreen(),
          ),
        )
    );
  }
}