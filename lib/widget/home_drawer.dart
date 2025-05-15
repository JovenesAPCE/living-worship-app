import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jamt/navigation/navigation.dart';
import 'package:jamt/constants/constants.dart';

class HomeDrawer extends StatelessWidget {
  const HomeDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    final destinations = context.read<NavigationBloc>().state.destinations;
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.70, // ancho personalizado del drawer
      child: ClipRRect(
        borderRadius: const BorderRadius.only(
          topRight: Radius.circular(8),
          bottomRight: Radius.circular(8),
        ),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 15.0, sigmaY: 15.0),
          child: Container(
            color: Colors.white.withOpacity(0.8), // fondo translúcido
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
                Container(
                  height: 160,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(AppImages.mainDrawerBackground),
                      fit: BoxFit.cover,
                    ),
                  ),
                  child: Stack(
                    children: [
                      Positioned(
                        top: 8,
                        right: 8,
                        child: IconButton(
                          icon: const Icon(Icons.close, color: Colors.white),
                          onPressed: () => Navigator.of(context).pop(),
                        ),
                      ),
                      Positioned(
                        bottom: 12,
                        left: 16,
                        child: Text(
                          '¡Bienvenido!',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                  child: Text(
                    "MENÚ",
                    style: TextStyle(fontFamily: AppFont.fontTwo),
                  ),
                ),
                ...destinations.map((destination){
                  return _buildMenuItem(destination.icon, destination.label,  onTap: (){
                    context.read<NavigationBloc>().add(NavigationPressed(destination));
                  });
                })
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildMenuItem(IconData icon, String title, {VoidCallback? onTap}) {
    return ListTile(
      leading: Container(
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.12),
          boxShadow: [
            BoxShadow(
              offset: Offset(0, 5),
              blurRadius: 30,
              color: Colors.black.withOpacity(0.11),
            ),
            BoxShadow(
              offset: Offset(0, 5),
              blurRadius: 15,
              color: Colors.black.withOpacity(0.02),
            ),
          ],
          borderRadius: BorderRadius.circular(5), // si deseas esquinas redondeadas
        ),
        padding: EdgeInsets.all(8),
        child: Icon(icon, color: Color(0xFF1F1F37)),
      ),
      title: Text(title, style: TextStyle(
          fontFamily: AppFont.fontTwo
      ),),
      trailing: Icon(
        Icons.chevron_right,
        color: Colors.black.withOpacity(0.5),
        size: 17,
      ),
      onTap: onTap,
    );
  }
}