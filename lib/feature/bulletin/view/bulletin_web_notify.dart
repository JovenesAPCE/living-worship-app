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

class BulletinWebNotify {
  static const String routeName = '/web_notify';
}
