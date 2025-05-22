import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:jamt/constants/constants.dart';
import 'package:jamt/extensions/extensions.dart';
import 'package:jamt/widget/widget.dart';

class EventScreen extends StatelessWidget {
  const EventScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return  Container(
      color: AppColor.purpleLight,
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
                        AppColor.blueDark,
                        AppColor.blue2,
                        AppColor.purpleLight
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
                                  image:AssetImage(AppImages.guideCard1),
                                  fit: BoxFit.cover,
                                ),
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(12),
                                  topRight: Radius.circular(12),
                                )
                            ),
                          ),
                          Container(
                            height: 300,
                            decoration: BoxDecoration(
                                color: Colors.black.withOpacity(0.2),
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(12),
                                  topRight: Radius.circular(12),
                                )
                            ),
                          ),
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
                            Text(
                              "El Evento",
                              style: TextStyle(
                                  fontSize: 16,
                                  color: AppColor.blueLight,
                                  fontFamily: AppFont.font,
                                  fontWeight: FontWeight.w700
                              ),
                            ),
                            Text(
                              "Objetivos Principales",
                              style: TextStyle(
                                  fontSize: 24,
                                  fontFamily: AppFont.fontTwo),
                            ),
                            Padding(
                                padding: EdgeInsets.all(8)),
                            RichTextFromHtmlLite(
                                "<b>Objetivo General:</b> "
                                    "Fomentar una experiencia de adoración auténtica y fortalecer el liderazgo y la misión de los jóvenes adventistas a través de capacitaciones, dinámicas y el compromiso con el evangelismo."
                                "<p></p>"
                                "<p></p>"
                                "<b>Objetivos Específicos:</b> "
                                "<ul>"
                                  "<li>Inspirar a los jóvenes a vivir una adoración que trascienda y se refleje en su estilo de vida.</li>"
                                  "<li>Capacitar a los jóvenes en liderazgo y discipulado a través del  Maranata Class.</li>"
                                  "<li>Lanzar oficialmente Misión Caleb, impulsando la participación joven en el evangelismo y servicio a los demás.</li>"
                                  "<li>Fortalecer el sentido de comunidad y pertenencia entre los jóvenes adventistas.</li>"
                                  "<li>Promover el estudio de la Biblia y la formación de líderes de impacto misionero.</li>"
                                "</ul>"),
                            const Text(
                              'Informaciones',
                              style: TextStyle(
                                fontSize: 24,
                                fontFamily: AppFont.fontTwo
                              ),
                            ),
                            const SizedBox(height: 24),
                            _InfoItem(
                              icon: Icons.location_on_outlined,
                              title: 'Lugar de las programaciones:',
                              description: 'Carpa Movil . UPeU - Sede Lima',
                            ),
                            const SizedBox(height: 24),
                            _InfoItem(
                              icon: Icons.alt_route_outlined,
                              title: 'Lugar de campamento:',
                              description: 'Áreas verdes de la UPeU, Sede Lima - cercano a la carpa móvil.',
                            ),
                            const SizedBox(height: 24),
                            _InfoItemWithList(
                              icon: Icons.groups_outlined,
                              title: 'Público destinatario:',
                              items: [
                                'Jóvenes de las iglesias locales, directores de Maranata Class.',
                                'Distritales, regionales y coordinadores de jóvenes.',
                                'Ancianos y pastores distritales, relacionados al trabajo de jóvenes.',
                              ],
                            ),
                            Padding(
                                padding: EdgeInsets.all(16)),
                            const Text(
                              '¿Por qué la UPEU?',
                              style: TextStyle(
                                  fontSize: 24,
                                  fontFamily: AppFont.fontTwo
                              ),
                            ),
                            Padding(
                                padding: EdgeInsets.all(8)),
                            RichTextFromHtmlLite("<p><p>El congreso se llevará a cabo en la Universidad Peruana Unión (UPEU), ubicada en el kilómetro 19.5 de la Carretera Central. Esta sede ha sido elegida por varias razones clave:</p></p>"
                            "<p><p><b>• Amplias áreas verdes:</b> Espacios abiertos que favorecen un ambiente de comunión y actividades al aire libre.</p></p>"
                            "<p><p><b>• Infraestructura adecuada:</b> La UPEU cuenta con una carpa móvil que puede albergar a una gran cantidad de personas, garantizando comodidad para los asistentes.</p></p>"
                            "<p><p><b>• Seguridad:</b> La universidad es un espacio cerrado y controlado, lo que brinda tranquilidad a los participantes y organizadores.</p></p>"
                            "<p><p>• El clima a fines de mayo e inicios de junio  son favorables y sin temperaturas extremas. Poca probabilidad de llluvia.</p></p>"),
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

class _InfoItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final String description;

  const _InfoItem({
    required this.icon,
    required this.title,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, size: 32, color: Colors.black),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 16,
                  fontFamily: AppFont.fontTwo
                ),
              ),
              const SizedBox(height: 8),
              Text(
                description,
                style: const TextStyle(
                  color: AppColor.textGrey,
                  fontSize: 14,
                  height: 1.5,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _InfoItemWithList extends StatelessWidget {
  final IconData icon;
  final String title;
  final List<String> items;

  const _InfoItemWithList({
    required this.icon,
    required this.title,
    required this.items,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, size: 32, color: Colors.black),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                    fontSize: 16,
                    fontFamily: AppFont.fontTwo
                ),
              ),
              const SizedBox(height: 8),
              ...items.map((item) => Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      '• ',
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.black,
                      ),
                    ),
                    Expanded(
                      child: Text(
                        item,
                        style: const TextStyle(
                          color: AppColor.textGrey,
                          fontSize: 14,
                          height: 1.5,
                        ),
                      ),
                    ),
                  ],
                ),
              )),
            ],
          ),
        ),
      ],
    );
  }
}