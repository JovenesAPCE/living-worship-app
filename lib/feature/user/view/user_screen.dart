import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jamt/feature/user/user.dart';
import 'package:jamt/constants/constants.dart';
import 'package:jamt/widget/widget.dart';
import 'package:lottie/lottie.dart';
import 'package:url_launcher/url_launcher.dart';

class UserScreen extends StatefulWidget {
  const UserScreen({super.key});

  @override
  State<UserScreen> createState() => _UserScreenState();
}

class _UserScreenState extends State<UserScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<UserBloc, UserState>(
      listener: (context, state) {
        if(state.openLaunchUrlNative.isNotEmpty){
          if (Platform.isAndroid || Platform.isIOS) {
            launchUrlNative(state.openLaunchUrlNative);
          } else {
            print("Plataforma no soportada directamente.");
          }
        }
        if (state.close) {
          print("Close");
          Navigator.pop(context);
        }
      },
      builder: (context, state) {
        return PopScope(
          canPop: false,
          onPopInvokedWithResult: (didPop, result) {
            context.read<UserBloc>().add(OnUserScreenClose());
          },
          child: Scaffold(
            drawer: const HomeDrawer(),
            body: Stack(
              children: [
                NestedScrollView(
                  headerSliverBuilder: (context, innerBoxIsScrolled) => [
                    HomeAppBar(
                      color: AppColor.orangeMain,
                      isPop: true,
                    ),
                  ],
                  body: Container(
                    color: Colors.white,
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
                                      AppColor.blue2,
                                    ],
                                    stops: [0.0, 0.4, 1.0],
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              width: double.infinity,
                              margin: EdgeInsets.only(
                                top: MediaQuery.of(context).size.height * 0.04,
                              ),
                              padding: const EdgeInsets.only(right: 32, left: 32),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: const BorderRadius.only(
                                  topLeft: Radius.circular(32),
                                  topRight: Radius.circular(32),
                                ),
                              ),
                              child: Column(
                                children: [
                                  if (state.pageState == UserPageState.pageDecision)
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        SizedBox(height: _maxDynamic(0.03, 32)),
                                        Text(
                                          "Página 1/2",
                                          style: TextStyle(
                                            fontSize: _maxDynamic(0.022, 16),
                                            color: Colors.grey,
                                          ),
                                        ),
                                        SizedBox(height: _maxDynamic(0.024, 20)),
                                        Text(
                                          "Únete a la misión para servir, compartir y llevar esperanza. ¿Quieres ser un misionero CALEB ?",
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            fontSize: _maxDynamic(0.028, 26),
                                            fontWeight: FontWeight.w700,
                                            fontFamily: AppFont.fontTwo,
                                          ),
                                        ),
                                        SizedBox(height: _maxDynamic(0.04, 54)),
                                        Text(
                                          "Cuestionario CALEB",
                                          style: TextStyle(
                                            fontSize: _maxDynamic(0.022, 16),
                                            color: Colors.grey,
                                          ),
                                        ),
                                        SizedBox(height: _maxDynamic(0.024, 24)),
                                        Container(
                                          decoration: BoxDecoration(
                                            color: AppColor.orangeMain.withOpacity(0.3),
                                            borderRadius: const BorderRadius.all(
                                              Radius.circular(18),
                                            ),
                                          ),
                                          padding: EdgeInsets.all(8),
                                          child: Column(
                                            children: [
                                              ...state.decisions.map((decision) {
                                                return Column(
                                                  children: [
                                                    _buildItemDetail(
                                                      title: decision.name,
                                                      selected: decision.selected,
                                                      callback: () {
                                                        context.read<UserBloc>().add(
                                                          OnSelectedDecision(decision),
                                                        );
                                                      },
                                                    ),
                                                    SizedBox(height: 8),
                                                  ],
                                                );
                                              }),
                                            ],
                                          ),
                                        ),
                                        SizedBox(height: _maxDynamic(0.05, 54)),
                                        Row(
                                          children: [
                                            Expanded(child: Container()),
                                            ElevatedButton(
                                              onPressed: () {
                                                context.read<UserBloc>().add(
                                                  OnCompleteDecision(),
                                                );
                                              },
                                              style: ElevatedButton.styleFrom(
                                                backgroundColor: AppColor.orangeDeep,
                                                // tu color fuerte
                                                padding: const EdgeInsets.symmetric(
                                                  horizontal: 16,
                                                  vertical: 16,
                                                ),
                                                shape: RoundedRectangleBorder(
                                                  borderRadius: BorderRadius.circular(
                                                    12,
                                                  ),
                                                ),
                                                elevation: 4,
                                                // más profundidad
                                                shadowColor: AppColor.orangeMain
                                                    .withOpacity(0.6),
                                              ),
                                              child: Text(
                                                "Siguiente",
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: _maxDynamic(0.022, 16),
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  if (state.pageState == UserPageState.pageTwo)
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        SizedBox(height: _maxDynamic(0.03, 32)),
                                        Text(
                                          "Página 2/2",
                                          style: TextStyle(
                                            fontSize: _maxDynamic(0.022, 16),
                                            color: Colors.grey,
                                          ),
                                        ),
                                        SizedBox(height: _maxDynamic(0.024, 20)),
                                        Text(
                                          "Confirma tu decisión como misionero CALEB",
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            fontSize: _maxDynamic(0.028, 26),
                                            fontWeight: FontWeight.w700,
                                            fontFamily: AppFont.fontTwo,
                                          ),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(top: 12, bottom: 32),
                                          child: Text(
                                            "Para unirte oficialmente, por favor ingresa tu correo y número de celular.",
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              fontSize: _maxDynamic(0.021, 14),
                                              color: Colors.grey,
                                            ),
                                          ),
                                        ),
                                        _buildInputTile(
                                          Icons.phone_android,
                                          'Celular',
                                          isPhone: true,
                                          onChanged: (value) {
                                            context.read<UserBloc>().add(
                                              OnCellphoneChanged(value),
                                            );
                                          },
                                          showError: state.phoneError,
                                          errorText: state.phoneErrorText,//'Este campo es obligatorio'
                                        ),
                                        const SizedBox(height: 24),
                                        _buildInputTile(
                                            Icons.email,
                                            'Correo electrónico',
                                            onChanged: (value) {
                                              context.read<UserBloc>().add(
                                                OnEmailChanged(value),
                                              );
                                            },
                                            showError: state.emailError,
                                            errorText: state.emailErrorText//'Este campo es obligatorio',
                                        ),


                                        const SizedBox(height: 54),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            ElevatedButton(
                                              onPressed: () {
                                                context.read<UserBloc>().add(
                                                  OnReConfirmDecision(),
                                                );
                                              },
                                              style: ElevatedButton.styleFrom(
                                                backgroundColor: AppColor.orangeDeep,
                                                // tu color fuerte
                                                padding: const EdgeInsets.symmetric(
                                                  horizontal: 16,
                                                  vertical: 16,
                                                ),
                                                shape: RoundedRectangleBorder(
                                                  borderRadius: BorderRadius.circular(
                                                    12,
                                                  ),
                                                ),
                                                elevation: 4,
                                                // más profundidad
                                                shadowColor: AppColor.orangeMain
                                                    .withOpacity(0.6),
                                              ),
                                              child: Row(
                                                children: [
                                                  const Icon(
                                                    AppIcon.hand,
                                                    color: Colors.white,
                                                  ),
                                                  const SizedBox(width: 12),
                                                  Text(
                                                    "Confirmo mi decisión",
                                                    style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: _maxDynamic(0.022, 16),
                                                      fontWeight: FontWeight.bold,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  if (state.pageState == UserPageState.pageTwoVariant)
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        const SizedBox(height: 32),
                                        const Text(
                                          "Página 2/2",
                                          style: TextStyle(
                                            fontSize: 16,
                                            color: Colors.grey,
                                          ),
                                        ),
                                        const SizedBox(height: 20),
                                        const Text(
                                          "Queremos mantenernos en contacto contigo",
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            fontSize: 26,
                                            fontWeight: FontWeight.w700,
                                            fontFamily: AppFont.fontTwo,
                                          ),
                                        ),
                                        const Padding(
                                          padding: EdgeInsets.only(top: 12, bottom: 32),
                                          child: Text(
                                            "Sabemos que quizás no es el momento, pero nos encantaría seguir compartiéndote noticias e inspiración sobre la misión CALEB. Por favor, déjanos tu correo y número de celular.",
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              fontSize: 14,
                                              color: Colors.grey,
                                            ),
                                          ),
                                        ),
                                        _buildInputTile(
                                            Icons.phone_android,
                                            'Celular',
                                            isPhone: true,
                                            onChanged: (value) {
                                              context.read<UserBloc>().add(
                                                OnCellphoneChanged(value),
                                              );
                                            },
                                            showError: state.phoneError,
                                            errorText: state.phoneErrorText//'Este campo es obligatorio',
                                        ),
                                        const SizedBox(height: 24),
                                        _buildInputTile(
                                            Icons.email,
                                            'Correo electrónico',
                                            onChanged: (value) {
                                              context.read<UserBloc>().add(
                                                OnEmailChanged(value),
                                              );
                                            },
                                            showError: state.emailError,
                                            errorText: state.emailErrorText//'Este campo es obligatorio',
                                        ),
                                        const SizedBox(height: 54),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            ElevatedButton(
                                              onPressed: () {
                                                context.read<UserBloc>().add(
                                                  OnMaybeLaterDecision(),
                                                );
                                              },
                                              style: ElevatedButton.styleFrom(
                                                backgroundColor: AppColor.orangeDeep,
                                                // tu color fuerte
                                                padding: const EdgeInsets.symmetric(
                                                  horizontal: 16,
                                                  vertical: 16,
                                                ),
                                                shape: RoundedRectangleBorder(
                                                  borderRadius: BorderRadius.circular(
                                                    12,
                                                  ),
                                                ),
                                                elevation: 4,
                                                // más profundidad
                                                shadowColor: AppColor.orangeMain
                                                    .withOpacity(0.6),
                                              ),
                                              child: Row(
                                                children: [
                                                  const Icon(
                                                    Icons.save,
                                                    color: Colors.white,
                                                  ),
                                                  const SizedBox(width: 12),
                                                  const Text(
                                                    "Registrar",
                                                    style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 16,
                                                      fontWeight: FontWeight.bold,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  if (state.pageState == UserPageState.pageSuccess)
                                    Padding(
                                      padding: const EdgeInsets.symmetric(horizontal: 32.0),
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          SizedBox(
                                            height: 180,
                                            child: LottiePlayer(assetPath: AppLottie.checkInCheck, repeat: true,),
                                          ),

                                          const SizedBox(height: 24),
                                          const Text(
                                            "¡Gracias por registrarte!",
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              fontSize: 26,
                                              fontFamily: AppFont.fontTwo,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          const SizedBox(height: 16),
                                          const Text(
                                            "Tu información ha sido guardada exitosamente. "
                                                "Pronto recibirás novedades sobre la misión CALEB.",
                                            textAlign: TextAlign.center,
                                            style: TextStyle(fontSize: 14, color: AppColor.textGrey),
                                          ),
                                          const SizedBox(height: 48),
                                          SizedBox(
                                            width: double.infinity,
                                            child: ElevatedButton.icon(
                                              onPressed: () {
                                                Navigator.pop(context); // Redirige al inicio
                                              },
                                              icon: const Icon(Icons.home, color: Colors.white,),
                                              label: const Text("Volver al inicio", style: TextStyle(fontSize: 14, color: Colors.white)),
                                              style: ElevatedButton.styleFrom(
                                                backgroundColor: const Color(0xFFD63F1C),
                                                padding: const EdgeInsets.symmetric(vertical: 16),
                                                shape: RoundedRectangleBorder(
                                                  borderRadius: BorderRadius.circular(12),
                                                ),
                                                elevation: 4,
                                                shadowColor: const Color(0xFFD63F1C).withOpacity(0.6),
                                              ),
                                            ),
                                          ),
                                          const SizedBox(height: 16),

                                          // 🟢 Botón 2: Unirse al grupo de WhatsApp
                                          SizedBox(
                                            width: double.infinity,
                                            child: ElevatedButton.icon(
                                              onPressed: () async {

                                                context.read<UserBloc>().add(
                                                  OpenWhatsAppGroup(),
                                                );
                                              },
                                              icon: const Icon(AppIcon.whatsapp, color: Colors.white,),
                                              label: const Text("Unirme al grupo de WhatsApp", style: TextStyle(fontSize: 14, color: Colors.white)),
                                              style: ElevatedButton.styleFrom(
                                                backgroundColor: const Color(0xFF25D366), // color estilo WhatsApp
                                                padding: const EdgeInsets.symmetric(vertical: 16),
                                                shape: RoundedRectangleBorder(
                                                  borderRadius: BorderRadius.circular(12),
                                                ),
                                                elevation: 4,
                                                shadowColor: const Color(0xFF25D366).withOpacity(0.6),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  if (state.pageState == UserPageState.pageGetReady)
                                    Padding(
                                      padding: const EdgeInsets.symmetric(horizontal: 32.0),
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          // 🔄 Lottie animada (tipo loading o esperando)
                                          SizedBox(
                                            height: 180,
                                            child: Lottie.asset(AppLottie.userLoading, width: 400),
                                          ),

                                          const SizedBox(height: 0),

                                          const Text(
                                            "¡Prepárate!",
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              fontSize: 26,
                                              fontWeight: FontWeight.bold,
                                              fontFamily: AppFont.fontTwo,
                                            ),
                                          ),

                                          const SizedBox(height: 16),

                                          const Text(
                                            "Estás a punto de unirte a algo grande.\n"
                                                "Solo un poco más...\n\n",
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              fontSize: 14,
                                              fontStyle: FontStyle.italic,
                                              color: AppColor.textGrey,
                                              height: 1.5,
                                            ),
                                          ),

                                          const SizedBox(height: 48),

                                          // Botón opcional desactivado o de solo vista
                                          SizedBox(
                                            width: double.infinity,
                                            child: ElevatedButton.icon(
                                              onPressed: null, // Desactivado por ahora
                                              icon: const Icon(Icons.lock_clock, color: Colors.white),
                                              label: const Text(
                                                "Registro no disponible aún",
                                                style: TextStyle(fontSize: 14, color: Colors.white),
                                              ),
                                              style: ElevatedButton.styleFrom(
                                                backgroundColor: Colors.grey,
                                                padding: const EdgeInsets.symmetric(vertical: 16),
                                                shape: RoundedRectangleBorder(
                                                  borderRadius: BorderRadius.circular(12),
                                                ),
                                                elevation: 0,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    )
                                ],
                              ),
                            ),
                            if(state.pageState == UserPageState.pageOffLine)
                              Center(
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 32.0),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      const Icon(
                                        Icons.wifi_off,
                                        size: 100,
                                        color: Colors.grey,
                                      ),
                                      const SizedBox(height: 24),
                                      const Text(
                                        "Sin conexión a internet",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          fontSize: 22,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      const SizedBox(height: 12),
                                      const Text(
                                        "Por favor, revisa tu conexión y vuelve a intentarlo.",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(fontSize: 14, color: Colors.black54),
                                      ),
                                      const SizedBox(height: 36),

                                      // ✅ Botón de refrescar
                                      ElevatedButton.icon(
                                        onPressed: (){

                                        },
                                        icon: const Icon(Icons.refresh, color: Colors.white),
                                        label: const Text(
                                          "Reintentar",
                                          style: TextStyle(fontSize: 14, color: Colors.white),
                                        ),
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: const Color(0xFFD63F1C), // Color Caleb
                                          padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 24),
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(12),
                                          ),
                                          elevation: 4,
                                          shadowColor: const Color(0xFFD63F1C).withOpacity(0.6),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            if(state.userMessage.show)
                              Positioned(
                                  top: 64,
                                  left: 32,
                                  right: 32,
                                  child:  TimedStatusMessage(
                                    message: state.userMessage.message,
                                    type: state.userMessage.type,
                                    duration: const Duration(seconds: 8),
                                    onDismissed: (){
                                      context.read<UserBloc>().add(ClearMessageRequested());
                                    },
                                  ))
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                if(state.progress)
                  BlurLoadingOverlay(),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildInputTile(
    IconData icon,
    String hintText, {
    required void Function(String)? onChanged,
    required bool showError,
    bool isPhone = false,
    String? errorText,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(
            color: const Color(0xFFFDF8F2),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color:
                  showError ? Colors.red : AppColor.orangeMain.withOpacity(0.5),
              width: 1.2,
            ),
          ),
          child: Row(
            children: [
              Icon(icon, color: AppColor.orangeMain, size: 22),
              const SizedBox(width: 12),
              Expanded(
                child: TextField(
                  onChanged: (value) {
                    if (onChanged != null) onChanged(value);
                  },
                  style: const TextStyle(fontSize: 14),
                  decoration: InputDecoration(
                    hintText: hintText,
                    prefixText: isPhone ? '+51 ' : null, // 👈 Añade esto
                    border: InputBorder.none,
                    isDense: true,
                    contentPadding: const EdgeInsets.symmetric(vertical: 10),
                  ),
                  cursorColor: AppColor.orangeMain,
                ),
              ),
            ],
          ),
        ),
        if (showError && errorText != null)
          Padding(
            padding: const EdgeInsets.only(top: 6, left: 6),
            child: Text(
              errorText,
              style: const TextStyle(color: Colors.red, fontSize: 12),
            ),
          ),
      ],
    );
  }

  Widget _buildItemDetail({
    String title = "",
    bool selected = false,
    required VoidCallback callback,
  }) {
    return GestureDetector(
      onTap: callback,
      child: Container(
        decoration: BoxDecoration(
          color: AppColor.orangeMain.withOpacity(selected ? 0.3 : 0),
          borderRadius: const BorderRadius.all(Radius.circular(14)),
        ),
        padding: EdgeInsets.all(16),
        child: Row(
          children: [
            Expanded(
              child: Text(
                title,
                style: TextStyle(
                  fontFamily: AppFont.font,
                  fontSize: _maxDynamic(0.022, 18),
                ),
              ),
            ),
            const SizedBox(width: 8),
            Container(
              width: 24,
              height: 24,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: selected ? AppColor.orangeDeep : Colors.transparent,
                border: Border.all(width: 2, color: AppColor.orangeDeep),
              ),
              child: Icon(
                Icons.check,
                color: selected ? Colors.white : Colors.transparent,
                size: 20,
              ),
            ),
          ],
        ),
      ),
    );
  }

  double _maxDynamic(double percent, int maxSize) {
    double size = MediaQuery.of(context).size.height * percent;
    return size > maxSize.toDouble() ? maxSize.toDouble() : size;
  }


  void launchUrlNative(String url) async {
    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url), mode: LaunchMode.externalApplication);
    } else {
      print('Ocurrió un error. Intenta nuevamente.');
      if(context.mounted){
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: const Text('No se pudo abrir el enlace de WhatsApp'),
            backgroundColor: Colors.red,
            behavior: SnackBarBehavior.floating,
            duration: const Duration(seconds: 3),
          ),
        );
      }

    }
  }



}
