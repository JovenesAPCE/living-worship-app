import 'dart:ui';

import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jamt/constants/constants.dart';
import 'package:jamt/feature/guide/bloc/guide_bloc.dart';
import 'package:jamt/widget/widget.dart';

class GuideScreen extends StatelessWidget {
  const GuideScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<GuideBloc, GuideState>(
      listener: (context, state) {},
      builder: (context, state) {
        return Container(
          color: AppColor.orangeMain,
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
                              Positioned.fill(
                                  child: Container(
                                    decoration: BoxDecoration(
                                        color: Colors.black.withOpacity(0.2),
                                        borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(12),
                                          topRight: Radius.circular(12),
                                        )
                                    ),
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
                                Text(
                                  "MARANATA",
                                  style: TextStyle(
                                      fontSize: 16,
                                      color: AppColor.blueLight,
                                      fontFamily: AppFont.font,
                                      fontWeight: FontWeight.w700
                                  ),
                                ),
                                Text(
                                  "Orientación general sobre el evento.",
                                  style: TextStyle(
                                      fontSize: 24,
                                      fontFamily: AppFont.fontTwo),
                                ),
                                Padding(
                                    padding: EdgeInsets.all(4)),
                              ...List.generate(state.cardGuides.length, (index) {
                                  final card = state.cardGuides[index];
                                  return Container(
                                    margin: EdgeInsets.only(
                                      top: 8,
                                      left: 16,
                                      right: 16,
                                      bottom: 0
                                    ),
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        GestureDetector(
                                          onTap: (){
                                            context.read<GuideBloc>().add(GuideSelected(card));
                                          },
                                          child: Row(
                                            children: [
                                              Icon(Icons.check, color: AppColor.blueLight, size: 20,),
                                              Padding(padding: EdgeInsets.all(6)),
                                              Expanded(child: Text(card.title,
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontWeight: FontWeight.w500
                                                ),)),
                                              Transform.rotate(
                                                angle: math.pi / (state.selectCardGuide == card?1:0.5) , // en radianes (0.75 ≈ 270°)
                                                child: Icon(Icons.arrow_drop_down),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Padding(padding: EdgeInsets.all(4)),
                                        AnimatedSize(
                                          duration: const Duration(milliseconds: 200),
                                          curve: Curves.easeInOut,
                                          child: state.selectCardGuide == card
                                              ? Container(
                                            padding: const EdgeInsets.only(top: 6, left: 4, bottom: 16),
                                            child: RichTextFromHtmlLite(card.body,
                                              currentStyle: TextStyle(
                                                  color: card.colorText,
                                                  fontSize: 13,
                                                  height: 1.9,
                                                  fontFamily: AppFont.font,
                                                  fontWeight: FontWeight.w500
                                              ),),
                                          )
                                              : const SizedBox.shrink(),
                                        )
                                      ],
                                    ),
                                  );
                                }),

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
      },
    );
  }
}
