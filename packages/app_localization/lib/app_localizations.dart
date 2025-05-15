import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_es.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'lib/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale) : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
  }

  static const LocalizationsDelegate<AppLocalizations> delegate = _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates = <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('es')
  ];

  /// Mensaje mostrado cuando falla la autenticación
  ///
  /// In es, this message translates to:
  /// **'Error de autenticación'**
  String get loginAuthFailure;

  /// Texto de ayuda para ingresar el año de nacimiento
  ///
  /// In es, this message translates to:
  /// **'Año de nacimiento (Ej: 2001)'**
  String get loginBirthYearHint;

  /// Mensaje de error cuando el año ingresado no es válido
  ///
  /// In es, this message translates to:
  /// **'Año inválido'**
  String get loginBirthYearInvalid;

  /// Texto del botón para cerrar el diálogo o pantalla
  ///
  /// In es, this message translates to:
  /// **'Cerrar'**
  String get loginCloseButton;

  /// Texto del botón principal para iniciar sesión
  ///
  /// In es, this message translates to:
  /// **'Iniciar sesión'**
  String get loginLoginButton;

  /// Texto de ayuda para el campo de DNI
  ///
  /// In es, this message translates to:
  /// **'Ingresa tu documento DNI'**
  String get loginDniHint;

  /// Título de la sección donde el usuario ve sus datos
  ///
  /// In es, this message translates to:
  /// **'Mis datos'**
  String get loginMyData;

  /// Texto grande destacado del botón de inicio de sesión
  ///
  /// In es, this message translates to:
  /// **'INGRESAR'**
  String get loginSignInTitle;

  /// Mensaje de error mostrado cuando el usuario es inválido
  ///
  /// In es, this message translates to:
  /// **'Usuario inválido'**
  String get loginInvalidUser;

  /// Mensaje mostrado mientras se validan los datos del usuario
  ///
  /// In es, this message translates to:
  /// **'Validando tus datos...'**
  String get loginValidatingMessage;

  /// Texto de enlace para ayuda cuando el usuario no puede iniciar sesión
  ///
  /// In es, this message translates to:
  /// **'¡No consigo ingresar!'**
  String get loginCantSignInLink;
}

class _AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) => <String>['en', 'es'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {


  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en': return AppLocalizationsEn();
    case 'es': return AppLocalizationsEs();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.'
  );
}
