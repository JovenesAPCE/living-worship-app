
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jamt/constants/constants.dart';
import 'dart:math';
import 'package:jamt/feature/tab_home/bloc/tab_home_bloc.dart';
import 'package:jamt/feature/tab_home/models/models.dart';
import 'package:jamt/navigation/bloc/navigation_bloc.dart';
import 'package:jamt/navigation/models/destination.dart';
import 'package:jamt/widget/widget.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});


  @override
  Widget build(BuildContext context) {
    var arrayList = [
      AppImages.homeActivityOne,
      AppImages.homeActivityTwo,
      AppImages.homeActivityThree,
      AppImages.homeActivityFour,
      AppImages.homeActivityFive,
      AppImages.homeActivitySix,
      AppImages.homeActivitySeven,
      AppImages.homeActivityEight,
      AppImages.homeActivityNine,
      AppImages.homeActivityTen,
      AppImages.homeActivityEleven,
      AppImages.homeActivityTwelve
    ];
    arrayList.shuffle();
    return Stack(
      children: [
        // FONDO MEJORADO CON GRADIENTE Y BLUR
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
                stops: [0.0, 0.4, 1.0],
              ),
            ),
          ),
        ),
        Column(
          children: [
            _buildOneGrid(
              "Actividades",
              arrayList,
              "Misión en Acción, Semiplenarias, Adoración, Maranata Class",
              onTap: () {
                context.read<TabHomeBloc>().add(DestinationSelected(TabDestination.activities));
              },
              sepia: true
            ),
            _buildHorizontalGrid(
              context,
              _buildGridCard(
                'Semiplenarias',
                [AppImages.homeWorkshops, AppImages.homeWorkshops2],
                "Elige los tuyos",
                onTap: () {
                  context.read<TabHomeBloc>().add(DestinationSelected(TabDestination.sessions));
                },
                  sepia: true
              ),
              _buildGridCard(
                'Invitados',
                [ AppImages.homeGuests],
                null,
                sepia: true,
                onTap: () {
                  context.read<TabHomeBloc>().add(DestinationSelected(TabDestination.guests));
                },
              ),
              _buildGridCard(
                'Boletín',
                [AppImages.homeBulletin],
                null,
                onTap: () {
                  context.read<TabHomeBloc>().add(DestinationSelected(TabDestination.bulletin));
                },
                sepia: true
              ),
              false,
            ),
            _buildHorizontalGrid(
              context,
              _buildGridCard(
                '¡Escanea tu asistencia!',
                [AppImages.homeQR],
                'Usa tu cámara para registrar tu ingreso y salida en cada semiplenaria.',
                onTap: () {
                  context.read<NavigationBloc>().add(NavigationPressed(Destination.qrScan));
                  //CheckErrorDialog.show(context);
                  //CheckIn.show(context);
                },
              ),
              _buildGridCard(
                'Objetivos Principales',
                [AppImages.homeMainObjectives],
                null,
                onTap: () {
                  context.read<TabHomeBloc>().add(DestinationSelected(TabDestination.event));
                },
              ),
              _buildGridCard(
                'Mapa',
                [AppImages.homeStands],
                null,
                onTap: () {
                  context.read<TabHomeBloc>().add(DestinationSelected(TabDestination.map));
                },
              ),
              true,
            ),
            Padding(padding: EdgeInsets.all(70)),
          ],
        )
      ],
    );
  }

  Widget _buildOneGrid(
    String title,
    List<String> images,
    String subtitle,
      {
        VoidCallback? onTap,
        bool sepia = false,
      }) {
    return GestureDetector(
      onTap: onTap,
      child: Stack(
        children: [
          Container(
            width: double.infinity,
            height: 300,
            margin: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: ZoomImageCarousel(
                images: images,
              ),
            ),
          ),
          if(sepia)
          Container(
            width: double.infinity,
            height: 300,
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.15),
              borderRadius: BorderRadius.all(Radius.circular(12)),
            ),
            margin: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
          ),
          Positioned(
            left: 0,
            right: 0,
            child: Center(
              child: Opacity(
                opacity: 0.8,
              child: Container(
                width: 200,
                height: 200,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(12)),
                  image: DecorationImage(
                    image: AssetImage(AppImages.logoWorship),
                    fit: BoxFit.cover,
                  ),
                ),
                margin: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
              ),),
            ),
          ),
          Positioned(
            top: 0,
            bottom: 0,
            left: 0,
            right: 0,
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
              child: _buildLinearGradient(),
            ),
          ),
          Positioned(
            top: 0,
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              margin: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
              padding: EdgeInsets.all(16),
              alignment: Alignment.bottomLeft,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 34,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontFamily: AppFont.fontTwo,
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    subtitle,
                    style: TextStyle(fontSize: 13, color: Colors.white, fontWeight: FontWeight.w600),
                  ),
                  Padding(padding: EdgeInsets.all(6))
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHorizontalGrid(
    BuildContext context,
    Widget one,
    Widget two,
    Widget three,
    bool isReversed,
  ) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double halfWidth = (screenWidth - 45) * 0.5;

    final bigCard = SizedBox(width: halfWidth, height: 350, child: one);
    final smallCards = Column(
      children: [
        SizedBox(width: halfWidth, height: 170, child: two),
        const SizedBox(height: 12),
        SizedBox(width: halfWidth, height: 170, child: three),
      ],
    );

    return Padding(
      padding: const EdgeInsets.only(left: 16, right: 16, top: 4, bottom: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children:
            isReversed
                ? [
                  // Tarjeta pequeña primero, grande a la derecha
                  smallCards,
                  const SizedBox(width: 12),
                  bigCard,
                ]
                : [
                  // Tarjeta grande primero, pequeñas a la derecha
                  bigCard,
                  const SizedBox(width: 12),
                  smallCards,
                ],
      ),
    );
  }

  Widget _buildGridCard(
      String title,
      List<String> imagePaths,
      String? subtitle, {
        VoidCallback? onTap,
        bool sepia = false,
      }) {
    final random = Random();

    // Probabilidad del 70% de usar la primera imagen
    final String selectedImage = (imagePaths.length == 1 || random.nextDouble() < 0.7)
        ? imagePaths.first
        : imagePaths[random.nextInt(imagePaths.length)];

    return GestureDetector(
      onTap: onTap,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(selectedImage),
              fit: BoxFit.cover,
            ),
          ),
          child: Stack(
            children: [
              Positioned.fill(child: _buildLinearGradient()),
              if (sepia)
                Container(
                  width: double.infinity,
                  height: 300,
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.15),
                    borderRadius: BorderRadius.all(Radius.circular(12)),
                  ),
                ),
              Padding(
                padding: const EdgeInsets.all(12),
                child: Align(
                  alignment: Alignment.bottomLeft,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 21,
                          fontFamily: AppFont.fontTwo,
                          fontWeight: FontWeight.w600,
                          height: 1.3,
                        ),
                      ),
                      if (subtitle != null)
                        Text(
                          subtitle,
                          style: const TextStyle(
                            color: Colors.white70,
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      const Padding(padding: EdgeInsets.all(2)),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLinearGradient() {
    return Stack(
      children: [
        Positioned(
          top: 0,
          bottom: 0,
          left: 0,
          right: 0,
          child: Opacity(
            opacity: 0.3,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(12),
                  bottomRight: Radius.circular(12),
                ),
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: const [
                    Color.fromRGBO(0, 0, 0, 0.0), // 0%
                    Color.fromRGBO(0, 0, 0, 0.0), // 20%
                    Color.fromRGBO(0, 0, 0, 0.1), // 30%
                    Color.fromRGBO(0, 0, 0, 0.8), // 70%
                    Colors.black, // 100%
                  ],
                  stops: const [0.0, 0.2, 0.3, 0.7, 1.0],
                ),
              ),
            ),
          ),
        ),
        Positioned(
          top: 0,
          bottom: 0,
          left: 0,
          right: 0,
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(12),
                bottomRight: Radius.circular(12),
              ),
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: const [
                  Color.fromRGBO(0, 0, 0, 0.0), // 0%
                  Color.fromRGBO(0, 0, 0, 0.0), // 20%
                  Color.fromRGBO(0, 0, 0, 0.1), // 30%
                  Color.fromRGBO(0, 0, 0, 0.8), // 70%
                  Colors.black, // 100%
                ],
                stops: const [0.0, 0.2, 0.3, 0.7, 1.0],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
