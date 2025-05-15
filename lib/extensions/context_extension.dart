
import 'package:flutter/material.dart';
import 'package:app_localization/app_localizations.dart';

/// Extension para acceder a traducciones de forma más corta: `context.loc.hello`
extension LocalizationExtension on BuildContext {
  AppLocalizations get strings => AppLocalizations.of(this);
}

/// Acceso rápido al ThemeData: `context.theme`
extension ThemeExtension on BuildContext {
  ThemeData get theme => Theme.of(this);
}

/// Acceso a TextTheme y ColorScheme: `context.textTheme`, `context.colorScheme`
extension ThemeElements on BuildContext {
  TextTheme get textTheme => Theme.of(this).textTheme;
  ColorScheme get colorScheme => Theme.of(this).colorScheme;
}

/// Verifica si el modo oscuro está activado: `context.isDarkMode`
/// Verifica si la pantalla es pequeña: `context.isSmallScreen`
extension ContextChecks on BuildContext {
  bool get isDarkMode => Theme.of(this).brightness == Brightness.dark;
  bool get isSmallScreen => MediaQuery.of(this).size.width < 600;
}

/// Acceso directo al Navigator: `context.navigator`
extension NavigatorExtension on BuildContext {
  NavigatorState get navigator => Navigator.of(this);
}

/// Acceso rápido a medidas y padding: `context.width`, `context.height`, `context.padding`
extension MediaQueryValues on BuildContext {
  Size get size => MediaQuery.of(this).size;
  double get width => size.width;
  double get height => size.height;
  EdgeInsets get padding => MediaQuery.of(this).padding;
}

/// Extensión para capitalizar Strings: `'flutter'.capitalized => 'Flutter'`
extension Capitalize on String {
  String get capitalized =>
      isNotEmpty ? this[0].toUpperCase() + substring(1).toLowerCase() : this;
}

extension TextStyleAccess on BuildContext {
  TextStyle? get h1 => textTheme.displayLarge;
  TextStyle? get h2 => textTheme.displayMedium;
  TextStyle? get h3 => textTheme.displaySmall;
  TextStyle? get h4 => textTheme.headlineMedium;
  TextStyle? get h5 => textTheme.headlineSmall;
  TextStyle? get h6 => textTheme.titleLarge;

  TextStyle? get body1 => textTheme.bodyLarge;
  TextStyle? get body2 => textTheme.bodyMedium;
  TextStyle? get caption => textTheme.bodySmall;
}
