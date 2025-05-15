import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jamt/feature/qr/bloc/qr_bloc.dart';
import 'package:jamt/widget/timed_status_message.dart';
import 'package:lottie/lottie.dart';
import 'package:qr_code_scanner_plus/qr_code_scanner_plus.dart';
import 'package:jamt/constants/constants.dart';

class ScanQrScreen extends StatefulWidget {
  const ScanQrScreen({super.key});

  @override
  State<ScanQrScreen> createState() => _ScanQrScreenState();
}

class _ScanQrScreenState extends State<ScanQrScreen> {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  QRViewController? controller;
  String scanResult = '';
  bool qrViewInitialized = false;

  @override
  void reassemble() {
    super.reassemble();
    controller?.pauseCamera();
    controller?.resumeCamera();
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  void _onQRViewCreated(QRViewController controller, BuildContext context) {
    this.controller = controller;
    setState(() {
      qrViewInitialized = true;
    });
    controller.scannedDataStream.listen((scanData) {
      if (scanResult.isEmpty) {
        if (context.mounted){
          context.read<QrBloc>().add(CodeScanData(scanData.code??''));
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<QrBloc, QrState>(
      listener: (context, state) {

      },
      builder: (context, state){
        return  Scaffold(
          backgroundColor: Colors.black,
          body: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.vertical(top: Radius.circular(32)),
            ),
            child: Stack(
              children: [
                if(!state.progress)
                  Positioned(
                    left: 0,
                    right: 0,
                    bottom: 0,
                    top: 0,
                    child: SizedBox.expand(
                      child: QRView(
                        key: qrKey,
                        overlayMargin: EdgeInsets.zero,
                        onQRViewCreated: (controller) => _onQRViewCreated(controller, context),
                        overlay: QrScannerOverlayShape(
                          overlayColor: AppColor.colorPrimary.withOpacity(0.3),
                          borderColor: AppColor.yellow,
                          borderRadius: 10,
                          borderLength: 30,
                          borderWidth: 10,
                          cutOutSize: 250,
                        ),
                      ),
                    ),
                  ),
                if(!state.progress)
                  Positioned(
                    top: 0,
                    bottom: 0,
                    left: 0,
                    right: 0,
                    child: AnimatedSwitcher(
                      duration: Duration(milliseconds: 1500),
                      child: qrViewInitialized
                          ? Container(
                        key: ValueKey('shown'),
                        child: Container(
                          key: const ValueKey('hide'),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(12),
                              bottomRight: Radius.circular(12),
                            ),
                            gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: const [
                                Color.fromRGBO(224, 86, 31, 1), // 70%
                                Color.fromRGBO(0, 0, 0, 0.3), // 70%
                                Color.fromRGBO(0, 0, 0, 0), // 30%
                                Color.fromRGBO(0, 0, 0, 0.5), // 70%
                                Color.fromRGBO(224, 86, 31, 0.8), // 70%
                              ],
                              stops: const [0.0, 0.2, 0.3, 0.7, 1.0],
                            ),
                          ),
                        ),
                      )
                          : SizedBox.shrink(key: ValueKey('hidden')),
                    ),
                  ),
                if(state.progress)
                  Positioned.fill(
                      child: AnimatedSwitcher(
                        duration: Duration(milliseconds: 2000),
                        child: Container(
                          key: const ValueKey('progress'), // 🔑 clave únic
                          color: AppColor.orangeMain,
                          child: Center(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                SizedBox(
                                  height: 180,
                                  child: Lottie.asset(
                                      AppLottie.qrScan
                                  ),
                                ),
                                Text(
                                  "Analizando ...",
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(fontSize: 14, fontStyle: FontStyle.italic, color: Colors.white),
                                ),
                              ],
                            ),
                          ),
                        ),
                      )
                  ),
                Positioned(
                  top: 0,
                  left: 0,
                  right: 0,
                  child: Container(
                    padding: const EdgeInsets.only(
                        left: 16,
                        right: 16,
                        top: 48,
                        bottom: 20
                    ),
                    child: Row(
                      children: [
                        InkWell(
                          onTap: () => Navigator.pop(context),
                          child: const Icon(Icons.arrow_back, color: Colors.white),
                        ),
                        const SizedBox(width: 24),
                        Text(
                          "Escanea tu asistencia",
                          style: const TextStyle(
                            fontSize: 28,
                            color: Colors.white,
                            fontFamily: AppFont.fontTwo,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                if(!state.progress)
                  Center(
                      child: Padding(
                        padding: EdgeInsets.only(
                            top: 350,
                            left: 32,
                            right: 32
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              "Escanea el código QR al ingresar o salir de la semiplenaria para registrar tu asistencia.",
                              textAlign: TextAlign.center,
                              style: TextStyle(color: Colors.white70),
                            ),
                            //if (kDebugMode)
                            TextButton(onPressed: (){
                              context.read<QrBloc>().add(CodeScanData('JAMT_2025|Sábado 8:40 HS - ALVA Y ALVA (ENTRADA)|Pry1butyQt+Zw1Zc1zMDp1w0zd9GFDoiPRTzw7xHJeRTcNn+KrC4FePEoxh7TgkU0P1Tx9bGSolR5lFlN2JH8AnrAUyLnKasRc334bsWmP6kYe9Ro2NbTBXhstna88KpkOX6GKKMIyGWzK1djV51i2uaYktbRtEwauXi8A+8sUA=|L0LLwdk6bdjOJCIqhtt60TD0gJ8FtOcPoCUFXdCRIfA='));
                            }, child: Text("Simular Scan Qr CheckIn")),
                            //if (kDebugMode)
                            TextButton(onPressed: (){
                              context.read<QrBloc>().add(CodeScanData('JAMT_2025|Sábado 8:40 HS - ALVA Y ALVA (SALIDA)|Pry1butyQt+Zw1Zc1zMDp1w0zd9GFDoiPRTzw7xHJeRFf8HlL7XbG+2FrxN6CREMs/BJ0Le/M+hc/EYGOWwB8R/7EFeSmLuqRIHv+cqG+j2nZOQeu2FVSAWJqarX/qOkivKbYdvtLjuBraUmiVxonWv3AR91N9c2bOPk9gm6t0Y=|FR-KPDGPU-FEfnBcXO7WZn5i06I2-lmL8wvzaJojDko='));
                            }, child: Text("Simular Scan Qr CheckOut"))

                          ],
                        ),
                      )
                  ),
                if(state.qrMessage.show)
                  Positioned(
                      bottom: 32,
                      left: 32,
                      right: 32,
                      child:  TimedStatusMessage(
                        message: state.qrMessage.message,
                        type: state.qrMessage.type,
                        duration: const Duration(seconds: 8),
                        onDismissed: (){
                          context.read<QrBloc>().add(QRClearMessageRequested());
                        },
                      ))
              ],
            ),
          ),
        );
      },
    );
  }
}
