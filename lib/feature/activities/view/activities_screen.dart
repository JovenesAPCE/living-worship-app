
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jamt/constants/constants.dart';
import 'package:jamt/feature/activities/activities.dart';
import 'package:jamt/widget/widget.dart';

class ActivitiesScreen extends StatelessWidget {
  const ActivitiesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ActivitiesBloc, ActivitiesState>(
        listener: (context, state) {},
        builder: (context, state) {
          return Container(
            color: AppColor.blue2,
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
                              AppColor.orangeMain,
                              AppColor.purpleDark,
                              AppColor.blue2
                            ],
                            stops: [0.0, 0.6, 1.0],
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
                        padding: EdgeInsets.all(16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "ACTIVIDADES",
                              style: TextStyle(
                                  fontSize: 24,
                                  fontFamily: AppFont.fontTwo),
                            ),
                            const SizedBox(height: 32),
                            ...List.generate(state.cardActivities.length, (index) {
                              final card = state.cardActivities[index];
                              final indexImage = (index) % state.cardActivities.length;

                              return
                                Column(
                                  children: [
                                    GestureDetector(
                                      onTap: (){
                                        context.read<ActivitiesBloc>().add(ActivitySelected(card));
                                      },
                                      child: Stack(
                                        children: [
                                          Container(
                                            height: 75,
                                            padding: EdgeInsets.all(16),
                                            decoration: BoxDecoration(
                                              color: AppColor.colorPrimary,
                                              borderRadius: BorderRadius.all(Radius.circular(8)),
                                              image: DecorationImage(
                                                image: AssetImage(getActivityCardByIndex(indexImage)),
                                                fit: BoxFit.cover,
                                                colorFilter: ColorFilter.mode(
                                                  AppColor.purpleDark2, // Ajusta opacidad según necesidad
                                                  BlendMode.colorDodge,              // Tipo de mezcla para oscurecer
                                                ),
                                              ),
                                            ),
                                            child: Row(
                                              crossAxisAlignment: CrossAxisAlignment.center,
                                              mainAxisAlignment: MainAxisAlignment.end,
                                              children: [
                                                Text(card.title.toUpperCase(),
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 24,
                                                        fontWeight: FontWeight.bold,
                                                        fontFamily: AppFont.fontTwo)
                                                )
                                              ],
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                    Padding(padding: EdgeInsets.all(4)),
                                    AnimatedSize(
                                      duration: const Duration(milliseconds: 200),
                                      curve: Curves.easeInOut,
                                      child: state.selectCardActivities == card
                                          ? Container(
                                        padding: const EdgeInsets.only(top: 6, left: 4, bottom: 24),
                                        child: Column(
                                          children: [
                                            ...card.details.map((detail){
                                                return Column(
                                                  children: [
                                                    RichTextFromHtmlLite(detail.body),
                                                    if(detail.image.isNotEmpty)
                                                      Container(
                                                        margin: EdgeInsets.only(
                                                            top: 8,
                                                            bottom: 8
                                                        ),
                                                        height: card.details.length == 1? 250: 200,
                                                        child: Image.asset(
                                                          detail.image,
                                                          fit: BoxFit.contain,
                                                        ),
                                                      )
                                                  ],
                                                );
                                            }),
                                          ],
                                        ),
                                      )
                                          : const SizedBox.shrink(),
                                    )
                                  ],
                                );
                            }),



                          ],
                        )
                    )
                  ],
                ),
                Container(
                  margin: EdgeInsets.symmetric(vertical: 0, horizontal: 16),
                  decoration: BoxDecoration(
                      color: AppColor.skyBlue,
                      borderRadius: BorderRadius.all(Radius.circular(12))
                  ),
                  child: Column(
                    children: [
                      Container(
                        padding: EdgeInsets.all(16),
                        child: Image.asset(AppImages.mainLogoWhite, height: 28),
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(
                          horizontal: 16,
                        ),
                        padding: EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 20
                        ),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.all(Radius.circular(12))
                        ),
                        child: Text(
                          "Un movimiento de celebración, inspiración, motivación y formación de jóvenes líderes, apuntando a un proceso de crecimiento integral de los jóvenes adventistas.",
                          style: TextStyle(
                              color: AppColor.textGrey,
                              fontSize: 13,
                              height: 1.8,
                              fontFamily: AppFont.font,
                              fontWeight: FontWeight.w500
                          ),
                        ),
                      ),
                      Padding(padding: EdgeInsets.all(12))
                    ],
                  ),
                ),
                Padding(padding: EdgeInsets.only(bottom: 200))
              ],
            ),
          );
        }
    );
  }

  String getActivityCardByIndex(int index) {
    switch (index % 5) {
      case 0:
        return AppImages.activityCard2;
      case 1:
        return AppImages.activityCard4;
      case 2:
        return AppImages.activityCard1;
      case 3:
        return AppImages.activityCard3;
      case 4:
        return AppImages.activityCard5;
      default:
        return AppImages.activityCard1; // fallback
    }
  }


}
