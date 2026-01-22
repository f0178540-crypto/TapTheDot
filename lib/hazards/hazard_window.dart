class HazardWindow {
  double _time = 0;

  bool get active => _time > 0;

  void trigger(double duration) {
    _time = duration;
  }

  void update(double dt) {
    if (_time > 0) _time -= dt;
  }
}
