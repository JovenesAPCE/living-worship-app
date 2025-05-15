import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:jamt/constants/constants.dart';

class CardGuide extends Equatable {
  final String title;
  final String body;
  final Color colorText;

  const CardGuide({this.title = "", this.body = "", this.colorText =  AppColor.textGrey});

  @override
  List<Object?> get props => [title, body];

}