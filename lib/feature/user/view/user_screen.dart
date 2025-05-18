import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jamt/extensions/extensions.dart';
import 'package:jamt/feature/user/user.dart';
import 'package:jamt/constants/constants.dart';

class UserScreen extends StatefulWidget {
  const UserScreen({super.key});
  @override
  State<UserScreen> createState() => _UserScreenState();
}

class _UserScreenState extends State<UserScreen> {
  final emailController = TextEditingController();
  final cellphoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<UserBloc, UserState>(
        listener: (context, state) {
          if(state.close){
            Navigator.pop(context);
          }
        },
        builder: (context, state){
          return PopScope(
              canPop: false,
              onPopInvokedWithResult: (didPop, result) {
                context.read<UserBloc>().add(OnUserScreenClose());
              },
              child: Container(
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
                                  AppColor.blue2
                                ],
                                stops: [0.0, 0.4, 1.0],
                              ),
                            ),
                          ),
                        ),
                        Container(
                          width: double.infinity,
                          margin: EdgeInsets.only(
                            top: MediaQuery.of(context).size.height * 0.04 ,
                          ),
                          padding: const EdgeInsets.only(
                              right: 32,
                              left: 32
                          ),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(32),
                                topRight: Radius.circular(32)
                            ),
                          ),
                          child: Column(
                            children: [
                              if(state.pageState == UserPageState.pageDecision)
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    SizedBox(height: _maxDynamic(0.03, 32)),
                                    Text("Página 1/2",
                                        style: TextStyle(fontSize: _maxDynamic(0.022, 16), color: Colors.grey)),
                                    SizedBox(height:  _maxDynamic(0.024, 20)),
                                    Text("Únete a la misión para servir, compartir y llevar esperanza. ¿Quieres ser un predicador CALEB ?",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontSize:  _maxDynamic(0.028, 26),
                                        fontWeight: FontWeight.w700,
                                        fontFamily: AppFont.fontTwo,
                                      ),
                                    ),
                                    SizedBox(height: _maxDynamic(0.04, 54)),
                                    Text("Cuestionario CALEB",
                                        style: TextStyle(
                                            fontSize: _maxDynamic(0.022, 16),
                                            color: Colors.grey
                                        )),
                                    SizedBox(height:_maxDynamic(0.024, 24)),
                                    Container(
                                      decoration: BoxDecoration(
                                        color: AppColor.orangeMain.withOpacity(0.3),
                                        borderRadius: const BorderRadius.all(Radius.circular(18)),
                                      ),
                                      padding: EdgeInsets.all(8),
                                      child: Column(
                                        children: [
                                          ...state.decisions.map((decision){
                                            return Column(
                                              children: [
                                                _buildItemDetail(title:decision.name, selected: decision.selected, callback: (){
                                                  context.read<UserBloc>().add(OnSelectedDecision(decision));
                                                }),
                                                SizedBox(height: 8)
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
                                            context.read<UserBloc>().add(OnCompleteDecision());
                                          },
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor: AppColor.orangeDeep, // tu color fuerte
                                            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                                            shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.circular(12),
                                            ),
                                            elevation: 4, // más profundidad
                                            shadowColor: AppColor.orangeMain.withOpacity(0.6),
                                          ),
                                          child: Text(
                                            "Siguiente",
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize:  _maxDynamic(0.022, 16),
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),



                                  ],
                                ),
                              if(state.pageState == UserPageState.pageTwo)
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    const SizedBox(height: 32),
                                    const Text("Página 2/2",
                                        style: TextStyle(fontSize: 16, color: Colors.grey)),
                                    const SizedBox(height: 20),
                                    const Text("Confirma tu decisión como predicador CALEB",
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
                                        "Para unirte oficialmente, por favor ingresa tu correo y número de celular.",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          fontSize: 14,
                                          color: Colors.grey,
                                        ),
                                      ),
                                    ),
                                    _buildInputTile(
                                      Icons.email,
                                      emailController,
                                      'Correo electrónico',
                                      showError: true,
                                      errorText: 'Este campo es obligatorio',
                                    ),
                                    const SizedBox(height: 24),
                                    _buildInputTile(
                                      Icons.phone_android,
                                      cellphoneController,
                                      'Celular',
                                      showError: true,
                                      errorText: 'Este campo es obligatorio',
                                    ),
                                    const SizedBox(height: 54),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        ElevatedButton(
                                          onPressed: () {
                                            // acción
                                          },
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor: AppColor.orangeDeep, // tu color fuerte
                                            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                                            shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.circular(12),
                                            ),
                                            elevation: 4, // más profundidad
                                            shadowColor: AppColor.orangeMain.withOpacity(0.6),
                                          ),
                                          child: Row(
                                            children: [
                                              const Icon(AppIcon.hand, color: Colors.white,),
                                              const SizedBox(width: 12),
                                              const Text(
                                                "Confirmo mi decisión",
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),



                                  ],
                                ),
                              if(state.pageState == UserPageState.pageTwoVariant)
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    const SizedBox(height: 32),
                                    const Text("Página 2/2",
                                        style: TextStyle(fontSize: 16, color: Colors.grey)),
                                    const SizedBox(height: 20),
                                    const Text("Queremos mantenernos en contacto contigo",
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
                                      Icons.email,
                                      emailController,
                                      'Correo electrónico',
                                      showError: true,
                                      errorText: 'Este campo es obligatorio',
                                    ),
                                    const SizedBox(height: 24),
                                    _buildInputTile(
                                      Icons.phone_android,
                                      cellphoneController,
                                      'Celular',
                                      showError: true,
                                      errorText: 'Este campo es obligatorio',
                                    ),
                                    const SizedBox(height: 54),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        ElevatedButton(
                                          onPressed: () {
                                            // acción
                                          },
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor: AppColor.orangeDeep, // tu color fuerte
                                            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                                            shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.circular(12),
                                            ),
                                            elevation: 4, // más profundidad
                                            shadowColor: AppColor.orangeMain.withOpacity(0.6),
                                          ),
                                          child: Row(
                                            children: [
                                              const Icon(Icons.save, color: Colors.white,),
                                              const SizedBox(width: 12),
                                              const Text(
                                                "Registrar",
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),



                                  ],
                                )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              )
          );
        });
  }


  Widget _buildInputTile(
      IconData icon,
      TextEditingController controller,
      String hintText, {
        required bool showError,
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
              color: showError ? Colors.red : AppColor.orangeMain.withOpacity(0.5),
              width: 1.2,
            ),
          ),
          child: Row(
            children: [
              Icon(icon, color: AppColor.orangeMain, size: 22),
              const SizedBox(width: 12),
              Expanded(
                child: TextField(
                  controller: controller,
                  style: const TextStyle(fontSize: 14),
                  decoration: InputDecoration(
                    hintText: hintText,
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

  Widget _buildItemDetail({String title = "", bool selected = false, required VoidCallback callback}){
    return GestureDetector(
      onTap: callback,
      child: Container(
        decoration: BoxDecoration(
          color: AppColor.orangeMain.withOpacity(selected? 0.3: 0),
          borderRadius: const BorderRadius.all(Radius.circular(14)),
        ),
        padding: EdgeInsets.all(16),
        child: Row(
          children: [
            Expanded(
                child: Text(title,
                  style: TextStyle(
                    fontFamily: AppFont.font,
                    fontSize:  _maxDynamic(0.022, 18) ,
                  ),
                )
            ),
            const SizedBox(width: 8),
            Container(
              width: 24,
              height: 24,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: selected?  AppColor.orangeDeep : Colors.transparent,
                border: Border.all(
                    width: 2,
                    color: AppColor.orangeDeep
                ),
              ),
              child: Icon(Icons.check,
                color: selected? Colors.white: Colors.transparent,
                size: 20,
              ),
            )
          ],
        ),
      ),
    );
  }

  double _maxDynamic(double percent, int maxSize){
    double size = MediaQuery.of(context).size.height * percent;
    return size > maxSize.toDouble() ? maxSize.toDouble() : size;
  }
}