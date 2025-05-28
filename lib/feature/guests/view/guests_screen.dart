
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jamt/constants/constants.dart';
import 'package:jamt/feature/guests/guests.dart';
import 'package:jamt/constants/constants.dart';
import 'package:jamt/widget/rich_text_from_html_lite.dart';

class GuestsScreen extends StatelessWidget {
  const GuestsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<GuestsBloc, GuestsState>(
        listener: (context, state) {},
        builder: (context, state) {
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
                            AppColor.blueLight,
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
                      margin: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            height: 280,
                            decoration: BoxDecoration(
                                image: DecorationImage(
                                  image:AssetImage(AppImages.guestCard2),
                                  fit: BoxFit.cover,
                                ),
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(12),
                                  topRight: Radius.circular(12),
                                )
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.symmetric(
                                vertical: 16,
                                horizontal: 16
                            ),
                            child:  const Text(
                              "Información de los invitados",
                              style: TextStyle(
                                  fontSize: 24,
                                  fontFamily: AppFont.fontTwo),
                            ),

                          ),
                          Container(
                            margin: const EdgeInsets.symmetric(horizontal: 16),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(color: Colors.grey.shade300),
                            ),
                            child: Row(
                              children: List.generate(state.tabs.length, (index) {
                                final isSelected = state.selectedIndex == index;
                                return Expanded(
                                  child: GestureDetector(
                                    onTap: () {
                                      context.read<GuestsBloc>().add(TabSelected(index));
                                    },
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(vertical: 12),
                                      decoration: BoxDecoration(
                                        color: isSelected ? Colors.grey.shade100 : Colors.transparent,
                                        borderRadius: index == 0
                                            ? const BorderRadius.only(
                                          topLeft: Radius.circular(12),
                                          bottomLeft: Radius.circular(12),
                                        )
                                            : index == state.tabs.length - 1
                                            ? const BorderRadius.only(
                                          topRight: Radius.circular(12),
                                          bottomRight: Radius.circular(12),
                                        )
                                            : null,
                                      ),
                                      child: Center(
                                        child: Text(
                                          state.tabs[index].title,
                                          style: TextStyle(
                                            fontFamily: AppFont.fontTwo,
                                            fontSize: 12,
                                            color: isSelected ? Colors.black : Colors.black.withOpacity(0.6),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              }),
                            ),
                          ),
                          const SizedBox(height: 16),
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 24),
                            child: Column(
                              children: [
                                Center(
                                  child: Text(
                                    state.tabs[state.selectedIndex].title,
                                    style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold, fontFamily: AppFont.fontTwo),
                                  ),
                                ),
                                ...List.generate(state.tabs[state.selectedIndex].guests.length, (index) {
                                  var guest = state.tabs[state.selectedIndex].guests[index];
                                  return Column(
                                    children: [
                                      GestureDetector(
                                        onTap: (){
                                          context.read<GuestsBloc>().add(GuestsSelected(guest));
                                        },
                                        child: ListTile(
                                          leading: Container(
                                            width: 60,
                                            height: 60,
                                            decoration: BoxDecoration(
                                                color: Colors.white60,
                                                borderRadius: BorderRadius.all(Radius.circular(8))
                                            ),
                                            child: ClipRRect(
                                              borderRadius: BorderRadius.circular(8),
                                              child: Image.asset(guest.image, fit: BoxFit.cover),
                                            ),
                                          ),
                                          title: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Row(
                                                children: [
                                                  Expanded(child: Text(guest.name, style: const TextStyle(fontWeight: FontWeight.bold, fontFamily: AppFont.fontTwo)),),
                                                  if(guest.review.isNotEmpty)
                                                  Padding(
                                                    padding: EdgeInsets.only(
                                                        top: 4
                                                    ),
                                                    child: Icon(Icons.add, size: 16, color: Colors.black),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                          subtitle: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              guest.schedule.isNotEmpty? Text(guest.schedule):Container(),
                                              if(guest.issue.isNotEmpty)
                                              const SizedBox(height: 8),
                                              if(guest.issue.isNotEmpty)
                                              Row(
                                                mainAxisAlignment: MainAxisAlignment.start,
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  Padding(
                                                    padding: EdgeInsets.only(
                                                        top: 3
                                                    ),
                                                    child: Icon(Icons.book, size: 12, color: Colors.black),
                                                  ),
                                                  const SizedBox(width: 2),
                                                  Expanded(
                                                    child: Text(
                                                      'Tema: ${guest.issue}',
                                                      style: const TextStyle(fontSize: 13, color: Colors.black),
                                                    ),
                                                  ),
                                                  const SizedBox(width: 2),
                                                ],
                                              ),
                                            ],
                                          ),
                                          contentPadding: const EdgeInsets.only(left: 16, right: 16, top: 8),
                                        )
                                      ),
                                      if(guest.review.isNotEmpty)
                                      AnimatedSize(
                                        duration: const Duration(milliseconds: 200),
                                        curve: Curves.easeInOut,
                                        child: guest.selectCard
                                            ? Container(
                                          padding: const EdgeInsets.only(top: 0, left: 4, bottom: 16),
                                          child: RichTextFromHtmlLite(guest.review,
                                            currentStyle: TextStyle(
                                                color: Colors.black,
                                                fontSize: 13,
                                                height: 1.9,
                                                fontFamily: AppFont.font,
                                                fontWeight: FontWeight.w500
                                            ),
                                            onTapLink: (href){

                                            },
                                          ),
                                        )
                                            : const SizedBox.shrink(),
                                      ),
                                    ],
                                  );

                                })
                              ],
                            ),
                          ),

                        ],
                      )
                  ),
                ],
              ),
              Padding(padding: EdgeInsets.only(bottom: 250)),
            ],
          );
        });
  }
}
