// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get loginAuthFailure => 'Authentication failed';

  @override
  String get loginBirthYearHint => 'Year of birth (e.g. 2001)';

  @override
  String get loginBirthYearInvalid => 'Invalid year';

  @override
  String get loginCloseButton => 'Close';

  @override
  String get loginLoginButton => 'Sign in';

  @override
  String get loginDniHint => 'Enter your DNI document';

  @override
  String get loginMyData => 'My Data';

  @override
  String get loginSignInTitle => 'SIGN IN';

  @override
  String get loginInvalidUser => 'Invalid user';

  @override
  String get loginValidatingMessage => 'Validando tus datos...';

  @override
  String get loginCantSignInLink => 'I can\'t sign in!';
}
