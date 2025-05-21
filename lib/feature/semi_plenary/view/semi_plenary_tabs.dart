import 'package:domain/domain.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jamt/feature/semi_plenary/semi_plenary.dart';
import 'package:jamt/feature/tab_home/tab_home.dart';

class SemiPlenaryTabs extends StatelessWidget {
  const SemiPlenaryTabs({super.key});

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
          )
        ),
        child: BlocListener<TabHomeBloc, TabHomeState>(
          listenWhen: (previous, current) => previous.destination != current.destination &&
              current.destination == TabDestination.sessions,
          listener: (context, state){
            context.read<SemiPlenaryBloc>().add(LoadSemiPlenary());
          },
          child: SessionScreen(),
        )
    );
  }


}