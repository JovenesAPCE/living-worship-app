import 'package:domain/domain.dart';
//import 'package:firebase_analytics/firebase_analytics.dart';

class AnalyticsRepositoryImpl extends AnalyticsRepository {

  //final FirebaseAnalytics _analytics = FirebaseAnalytics.instance;

  @override
  Future<void> logEvent({required String name, Map<String, Object>? parameters}) async {
    /*try {
      await _analytics.logEvent(
        name: name,
        parameters: parameters,
      );
      print('✅ Evento registrado: $name');
    } catch (e) {
      print('❌ Error al registrar evento: $e');
    }*/
  }

  @override
  Future<void> logScreenView({required String screenName, required String screenClass}) async{
    /*try {
      await _analytics.logScreenView(
        screenName: screenName,
        screenClass: screenClass,
      );
      print('📺 Pantalla registrada: $screenName');
    } catch (e) {
      print('❌ Error al registrar pantalla: $e');
    }*/
  }

  @override
  Future<void> setUserProperty({required String name, required String document}) async {
   /* try {
      await _analytics.setUserId(id: document);
      await _analytics.setUserProperty(name: 'nombre', value: document);
      print('🧑 Propiedad de usuario: $name = $document');
    } catch (e) {
      print('❌ Error al establecer propiedad de usuario: $e');
    }*/

  }

}