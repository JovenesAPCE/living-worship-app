import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:jamt/constants/constants.dart';

class BulletinScreen extends StatelessWidget {
  const BulletinScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return  Container(
      color: AppColor.yellow,
      child: Column(
        children: [
          Stack(
            children: [
              Positioned.fill(
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        AppColor.blue2,
                        AppColor.orangeMain,
                        AppColor.yellow
                      ],
                      stops: [0.0, 0.3, 1.0],
                    ),
                  ),
                ),
              ),
              Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(12))
                  ),
                  margin: EdgeInsets.symmetric(vertical: 20, horizontal: 16),

                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Stack(
                        children: [
                          Container(
                            height: 300,
                            decoration: BoxDecoration(
                                image: DecorationImage(
                                  image:AssetImage(AppImages.homeBulletin),
                                  fit: BoxFit.cover,
                                ),
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(12),
                                  topRight: Radius.circular(12),
                                )
                            ),
                          ),
                          Positioned.fill(
                              child: Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.all(Radius.circular(12)),
                                  color: Colors.black.withOpacity(0.2),
                                )
                              )
                          )
                        ],
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(
                            vertical: 16,
                            horizontal: 16
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Contenido en tarjeta blanca
                            Container(
                              width: double.infinity,
                              decoration: const BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    'Guía Orientaciones 01',
                                    style: TextStyle(
                                      fontSize: 24,
                                      fontFamily: AppFont.fontTwo,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(height: 24),
                                  Row(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      // Imagen boletín
                                      SizedBox(
                                        width: 120,
                                        height: 160,
                                        child: ClipRRect(
                                          borderRadius: BorderRadius.circular(16),
                                          child: Image.asset(
                                            AppImages.bulletin1, // Cambia a tu imagen boletín
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
                                      const SizedBox(width: 16),
                                      // Texto
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            GestureDetector(
                                              onTap: () {
                                                // Acción para abrir el PDF
                                              },
                                              child: const Text(
                                                'PDF cliqueable',
                                                style: TextStyle(
                                                  fontSize: 12,
                                                  color: AppColor.blueLight,
                                                ),
                                              ),
                                            ),
                                            const Text(
                                              'Versión actualizada',
                                              style: TextStyle(
                                                fontSize: 20,
                                                fontFamily: AppFont.fontTwo
                                              ),
                                            ),
                                            const SizedBox(height: 8),
                                            const Text(
                                              'Informaciones\nimportantes',
                                              style: TextStyle(
                                                fontSize: 12,
                                                color: AppColor.textGrey,
                                                height: 1.5,
                                              ),
                                            ),
                                            const SizedBox(height: 16),
                                            ElevatedButton(
                                              style: ElevatedButton.styleFrom(
                                                backgroundColor: AppColor.blueLight,
                                                shape: RoundedRectangleBorder(
                                                  borderRadius: BorderRadius.circular(8),
                                                ),
                                                minimumSize: const Size.fromHeight(48),
                                              ),
                                              onPressed: () {
                                                // Acción de descargar
                                              },
                                              child: const Text(
                                                'DESCARGAR PDF',
                                                style: TextStyle(
                                                  fontFamily: AppFont.fontTwo,
                                                  fontSize: 18,
                                                  color: Colors.white,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ),

                          ],
                        ),

                      ),
                      //MyTabbedPage()
                      //Padding(padding: EdgeInsets.only(bottom: 500)),
                    ],
                  )
              )
            ],
          ),
          Padding(padding: EdgeInsets.only(bottom: 200))
        ],
      ),
    );
  }
}
