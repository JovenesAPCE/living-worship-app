import 'dart:io';
import 'dart:math';

import 'package:app_localization/app_localizations.dart';
import 'package:domain/domain.dart';
import 'package:data/data.dart';
import 'package:entities/entities.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:jamt/feature/bulletin/view/bulletin_page.dart';
import 'package:jamt/feature/check_in/check_in.dart';
import 'package:jamt/feature/check_out/check_out.dart';
import 'package:jamt/feature/qr/qr.dart';
import 'package:jamt/main.dart';
import 'package:jamt/navigation/navigation.dart';
import 'package:jamt/constants/constants.dart';
import 'package:jamt/feature/splash/splash.dart';
import 'package:jamt/feature/tab_home/tab_home.dart';
import 'package:jamt/feature/login/login.dart';
import 'package:jamt/feature/user/user.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<AuthenticationRepository>(
          create: (_) => AuthenticationRepositoryImpl(),
          dispose: (repository) => repository.dispose(),
        ),
        RepositoryProvider<UserRepository>(create: (_) => UserRepositoryImpl()),
        RepositoryProvider<NotificationRepository>(create: (_) => NotificationRepositoryImpl()),
        RepositoryProvider<SemiPlenaryRepository>(
            create: (_) => SemiPlenaryRepositoryImpl(),
            dispose: (repository) {
              repository.qrStatusDispose();
            },
        ),
      ],
      child: BlocProvider(
        lazy: false,
        create: (context) => NavigationBloc(
          logOutUseCase: LogOutUseCase(
              context.read<AuthenticationRepository>()
          ),
          getAuthStatus: GetAuthStatusUseCase(
              context.read<AuthenticationRepository>()
          ),
          getUserUseCase: GetUserUseCase(
            context.read<UserRepository>(),
          ),
          getQrStatusUseCase: GetQrStatusUseCase(
            context.read<SemiPlenaryRepository>(),
          )
        )..add(AuthenticationSubscriptionRequested()),
        child: const AppView(),
      ),
    );
  }
}

class AppView extends StatefulWidget {
  const AppView({super.key});

  @override
  State<AppView> createState() => _AppViewState();
}

class _AppViewState extends State<AppView> {
  final _navigatorKey = GlobalKey<NavigatorState>();
  String? _fcmToken;


  NavigatorState get _navigator => _navigatorKey.currentState!;

  @override
  void initState() {
    super.initState();
    initializeNotifications();
    _requestNotificationPermission();
    _initFirebaseMessaging();
  }

  void _requestNotificationPermission() async {
    if (Platform.isAndroid) {
      final messaging = FirebaseMessaging.instance;
      final settings = await messaging.requestPermission();
      debugPrint('🔐 Android permission status: ${settings.authorizationStatus}');
    }
  }

