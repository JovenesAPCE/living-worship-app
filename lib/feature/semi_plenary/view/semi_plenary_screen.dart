import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jamt/constants/constants.dart';
import 'package:jamt/widget/widget.dart';
import 'package:jamt/feature/semi_plenary/semi_plenary.dart';

class SessionScreen extends StatelessWidget {
  const SessionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SemiPlenaryBloc, SemiPlenaryState>(
        listener: (context, state) {

        },
        builder: (context, state) {
              return Container(
                color: AppColor.purpleDark,
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
                                  AppColor.blueLight,
                                  AppColor.blue2,
                                  AppColor.purpleDark
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
                            padding: EdgeInsets.all(16),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  "SEMIPLENARIAS",
                                  style: TextStyle(
                                      fontSize: 24,
                                      fontFamily: AppFont.fontTwo),
                                ),
                                const SizedBox(height: 8),
                                const Text(
                                  'Seleccione las semiplenarias a las que desea asistir:',
                                  style: TextStyle(
                                      fontSize: 14,
                                      color: AppColor.textGrey
                                  )
                                ),

                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.stretch,
                                  children: [
                                    if(state.sessionMessage.show)
                                      StatusMessage(
                                        text: state.sessionMessage.message??"",
                                        type: state.sessionMessage.type,
                                      )
                                  ],
                                ),

                                if(state.sessionProgress.show)
                                  Center(
                                    child: ProgressStatus(
                                      message: state.sessionProgress.message,
                                      type: state.sessionProgress.type,
                                      onRefreshPressed: (){
                                        context.read<SemiPlenaryBloc>().add(LoadSemiPlenary());
                                      },
                                    ),
                                  ),
                                if(!state.progress)
                                Column(
                                  children: [
                                    const SizedBox(height: 32),
                                    ...state.groupedSessions.map((group){
                                      return Column(
                                        children: [
                                          if(!group.register)
                                            WorkshopSelector(
                                              title: 'ELIGE TU ${group.group.toUpperCase()}',
                                              errorText: group.error==""?null:group.error,
                                              selects: group.sessions.map((session){return session.title;}).toList(),
                                              onPressed: (){
                                                context.read<SemiPlenaryBloc>().add(SessionSave(
                                                    groupSelected: group
                                                ));
                                              },
                                              select: group.selected!=null?group.sessions.indexOf(group.selected!):0,
                                              onChanged: (index){
                                                context.read<SemiPlenaryBloc>().add(SessionSelected(
                                                    selected: group.sessions[index],
                                                    groupSelected: group
                                                ));
                                              },
                                            ),
                                          if(group.register)
                                            WorkshopSelectCard(
                                              title: group.group,
                                              value: group.selected?.title??"",
                                              checkIn: group.selected?.checkIn??false,
                                              checkOut: group.selected?.checkOut??false,
                                              register: state.register,
                                              onClosePressed: (){
                                                context.read<SemiPlenaryBloc>().add(SessionClose(
                                                    groupSelected: group
                                                ));
                                              },
                                              onCheckInPressed: (){
                                                context.read<SemiPlenaryBloc>().add(OnCheckInPressed(
                                                    group
                                                ));
                                              },
                                              onCheckOutPressed: (){
                                                context.read<SemiPlenaryBloc>().add(OnCheckOutPressed(
                                                    group
                                                ));
                                              },
                                            ),
                                          const SizedBox(height: 32),
                                        ],
                                      );
                                    }),
                                    if(!state.register && state.groupedSessions.isNotEmpty)
                                      ElevatedButton.icon(
                                        onPressed: () {
                                          context.read<SemiPlenaryBloc>().add(SessionRegister(DateTime.now().millisecondsSinceEpoch));
                                        },
                                        icon: const Icon(Icons.send, color: Colors.white,),
                                        label: const Text('REGISTRAR',
                                            style: TextStyle(
                                                fontSize: 18,
                                                fontFamily: AppFont.fontTwo,
                                                color: Colors.white
                                            )
                                        ),
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: AppColor.blueLight, // Color sólido (puedes cambiarlo)
                                          minimumSize: const Size(double.infinity, 50),
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(8), // SIN bordes redondeados
                                          ),
                                        ),
                                      ),
                                    if(!state.register)
                                      const SizedBox(height: 24),
                                  ],
                                )

                              ],
                            )
                        )
                      ],
                    ),
                    Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.all(Radius.circular(12))
                        ),
                        margin: EdgeInsets.only(
                          left: 16,
                          right: 16,
                          bottom: 20
                        ),
                        padding: EdgeInsets.all(16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(height: 16),
                            if(state.tabs.isNotEmpty && !state.progress)
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
                                        context.read<SemiPlenaryBloc>().add(TabSelected(index));
                                        print("onTap");
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
                            if(state.progress)
                              Center(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const Padding(padding: EdgeInsets.all(16)),
                                    const CircularProgressIndicator(
                                      color: AppColor.yellowDark,
                                    ),
                                    const Padding(padding: EdgeInsets.all(8)),
                                    Text(
                                      "Cargando...",
                                      style: TextStyle(
                                          color: AppColor.textGrey
                                      ),
                                    ),
                                    const SizedBox(height: 32),
                                  ],
                                ),
                              ),
                            if(state.tabs.isNotEmpty && !state.progress)
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: 24),
                              child: Column(
                                children: [
                                  Center(
                                    child: Text(
                                      state.tabs[state.selectedIndex].title.toUpperCase(),
                                      style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold, fontFamily: AppFont.fontTwo),
                                    ),
                                  ),
                                  const SizedBox(height: 16),
                                  ...List.generate(state.tabs[state.selectedIndex].session.length, (index) {
                                    var session = state.tabs[state.selectedIndex].session[index];
                                    return WorkshopCard(
                                      color: session.color,
                                      name: session.title,
                                      topic: session.topic,
                                      topic2: session.topic2,
                                      capacity: session.capacity,
                                      description: session.description,
                                      available: session.available,
                                    );
                                  })
                                ],
                              ),
                            ),
                            if(state.tabs.isEmpty && !state.progress)
                             Column(
                               children: [
                                 Center(
                                   child: Text(
                                     "Lista vacía",
                                     style: TextStyle(
                                       color: AppColor.textGrey,

                                     ),
                                   ),
                                 ),
                                 const SizedBox(height: 24),
                               ],
                             )
                          ],
                        )
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(vertical: 0, horizontal: 16),
                      decoration: BoxDecoration(
                          color: AppColor.blue,
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
        });
  }
}