import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:jamt/extensions/extensions.dart';
import 'package:jamt/utils/utils.dart';

mixin RouteAwareStatusBarSync<T extends StatefulWidget> on State<T> implements RouteAware {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (kIsWeb) {
      routeObserver.subscribe(this, ModalRoute.of(context)!);
    }
  }

  @override
  void dispose() {
    if (kIsWeb) {
      routeObserver.unsubscribe(this);
    }
    super.dispose();
  }

  @override
  void didPush() => _updateStatusBarColor();

  @override
  void didPopNext() => _updateStatusBarColor();

  void _updateStatusBarColor() {
    if (!kIsWeb) return;

    final theme = Theme.of(context);
    final appBarColor = theme.appBarTheme.backgroundColor ?? theme.colorScheme.primary;
    print("appBarColor: $appBarColor");
    //context.setPWAThemeColor(appBarColor.toHex());
  }
  @override
  void didPop() {
    // No es necesario actualizar status bar al salir,
    // pero puedes limpiar o registrar logs si lo deseas
  }

  @override
  void didPushNext() {
    // Si deseas ocultar o cambiar color al navegar a otra pantalla, hazlo aquí
  }
}