  void _initFirebaseMessaging() async {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      showLocalNotification(
        title: message.notification?.title ?? 'Notificación',
        body: message.notification?.body ?? '',
        payload: '/bulletin'
      );
    });

    _fcmToken = await FirebaseMessaging.instance.getToken();
    debugPrint('🔑 Token: $_fcmToken');
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: appTheme,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      navigatorKey: _navigatorKey,
      builder: (context, child) {
        return BlocListener<NavigationBloc, NavigationState>(
          listener: (context, state) {
            var removeStack = !state.initial;
            switch (state.status) {
              case AuthStatus.authenticated:
                switch(state.destination){
                  case Destination.tabHome:
                    _navigator.pushAndRemoveUntil<void>(
                      TabHomePage.route(),
                          (route) => removeStack,
                    );

                    WidgetsBinding.instance.addPostFrameCallback((_) async{
                      final payload = NotificationHandler.initialPayload;
                      if (payload != null && payload.isNotEmpty) {
                        _navigatorKey.currentContext!.read<NavigationBloc>().add(
                          NavigateToFromNotification( Destination.bulletins),
                        );
                        NotificationHandler.initialPayload = null; // limpia después de usarlo
                      }
                    });

                    break;
                  case Destination.profile:
                    _navigator.push<void>(
                      UserPage.route()
                    );
                    break;
                  case Destination.qrScan:
                    _navigator.push<void>(
                        QRPage.route()
                    );
                    break;
                  case Destination.sessions:
                    _navigator.push<void>(
                        QRPage.route()
                    );
                    break;
                  case Destination.qrCheckOut:
                    _navigator.pushAndRemoveUntil<void>(
                        CheckOutPage.route(),
                          (route) => route.settings.name == TabHomePage.routeName,
                    );
                    break;
                  case Destination.qrCheckIn:
                    _navigator.pushAndRemoveUntil<void>(
                        CheckInPage.route(),
                          (route) => route.settings.name == TabHomePage.routeName,
                    );
                    break;
                  case Destination.guests:
                  // Acción o retorno para invitados
                    break;
                  case Destination.bulletins:
                    _navigator.pushAndRemoveUntil<void>(
                      BulletinPage.route(),
                          (route) => route.settings.name == TabHomePage.routeName,
                    );
                    break;
                  case Destination.trivia:
                  // Acción o retorno para trivia
                    break;
                  case Destination.map:
                  // Acción o retorno para mapa
                    break;
                  case Destination.menu:
                  // Acción para mostrar el drawer o modal
                    break;
                  case Destination.logout:
                    context.read<NavigationBloc>().add(AuthenticationLogoutPressed());
                    break;
                  case Destination.none:
                    break;
                }
              case AuthStatus.unauthenticated:
                _navigator.pushAndRemoveUntil<void>(
                  LoginPage.route(),
                      (route) => false,
                );
              case AuthStatus.unknown:
                break;
            }
          },
          child: child,
        );
      },
      onGenerateRoute: (_) => SplashPage.route(),
    );
  }

  Future<void> initializeNotifications() async {
    // Android init
    const AndroidInitializationSettings androidSettings =
    AndroidInitializationSettings('ic_notification');

    // iOS init
    final DarwinInitializationSettings iosSettings = DarwinInitializationSettings();

    final InitializationSettings initSettings = InitializationSettings(
      android: androidSettings,
      iOS: iosSettings,
    );

    await flutterLocalNotificationsPlugin.initialize(initSettings,
        onDidReceiveNotificationResponse: (NotificationResponse response){
          final payload = response.payload;
          print("flutterLocalNotificationsPlugin $payload");
          // 🔁 Aquí llamamos al Bloc para manejar la navegación
          NavigationBloc navigationBloc = BlocProvider.of<NavigationBloc>(
            _navigatorKey.currentContext!,
          );
          print("NavigateToFromNotificationd $payload");
          // Envía evento de navegación
          navigationBloc.add(NavigateToFromNotification(Destination.bulletins));
        });

    // Crear canal para Android (API 26+)
    if (Platform.isAndroid) {
      const AndroidNotificationChannel channel = AndroidNotificationChannel(
        'default_channel_id',
        'Notificaciones Generales',
        description: 'Canal para mensajes JAMT',
        importance: Importance.high,
      );

      await flutterLocalNotificationsPlugin
          .resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()
          ?.createNotificationChannel(channel);
    }
  }

}

final ThemeData appTheme = ThemeData(
  useMaterial3: true,
  colorScheme: ColorScheme.fromSeed(
    seedColor: AppColor.colorPrimary,
    brightness: Brightness.light,
  ),
  scaffoldBackgroundColor: AppColor.colorPrimary,
  cardTheme: const CardTheme(
    color: Colors.white,
    elevation: 4,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(20)),
    ),
  ),
  fontFamily: AppFont.font,
);

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
FlutterLocalNotificationsPlugin();



Future<void> showLocalNotification({
  required String title,
  required String body,
  String? payload// 👈 nueva// 👈 nuevo
}) async {
  try {
    var  androidDetails = const AndroidNotificationDetails(
      'default_channel_id',
      'Notificaciones Generales',
      channelDescription: 'Canal para mensajes JAMT',
      importance: Importance.high,
      priority: Priority.high,
      playSound: true,
      color: Color(0xFFFF5722),
    );

    final NotificationDetails details = NotificationDetails(android: androidDetails);

    final randomId = Random().nextInt(100000); // 🔢 ID aleatorio
    await flutterLocalNotificationsPlugin.show(
      randomId,
      title,
      body,
      details,
      payload: payload, // 👈 importante
    );
  } catch (e) {
    debugPrint('❌ Error al mostrar local notification: $e');
  }
}

