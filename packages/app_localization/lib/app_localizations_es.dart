// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Spanish Castilian (`es`).
class AppLocalizationsEs extends AppLocalizations {
  AppLocalizationsEs([String locale = 'es']) : super(locale);

  @override
  String get loginAuthFailure => 'Error de autenticación';

  @override
  String get loginBirthYearHint => 'Año de nacimiento (Ej: 2001)';

  @override
  String get loginBirthYearInvalid => 'Año inválido';

  @override
  String get loginCloseButton => 'Cerrar';

  @override
  String get loginLoginButton => 'Iniciar sesión';

  @override
  String get loginDniHint => 'Ingresa tu documento DNI';

  @override
  String get loginMyData => 'Mis datos';

  @override
  String get loginSignInTitle => 'INGRESAR';

  @override
  String get loginInvalidUser => 'Usuario inválido';

  @override
  String get loginValidatingMessage => 'Validando tus datos...';

  @override
  String get loginCantSignInLink => '¡No consigo ingresar!';
}
