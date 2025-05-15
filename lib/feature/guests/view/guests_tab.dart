import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jamt/feature/guests/guests.dart';

class GuestsTab extends StatelessWidget {
  const GuestsTab({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => GuestsBloc(),
        child:  GuestsScreen()
    );
  }
}