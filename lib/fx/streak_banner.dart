class StreakBanner {
  String text = '';
  double life = 0;

  void trigger(int combo) {
    if (combo >= 10 && combo < 20) {
      text = 'STREAK!';
      life = 0.8;
    } else if (combo >= 20 && combo < 40) {
      text = 'INSANE!';
      life = 1.0;
    } else if (combo >= 40) {
      text = 'UNSTOPPABLE!';
      life = 1.2;
    }
  }

  void update(double dt) {
    if (life > 0) life -= dt;
  }

  bool get active => life > 0 && text.isNotEmpty;
}
