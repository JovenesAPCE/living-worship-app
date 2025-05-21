import 'package:flutter/material.dart';
import 'package:jamt/constants/app_icon.dart';
import 'package:jamt/constants/constants.dart';

enum Destination {
  none(AppIcon.home, 'nada'),
  tabHome(AppIcon.home, 'Inicio'),
  sessions(Icons.bookmark, 'Semiplenarias'),
  profile(AppIcon.hand, 'Misionero Caleb'),
  qrScan(AppIcon.qrcode, 'Escanear'),
  qrCheckIn(AppIcon.qrcode, 'Escanear'),
  qrCheckOut(AppIcon.qrcode, 'Escanear'),
  guests(Icons.groups, 'Invitados'),
  bulletins(Icons.article, 'Boletines'),
  trivia(Icons.tour, 'Trivia'),
  map(AppIcon.map, 'Mapa'),
  menu(Icons.menu, 'Menú'),
  logout(Icons.logout, 'Cerrar Sesion');

  const Destination(this.icon, this.label);

  final IconData icon;
  final String label;

}