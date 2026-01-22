class Env {
  static const bool isProd = bool.fromEnvironment('PROD', defaultValue: false);

  static String get bannerId =>
      isProd ? 'ca-app-pub-REAL/REAL' : 'ca-app-pub-3940256099942544/6300978111';

  static String get interstitialId =>
      isProd ? 'ca-app-pub-REAL/REAL' : 'ca-app-pub-3940256099942544/1033173712';

  static String get rewardedId =>
      isProd ? 'ca-app-pub-REAL/REAL' : 'ca-app-pub-3940256099942544/5224354917';
}
