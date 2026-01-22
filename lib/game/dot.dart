import 'dart:math';
import 'dart:ui';

enum DotType { real, fake, risk }

class Dot {
  Offset position;
  double radius;

  DotType type;

  bool get isFake => type == DotType.fake;
  bool get isRisk => type == DotType.risk;

  double lifetime;
  double timeLeft;
  double aliveTime = 0;

  int hp;

  // ===== MOVEMENT =====
  Offset velocity;
  bool hasDashed = false;

  // ===== DASH DELAY =====
  double dashDelay;

  // ===== COLOR =====
  Color color;

  // ===== FAKE BLINK =====
  double opacity = 1.0;
  bool shouldBlink = false;
  double _blinkTimer = 0;

  // ===== RISK PRE-DASH SIGNAL =====
  bool preDashSignalActive = false;
  double preDashSignalTimer = 0;

  double visualScale = 1.0;
  double visualBrightness = 1.0;

  static const double _preDashSignalDuration = 0.08;
  static const double _fakeBlinkInterval = 0.18;

  Dot({
    required this.position,
    required this.radius,
    required this.lifetime,
    double? timeLeft,
    bool isFake = false,
    bool isRisk = false,
    required this.color,
    this.velocity = Offset.zero,
    this.hp = 1,
    this.dashDelay = -1,
  })  : timeLeft = timeLeft ?? lifetime,
        type = isRisk
            ? DotType.risk
            : (isFake ? DotType.fake : DotType.real);

  bool hit(Offset tap) {
    final dx = tap.dx - position.dx;
    final dy = tap.dy - position.dy;
    return (dx * dx + dy * dy) <= radius * radius;
  }

  void update(double dt, Size screen) {
    aliveTime += dt;
    timeLeft -= dt;

    // ===== FAKE BLINK =====
    if (isFake) {
      _blinkTimer += dt;
      if (_blinkTimer >= _fakeBlinkInterval) {
        _blinkTimer = 0;
        shouldBlink = !shouldBlink;
        opacity = shouldBlink ? 0.35 : 1.0;
      }
    }

    // ===== RISK PRE-DASH SIGNAL =====
    if (isRisk && !hasDashed && _shouldSignalPreDash() && !preDashSignalActive) {
      _startPreDashSignal();
    }

    if (preDashSignalActive) {
      preDashSignalTimer += dt;
      final t = (preDashSignalTimer / _preDashSignalDuration).clamp(0.0, 1.0);

      visualScale = 1.0 + sin(t * pi) * 0.12;
      visualBrightness = 1.0 + sin(t * pi) * 0.25;

      if (preDashSignalTimer >= _preDashSignalDuration) {
        preDashSignalActive = false;
        preDashSignalTimer = 0;
        visualScale = 1.0;
        visualBrightness = 1.0;
      }
    }

    // ===== DASH =====
    if (!hasDashed && _shouldDash()) {
      _dash();
    }

    // ===== MOVE =====
    position += velocity * dt;

    // ===== BOUNCE =====
    final left = radius;
    final right = screen.width - radius;
    final top = radius;
    final bottom = screen.height - radius;

    if (position.dx < left || position.dx > right) {
      velocity = Offset(-velocity.dx, velocity.dy);
      position = Offset(position.dx.clamp(left, right), position.dy);
    }

    if (position.dy < top || position.dy > bottom) {
      velocity = Offset(velocity.dx, -velocity.dy);
      position = Offset(position.dx, position.dy.clamp(top, bottom));
    }
  }

  bool _shouldDash() {
    if (dashDelay >= 0) {
      return aliveTime >= dashDelay;
    }
    return timeLeft < lifetime * 0.45;
  }

  bool _shouldSignalPreDash() {
    if (dashDelay >= 0) {
      return aliveTime >= (dashDelay - _preDashSignalDuration);
    }
    return timeLeft < lifetime * 0.55;
  }

  void _startPreDashSignal() {
    preDashSignalActive = true;
    preDashSignalTimer = 0;
  }

  void _dash() {
    hasDashed = true;

    final rnd = Random();
    final angle = rnd.nextDouble() * pi * 2;

    double speed;

    if (isRisk) {
      speed = 900 + rnd.nextDouble() * 300;
    } else {
      speed = 700 + rnd.nextDouble() * 250;
    }

    velocity = Offset(cos(angle) * speed, sin(angle) * speed);
  }

  double get drawRadius => radius * visualScale;

  Color get drawColor {
    if (visualBrightness == 1.0) return color;

    final r = (color.red * visualBrightness).clamp(0, 255).toInt();
    final g = (color.green * visualBrightness).clamp(0, 255).toInt();
    final b = (color.blue * visualBrightness).clamp(0, 255).toInt();

    return Color.fromARGB(color.alpha, r, g, b);
  }
}
