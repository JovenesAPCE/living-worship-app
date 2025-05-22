import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jamt/constants/constants.dart';
import 'package:jamt/extensions/extensions.dart';
import 'package:jamt/feature/bulletin/bloc/bulletin_bloc.dart';
import 'package:jamt/widget/progress_status.dart';
import 'package:jamt/widget/rich_text_from_html_lite.dart';

class BulletinScreen extends StatelessWidget {
  const BulletinScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return  BlocConsumer<BulletinBloc, BulletinState>(
        listener: (context, state) {

    },
    builder: (context, state) {

          return Container(
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
                                          'Información Oficial',
                                          style: TextStyle(
                                            fontSize: 24,
                                            fontFamily: AppFont.fontTwo,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        if(state.progress.show)
                                          Center(
                                            child: ProgressStatus(
                                              message: state.progress.message,
                                              type: state.progress.type,
                                              onRefreshPressed: (){
                                                context.read<BulletinBloc>().add(LoadBulletin());
                                              },
                                            ),
                                          ),
                                        const SizedBox(height: 24),
                                        ...state.notifications.map((notification){
                                          return NotificationItem(
                                            message: notification.message,
                                            imageUrl: notification.imageUrl,
                                            
                                            dateString: notification.dateString,
                                          );
                                        }),
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
                    ),
                  ],
                ),
                Padding(padding: EdgeInsets.only(bottom: 200)),
              ],
            ),
          );
    });
  }


}

class NotificationItem extends StatelessWidget {
  final String message;
  final String? imageUrl;
  final String? dateString;

  const NotificationItem({
    super.key,
    required this.message,
    this.imageUrl,
    this.dateString,
  });

  @override
  Widget build(BuildContext context) {
    final dateTime = _parseDateTime(dateString);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if ((imageUrl ?? "").isNotEmpty)
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: ClipRRect(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(4), bottom: Radius.circular(4)),
            child: CachedNetworkImage(
              imageUrl: imageUrl!,
              height: 180,
              width: double.infinity,
              fit: BoxFit.cover,
              placeholder: (context, url) => const Center(child: CircularProgressIndicator()),
              errorWidget: (context, url, error) => const Icon(Icons.broken_image, size: 48, color: Colors.grey),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (dateTime != null)
                Text(
                  _formatDateTime(dateTime),
                  style: const TextStyle(
                    fontSize: 12,
                    color: AppColor.textGrey,
                  ),
                ),
              const SizedBox(height: 8),
              RichTextFromHtmlLite(
                message,
                currentStyle: const TextStyle(
                  fontSize: 14,
                  color: Colors.black87,
                  height: 1.4,
                  fontFamily: AppFont.font,
                ),
              ),
            ],
          ),
        ),

        const Divider(
          height: 2,
          color: Color(0xFFE0E0E0),
          indent: 8,
          endIndent: 8,
        ),
        const SizedBox(height: 16),
      ],
    );
  }

  /// Intenta parsear la fecha desde String a DateTime
  DateTime? _parseDateTime(String? raw) {
    if (raw == null || raw.isEmpty) return null;
    try {
      return DateTime.parse(raw); // ISO 8601: "2025-05-20T10:30:00"
    } catch (_) {
      // Si viene en otro formato, intenta manualmente
      try {
        return DateTime.tryParse(raw.replaceAll('/', '-'));
      } catch (_) {
        return null;
      }
    }
  }

  String _formatDateTime(DateTime dt) {
    final date = "${dt.day.toString().padLeft(2, '0')}/${dt.month.toString().padLeft(2, '0')}/${dt.year}";
    final time = "${dt.hour.toString().padLeft(2, '0')}:${dt.minute.toString().padLeft(2, '0')}";
    return "$date • $time";
  }
}