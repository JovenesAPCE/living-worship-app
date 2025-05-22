
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jamt/constants/constants.dart';
import 'package:jamt/feature/guests/guests.dart';
import 'package:jamt/constants/constants.dart';

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
                                  return ListTile(
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
                                    title: Text(guest.name, style: const TextStyle(fontWeight: FontWeight.bold)),
                                    subtitle: guest.schedule.isNotEmpty? Text(guest.schedule):null,
                                    contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                                  );
                                })
                              ],
                            ),
                          ),
                          Padding(padding: EdgeInsets.only(bottom: 250)),
                        ],
                      )
                  )
                ],
              ),
              Padding(padding: EdgeInsets.only(bottom: 50))
            ],
          );
        });
  }
}
