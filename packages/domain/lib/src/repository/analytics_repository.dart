abstract class AnalyticsRepository {
  Future<void> setUserProperty({required String name, required String document});
  Future<void> logEvent({required String name, Map<String, Object>? parameters});
  Future<void> logScreenView({ required String screenName, required String screenClass});

}