import 'package:domain/domain.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jamt/feature/bulletin/bloc/bulletin_bloc.dart';
import 'package:jamt/feature/bulletin/bulletin.dart';
import 'package:jamt/feature/tab_home/bloc/tab_home_bloc.dart';
import 'package:jamt/feature/tab_home/models/models.dart';

class BulletinTab extends StatelessWidget {
  const BulletinTab({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => BulletinBloc(
            updateNotificationUseCase: UpdateNotificationUseCase(
                context.read<NotificationRepository>()
            ),
            getNotificationUseCase: GetNotificationUseCase(
                context.read<NotificationRepository>()
            )),
    child: BlocListener<TabHomeBloc, TabHomeState>(
      listenWhen: (previous, current) => previous.destination != current.destination &&
          current.destination == TabDestination.bulletin,
      listener: (context, state){
        context.read<BulletinBloc>().add(LoadBulletin());
      },
      child: BulletinScreen(),
    ));
  }
}