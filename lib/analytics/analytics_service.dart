import 'package:firebase_analytics/firebase_analytics.dart';

class AnalyticsService {
  static final _a = FirebaseAnalytics.instance;

  static void log(String name, {Map<String, Object>? params}) {
    _a.logEvent(name: name, parameters: params);
  }
}
