import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jamt/feature/activities/activities.dart';

class ActivitiesTab extends StatelessWidget {
  const ActivitiesTab({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => ActivitiesBloc(),
        child:  ActivitiesScreen()
    );
  }
}