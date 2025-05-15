import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jamt/constants/constants.dart';
import 'package:jamt/feature/check_out/bloc/check_out_bloc.dart';
import 'package:jamt/widget/widget.dart';
import 'package:lottie/lottie.dart';

class CheckOutScreen extends StatelessWidget {
  const CheckOutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CheckOutBloc, CheckOutState>(
        listener: (context, state) {

    },
    builder: (context, state) {
      return  Scaffold(
        body: Stack(
          children: [
            Positioned.fill(child: Container(color: state.color)),
            Positioned.fill(child: Container(color: Colors.black.withOpacity(0.1))),
            Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 20),
                  SizedBox(
                    height: 250,
                    child: LottiePlayer(
                      assetPath: AppLottie.checkOut,
                      speed: 1, // 50% más lento
                      repeat: true,
                      playToHalf: false,
                    ),
                  ),
                  const Text(
                    "Salida registrada correctamente",
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.white70,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    state.fullName ?? "",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontFamily: AppFont.fontTwo,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    formatDateTimeManual(state.checkTime), // nueva hora de salida
                    style: const TextStyle(fontSize: 16, color: Colors.white),
                  ),
                  const SizedBox(height: 24),
                  Text(
                    "Gracias por participar",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontFamily: AppFont.fontTwo,
                    ),
                  ),
                  Text(
                    state.semiPlenaryTitle ?? "",
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 36,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 24),
                  const Text(
                    "Te esperamos en la próxima actividad.",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 16, color: Colors.white70),
                  ),
                  const Spacer(),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColor.blue,
                      minimumSize: const Size(double.infinity, 48),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: const Text("Cerrar", style: TextStyle(color: Colors.white)),
                  ),
                  const SizedBox(height: 38),
                ],
              ),
            )
          ],
        ),
      );
    });
  }

  String formatDateTimeManual(DateTime? dateTime) {
    if(dateTime == null) return "";
    const monthNames = [
      'Ene', 'Feb', 'Mar', 'Abr', 'May', 'Jun',
      'Jul', 'Ago', 'Sep', 'Oct', 'Nov', 'Dic'
    ];

    final day = dateTime.day.toString().padLeft(2, '0'); // "06"
    final month = monthNames[dateTime.month - 1];        // "May"
    final year = dateTime.year.toString();               // "2025"

    final hour = dateTime.hour;
    final minute = dateTime.minute.toString().padLeft(2, '0');

    final hour12 = hour % 12 == 0 ? 12 : hour % 12;
    final period = hour >= 12 ? 'pm' : 'am';

    return '$day $month $year a las $hour12:$minute $period';
  }
}
