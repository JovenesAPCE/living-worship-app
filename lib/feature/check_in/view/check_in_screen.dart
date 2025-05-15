import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jamt/constants/constants.dart';
import 'package:jamt/feature/check_in/check_in.dart';
import 'package:jamt/navigation/bloc/navigation_bloc.dart';
import 'package:jamt/navigation/models/destination.dart';
import 'package:jamt/widget/widget.dart';
import 'package:lottie/lottie.dart';

class CheckInScreen extends StatelessWidget {
  const CheckInScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CheckInBloc, CheckInState>(
        listener: (context, state) {

    },
    builder: (context, state){
      return state.hasRegister? Container(
        child: Stack(
          children: [
            GestureDetector(
              onTap: () {
                Navigator.of(context).pop(); // ✅ cerrar al tocar fuera
              },
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 2.0, sigmaY: 2.0),
                child: Container(
                  color: Colors.black.withOpacity(0.3), // opcional: oscurecimiento ligero
                ),
              ),
            ),
            Center(
                child: Material(
                  color: Colors.transparent,
                  child:  ClipRRect(
                    borderRadius: BorderRadius.circular(24),
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width * 0.7,
                      height: 500,
                      child: Stack(
                        children: [
                          Container(
                            color: pastelizarColor(state.color, 0.9),
                            padding: const EdgeInsets.all(24),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [

                                const SizedBox(height: 100),
                                const Text(
                                  "Asistencia ya fue registrada",
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black87,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  state.semiPlenaryTitle??"",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontSize: 32,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black,
                                      fontFamily: AppFont.fontTwo
                                  ),
                                ),
                                Text(
                                  state.semiPlenaryTime??"",
                                  style: TextStyle(fontSize: 24, color: Colors.black),
                                ),
                                const SizedBox(height: 8),
                                const Text(
                                  "Ya registraste tu asistencia.\nNo puedes volver a ingresar.",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.black54,
                                  ),
                                ),
                                const SizedBox(height: 24),
                                ElevatedButton(
                                  onPressed: () => Navigator.of(context).pop(),
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.grey.shade800,
                                    minimumSize: const Size(double.infinity, 48),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                  ),
                                  child: const Text("Salir", style: TextStyle(color: Colors.white)),
                                ),
                              ],
                            ),
                          ),
                          Positioned(
                              top: 16,
                              left: 0,
                              right: 0,
                              child: Lottie.asset(AppLottie.checkErrorInfo,
                                height: 120,
                                width: 120,
                                fit: BoxFit.contain,
                              )),
                        ],
                      ),
                    ),
                  ),
                )
            ),
          ],
        ),
      ) : Scaffold(
        body: Stack(
          children: [
            Positioned.fill(child: Container(
              color: state.color,
            )),
            Positioned.fill(child: Container(
              color: Colors.black.withOpacity(0.1),
            )),
            Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 20),
                  SizedBox(
                    height: 150,
                    child: LottiePlayer(
                      assetPath: AppLottie.checkInCheck2,
                      speed: 0.5, // 50% más lento
                      repeat: true,
                    ),
                  ),
                  const Text(
                    "Registro exitoso",
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.white70,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    state.fullName??"",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 26,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontFamily: AppFont.fontTwo
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    formatDateTimeManual(state.checkInTime),
                    style: TextStyle(fontSize: 16, color: Colors.white),
                  ),
                  const SizedBox(height: 24),
                  Text(
                    state.action??"",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontFamily: AppFont.fontTwo
                    ),
                  ),
                  Text(
                    state.semiPlenaryTitle??"",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 48,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontFamily: AppFont.fontTwo
                    ),
                  ),
                  Text(
                    state.semiPlenaryTime??"",
                    style: TextStyle(fontSize: 24, color: Colors.white),
                  ),
                  const SizedBox(height: 24),
                  Text(
                    state.message??"",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 16, color: Colors.white70),
                  ),
                  const Spacer(),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColor.blue,
                      minimumSize: const Size(double.infinity, 48),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    ),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: const Text("Salir, si ya se registro mi asistencia", style: TextStyle(
                        color: Colors.white
                    ),),
                  ),
                  const SizedBox(height: 12),
                  TextButton(
                    onPressed: () {},
                    child: const Text(
                      "No cerrar hasta que se registre.",
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.white70),
                    ),
                  ),
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

  Color pastelizarColor(Color originalColor, [double factor = 0.7]) {
    // Mezcla el color original con blanco según el factor
    int blend(int channel) => ((255 - channel) * factor + channel).round();

    return Color.fromARGB(
      originalColor.alpha,
      blend(originalColor.red),
      blend(originalColor.green),
      blend(originalColor.blue),
    );
  }

}
