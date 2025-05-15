import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jamt/constants/constants.dart';
import 'package:jamt/navigation/navigation.dart';

class HomeAppBar extends StatelessWidget {
  const HomeAppBar({super.key, this.color});
  final Color? color;
  @override
  Widget build(BuildContext context) {
    final destination = context.select(
          (NavigationBloc bloc) => bloc.state.destination,
    );
    return SliverAppBar(
      pinned: false,     // No queda fijo
      floating: true,    // Aparece al hacer scroll hacia arriba
      snap: true,        // Se muestra completo al tocar un poco hacia arriba
      backgroundColor: color ?? AppColor.colorPrimary,
      elevation: 0,
      automaticallyImplyLeading: false,
      title: Row(
        children: [
          Image.asset(AppImages.mainLogoBlue, height: 40),
          const Spacer(),
          if(destination != Destination.profile)
          /*_buildAppBarIcon(Icons.person, onTap: (){
            context.read<NavigationBloc>().add(NavigationPressed(Destination.profile));
          }),*/
          const SizedBox(width: 12),
          _buildAppBarIcon(Icons.menu, onTap: () {
            Scaffold.of(context).openDrawer();
          }),
        ],
      ),
    );
  }

  Widget _buildAppBarIcon(IconData icon, {VoidCallback? onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        margin: EdgeInsets.zero,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        elevation: 0,
        color: Colors.white,
        child: SizedBox(
          width: 38,
          height: 38,
          child: Icon(icon, color: Colors.black, size: 18),
        ),
      ),
    );
  }
}