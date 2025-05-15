import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jamt/feature/guide/guide.dart';

class GuideTab extends StatelessWidget {
  const GuideTab({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => GuideBloc(),
        child:  GuideScreen()
    );
  }
}