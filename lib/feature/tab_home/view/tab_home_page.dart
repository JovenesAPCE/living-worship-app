import 'package:domain/domain.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jamt/feature/tab_home/tab_home.dart';
import 'package:jamt/navigation/navigation.dart';

class TabHomePage extends StatelessWidget {
  const TabHomePage({super.key});

  static const String routeName = '/home';

  static Route<void> route() {
    return MaterialPageRoute<void>(
        builder: (_) => const TabHomePage(),
        settings: const RouteSettings(name: routeName),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => TabHomeBloc(
          subscribeNotificationUseCase: SubscribeNotificationUseCase(
              context.read<NotificationRepository>()
          )
        )..add(IntTabHome()),
        child:  TabHomeScreen()
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

