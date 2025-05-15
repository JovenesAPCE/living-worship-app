import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:jamt/constants/constants.dart';
import 'package:jamt/widget/rich_text_from_html_lite.dart';

class ScheduleScreen extends StatelessWidget {
  const ScheduleScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
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
                      AppColor.purpleDark,
                      AppColor.orangeMain
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
                margin: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: 280,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                            image:AssetImage(AppImages.guestCard1),
                            fit: BoxFit.cover,
                          ),
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(12),
                            topRight: Radius.circular(12),
                          )
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(
                          top: 16,
                          left: 16,
                          right: 16
                      ),
                      child:  const Text(
                        "HORARIOS",
                        style: TextStyle(
                            fontSize: 24,
                            fontFamily: AppFont.fontTwo),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(
                          vertical: 16,
                          horizontal: 32
                      ),
                      child: RichTextFromHtmlLite("<p><b>VIERNES - 30/05</b></p>"
                          "<p><b>✦ 8:00</b> - Acreditación en el Campus UPeU.</p>"
                          "<p><b>✦ 18:20</b> - Apertura de la Carpa Móvil</p>"
                          "<p><b>✦ 18:45</b> - Concentración en la Carpa principal</p>"
                          "<p>– Programa de Apertura</p>"
                          "<p><b>✦ 19:20</b> - Presentación por regiones</p>"
                          "<p><b>✦ 20:28</b> - Palabras de Apertura</p>"
                          "<p><b>✦ 20:48</b> - Joven News</p>"
                          "<p><b>✦ 21:00</b> - Mensaje</p>"
                          "<p><b>✦ 22:10</b> - Regreso al área de campamento</p>"
                          "<p><b>✦ 00:00</b> - Descanso y silencio total</p>"
                          "<p></p>"
                          "<p><b>SÁBADO - 31/05</b></p>"

                          "<p><b>MAÑANA</b></p>"
                          "<p><b>✦ 7:20</b> - Concentración en la Carpa principal</p>"
                          "<p><b>✦ 8:00</b> - Maranata Class</p>"
                          "<p><b>✦ 8:45</b> - Semiplenarias y Expo Joven</p>"
                          "<p><b>✦ 9:56</b> - Concentración en la Carpa principal</p>"
                          "<p><b>✦ 10:30</b> - Desfile Maranata Class</p>"
                          "<p><b>✦ 11:20</b> - Mensaje</p>"
                          "<p><b>✦ 12:10</b> - Bautismo</p>"
                          "<p></p>"
                          "<p><b>TARDE</b></p>"
                          "<p><b>✦ 12:30</b> - Tiempo de Almuerzo</p>"
                          "<p><b>✦ 14:30</b> - Concentración en la Carpa principal</p>"
                          "<p><b>✦ 15:00</b> - Maranata Faith</p>"
                          "<p><b>✦ 15:15</b> - Lanzamiento Living Worship</p>"
                          "<p><b>✦ 15:35</b> - Semiplenarias y Expo Joven</p>"
                          "<p><b>✦ 16:45</b> - Concentración en la Carpa principal</p>"
                          "<p><b>✦ 17:05</b> - Concierto</p>"
                          "<p><b>✦ 17:45</b> - Lanzamiento Misión Caleb 2025</p>"
                          "<p><b>✦ 18:15</b> - Despedida de Sábado</p>"
                          "<p><b>✦ 18:25</b> - Tiempo de Cena</p>"
                          "<p></p>"
                          "<p><b>NOCHE</b></p>"
                          "<p><b>✦ 19:30</b> - Concentración en la Carpa principal</p>"
                          "<p><b>✦ 19:40</b> - Inicia ceremonia de investidura JA</p>"
                          "<p><b>✦ 20:35</b> - Joven News</p>"
                          "<p><b>✦ 20:50</b> - Mensaje</p>"
                          "<p><b>✦ 21:40</b> - Anuncios y despedida</p>"
                          "<p><b>✦ 23:00</b> - Regreso al área de campamento</p>"
                          "<p><b>✦ 00:00</b> - Descanso y silencio total</p>"
                          "<p></p>"
                          "<p><b>DOMINGO - 01/06</b></p>"
                          "<p><b>✦ 7:20</b> - Concentración en la Carpa principal</p>"
                          "<p><b>✦ 7:30</b> - Inicia programa de premiación y Clausura</p>"
                          "<p><b>✦ 7:50</b> - Reconocimiento a espacios Maranata Class, Club de líderes, etc.</p>"
                          "<p><b>✦ 8:20</b> - Joven News</p>"
                          "<p><b>✦ 8:30</b> - Mensaje</p>"
                          "<p><b>✦ 9:15</b> - Palabras de Clausura</p>"
                          "<p><b>✦ 9:30</b> - Gynkana Joven (losas deportivas)</p>"
                          "<p><b>✦ 11:30</b> - Premiación y Despedida</p>"
                          "<b>✦ 12:00</b> - Regreso a casa",
                         currentStyle: TextStyle(
                             color: Colors.black,
                             fontSize: 14,
                             height: 2.2,
                             fontFamily: AppFont.font,
                             fontWeight: FontWeight.w500
                         ),
                      ),
                    )
                  ],
                )
            )
          ],
        ),
        Padding(padding: EdgeInsets.only(bottom: 200))
      ],
    );;
  }
}
