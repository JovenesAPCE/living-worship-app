import 'package:domain/domain.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jamt/feature/user/user.dart';

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
        create: (context) => UserBloc(
            saveUserDecisionUseCase: SaveUserDecisionUseCase(
                context.read<UserRepository>()
            ),
          getPathWhatsAppGroupUseCase: GetPathWhatsAppGroupUseCase(
              context.read<UserRepository>()
          ),
          getUserDecisionUseCase: GetUserDecisionUseCase(
              context.read<UserRepository>()
          )
        )..add(RequestAddUser()),
        child: UserScreen()
    );
  }
}