class CameraPunch {
  double _velocity = 0;
  double _target = 1.0;

  void punch(double strength) {
    _velocity += strength;
    _target = 1.0;
  }

  double update(double current, double dt) {
    // spring back
    final stiffness = 18.0;
    final damping = 8.0;

    final force = (_target - current) * stiffness;
    _velocity += force * dt;
    _velocity -= _velocity * damping * dt;

    return current + _velocity * dt;
  }

  void reset() {
    _velocity = 0;
    _target = 1.0;
  }
}
