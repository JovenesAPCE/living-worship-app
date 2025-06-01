import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:jamt/constants/constants.dart';
import 'package:jamt/extensions/extensions.dart';
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
                            image:AssetImage(AppImages.scheduleCard1),
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
                          "<p><b>✦ 18:55</b> - Apertura de la Carpa Móvil</p>"
                          "<p><b>✦ 19:00</b> - Concentración en la Carpa principal</p>"
                          "<p>– Programa de Apertura</p>"
                          "<p><b>✦ 20:17</b> - Joven News</p>"
                          "<p><b>✦ 20:20</b> - Énfasis por regiones</p>"
                          "<p><b>✦ 21:00</b> - Mensaje central</p>"
                          "<p><b>✦ 22:30</b> - Regreso al área de campamento</p>"
                          "<p><b>✦ 00:00</b> - Descanso y silencio total</p>"
                          "<p></p>"

                          "<p><b>SÁBADO - 31/05</b></p>"

                          "<p><b>MAÑANA</b></p>"
                          "<p><b>✦ 7:30</b> - Concentración en la Carpa principal</p>"
                          "<p><b>✦ 8:00</b> - Meditación</p>"
                          "<p><b>✦ 8:19</b> - Oración Intercesora</p>"
                          "<p><b>✦ 8:26</b> - Semiplenarias y Expo Joven</p>"
                          "<p><b>✦ 9:45</b> - Plenaria: Adoración en la Música</p>"
                          "<p>(Pedro Valença y Joyce Carnassale)</p>"
                          "<p><b>✦ 10:26</b> - Maranata Class</p>"
                          "<p><b>✦ 11:31</b> - Mensaje central</p>"
                          "<p></p>"
                          "<p><b>TARDE</b></p>"
                          "<p><b>✦ 12:30</b> - Tiempo de Almuerzo</p>"
                          "<p><b>✦ 14:30</b> - Concentración en la Carpa principal</p>"
                          "<p><b>✦ 14:56</b> - Maranata Faith</p>"
                          "<p><b>✦ 15:28</b> - Semiplenarias y Expo Joven</p>"
                          "<p><b>✦ 16:53</b> - Concentración en la Carpa principal</p>"
                          "<p><b>✦ 17:08</b> - Testimonios de Adoración Viva</p>"
                          "<p>Lanzamiento Misión Caleb 2025</p>"
                          "<p>Concierto</p>"
                          "<p><b>✦ 18:50</b> - Tiempo de Cena</p>"
                          "<p></p>"
                          "<p><b>NOCHE</b></p>"
                          "<p><b>✦ 20:30</b> - Concentración en la Carpa principal</p>"
                          "<p><b>✦ 20:50</b> - Énfasis por regiones</p>"
                          "<p><b>✦ 21:30</b> - Mensaje</p>"
                          "<p><b>✦ 22:10</b> - Regreso al área de campamento</p>"
                          "<p><b>✦ 00:00</b> - Descanso y silencio total</p>"
                          "<p></p>"
                          "<p><b>DOMINGO - 01/06</b></p>"
                          "<p><b>✦ 7:30</b> - Concentración en la Carpa principal</p>"
                          "<p><b>✦ 7:45</b> - Inicia programa de Investidura JA 2025</p>"
                          "<p><b>✦ 8:51</b> - Joven News</p>"
                          "<p><b>✦ 9:11</b> - Mensaje central</p>"
                          "<p><b>✦ 9:53</b> - Reconocimiento Maranata Class</p>"
                          "<p><b>✦ 10:08</b> - Reconocimiento y Clausura</p>"
                          "<p><b>✦ 10:21</b> - Gynkana",
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
