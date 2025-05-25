import 'package:app_localization/app_localizations.dart';
import 'package:domain/domain.dart';
import 'package:data/data.dart';
import 'package:entities/entities.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jamt/feature/bulletin/view/bulletin_page.dart';
import 'package:jamt/feature/bulletin/view/bulletin_web_notify.dart';
import 'package:jamt/feature/check_in/check_in.dart';
import 'package:jamt/feature/check_out/check_out.dart';
import 'package:jamt/feature/guests/view/guests_page.dart';
import 'package:jamt/feature/qr/qr.dart';
import 'package:jamt/feature/semi_plenary/view/semi_plenary_page.dart';
import 'package:jamt/navigation/navigation.dart';
import 'package:jamt/constants/constants.dart';
import 'package:jamt/feature/splash/splash.dart';
import 'package:jamt/feature/tab_home/tab_home.dart';
import 'package:jamt/feature/login/login.dart';
import 'package:jamt/feature/user/user.dart';
import 'package:jamt/widget/widget.dart';

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
          ),
          wasOpenNotificationUseCase: WasOpenNotificationUseCase(
            context.read<NotificationRepository>(),
          ),
          notificationReceivedUseCase: NotificationReceivedUseCase(
            context.read<NotificationRepository>(),
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
    init();
  }

  void init() async {
    debugPrint('initFirebase');
    LocalWebNotification.setOnTapCallback((payload){
      print("flutterLocalNotificationsPlugin $payload");
      // 🔁 Aquí llamamos al Bloc para manejar la navegación
      NavigationBloc navigationBloc = BlocProvider.of<NavigationBloc>(
        _navigatorKey.currentContext!,
      );
      print("NavigateToFromNotificationd $payload");
      // Envía evento de navegación
      navigationBloc.add(OnTapNotification());
    });
    LocalNotification.setOnTapCallback((payload) {
      print("flutterLocalNotificationsPlugin $payload");
      // 🔁 Aquí llamamos al Bloc para manejar la navegación
      NavigationBloc navigationBloc = BlocProvider.of<NavigationBloc>(
        _navigatorKey.currentContext!,
      );
      print("NavigateToFromNotificationd $payload");
      // Envía evento de navegación
      navigationBloc.add(OnTapNotification());
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      // 🔁 Aquí navega según `message.data`
      print('✅ App abierta desde notificación (background): ${message.data}');
      NavigationBloc navigationBloc = BlocProvider.of<NavigationBloc>(
        _navigatorKey.currentContext!,
      );

      navigationBloc.add(OnTapNotification());
    });

  }


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: appTheme,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      navigatorKey: _navigatorKey,
      builder: (context, child) {
        return BlocListener<NavigationBloc, NavigationState>(
          listener: (context, state) {
            if (state.notificationReceived.id.isNotEmpty) {
              print("twat ${state.notificationReceived.message}");
              if (!kIsWeb) {
                LocalNotification.show(
                    title: state.notificationReceived.title,
                    body: state.notificationReceived.message,
                    payload: '/bulletin'
                );
              }else {
                print("twat ${state.notificationReceived.message}");
                try{
                  LocalWebNotification.show(
                      title: state.notificationReceived.title,
                      body: state.notificationReceived.message,
                      payload: '/bulletin');
                }catch(e){
                  print(e);
                }

              }
            }

            var removeStack = !state.initial;
            switch (state.status) {
              case AuthStatus.authenticated:
                switch (state.destination) {
                  case Destination.tabHome:
                    _navigator.pushAndRemoveUntil<void>(
                      TabHomePage.route(),
                          (route) => removeStack,
                    );
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
                        SemiPlenaryPage.route()
                    );
                    break;
                  case Destination.qrCheckOut:
                    _navigator.pushAndRemoveUntil<void>(
                      CheckOutPage.route(),
                          (route) =>
                      route.settings.name == TabHomePage.routeName,
                    );
                    break;
                  case Destination.qrCheckIn:
                    _navigator.pushAndRemoveUntil<void>(
                      CheckInPage.route(),
                          (route) =>
                      route.settings.name == TabHomePage.routeName,
                    );
                    break;
                  case Destination.guests:
                    _navigator.push<void>(
                        GuestsPage.route()
                    );
                    break;
                  case Destination.bulletins:
                    _navigator.pushAndRemoveUntil<void>(
                      BulletinPage.route(),
                          (route) =>
                      route.settings.name == TabHomePage.routeName,
                    );
                    break;
                  case Destination.map:
                  // Acción o retorno para mapa
                    break;
                  case Destination.menu:
                  // Acción para mostrar el drawer o modal
                    break;
                  case Destination.logout:
                    context.read<NavigationBloc>().add(
                        AuthenticationLogoutPressed());
                    break;
                  case Destination.none:
                    break;
                  case Destination.event:
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
      onGenerateRoute: (settings){
        switch (settings.name) {
          case BulletinWebNotify.routeName:

            return BulletinWebNotify.route();
          default:
            return SplashPage.route();
        }
      },
    );
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
}
