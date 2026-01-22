import 'dart:ui';
import 'dart:math';
import 'dot.dart';

class SpawnEngine {
  final Random _rnd = Random();

  static const double _topMargin = 80;
  static const double _bottomMargin = 120;
  static const double _sideMargin = 20;

  static const int _patternLength = 3;

  static const double _minFakeDistance = 90;
  static const double _maxFakeDistance = 220;

  static const double _swapTrapChance = 0.35;

  bool _swapArmed = false;
  Offset? _nextRealPosOverride;
  Offset? _nextFakePosOverride;

  List<Dot> spawn(Size size, int streak, int level, Color? selectedColor) {
    if (_swapArmed &&
        _nextRealPosOverride != null &&
        _nextFakePosOverride != null) {
      final realPos = _nextRealPosOverride!;
      final fakePos = _nextFakePosOverride!;
      _swapArmed = false;
      _nextRealPosOverride = null;
      _nextFakePosOverride = null;
      return _spawnFakePairAt(size, level, selectedColor,
          realPos: realPos, fakePos: fakePos);
    }

    // ===== PATTERN PRESSURE (TUNED) =====
    if (level >= 7 && _rnd.nextDouble() < _patternChance(level)) {
      return spawnPattern(size, level, selectedColor);
    }

    if (_rnd.nextDouble() < _fakeChance(level)) {
      final doSwapTrap = level >= 6 && _rnd.nextDouble() < _swapTrapChance;
      return _spawnFakePair(size, level, selectedColor,
          armSwapTrap: doSwapTrap);
    }

    return _spawnSingle(size, level, selectedColor);
  }

  // ======================
  // PATTERN SPAWN
  // ======================

  List<Dot> spawnPattern(Size size, int level, Color? selectedColor) {
    final List<Dot> seq = [];

    final radius = _radius(level);
    final safeLeft = _sideMargin + radius;
    final safeRight = size.width - _sideMargin - radius;
    final safeTop = _topMargin + radius;
    final safeBottom = size.height - _bottomMargin - radius;

    final patternType = _rnd.nextInt(3);

    List<Offset> positions;

    if (patternType == 0) {
      final y = _rnd.nextDouble() * (safeBottom - safeTop) + safeTop;
      positions = [
        Offset(safeLeft, y),
        Offset((safeLeft + safeRight) / 2, y),
        Offset(safeRight, y),
      ];
    } else if (patternType == 1) {
      final x = _rnd.nextDouble() * (safeRight - safeLeft) + safeLeft;
      positions = [
        Offset(x, safeTop),
        Offset(x, (safeTop + safeBottom) / 2),
        Offset(x, safeBottom),
      ];
    } else {
      positions = [
        Offset(
          _rnd.nextDouble() * (safeRight - safeLeft) + safeLeft,
          safeTop,
        ),
        Offset(
          safeRight,
          _rnd.nextDouble() * (safeBottom - safeTop) + safeTop,
        ),
        Offset(
          _rnd.nextDouble() * (safeRight - safeLeft) + safeLeft,
          safeBottom,
        ),
      ];
    }

    for (int i = 0; i < _patternLength; i++) {
      seq.addAll(_spawnSingleAt(size, level, selectedColor, positions[i]));
    }

    return seq;
  }

  // ======================
  // SINGLE DOT
  // ======================

  List<Dot> _spawnSingle(Size size, int level, Color? selectedColor) {
    final radius = _radius(level);
    final safeLeft = _sideMargin + radius;
    final safeRight = size.width - _sideMargin - radius;
    final safeTop = _topMargin + radius;
    final safeBottom = size.height - _bottomMargin - radius;

    final position = Offset(
      _rnd.nextDouble() * (safeRight - safeLeft) + safeLeft,
      _rnd.nextDouble() * (safeBottom - safeTop) + safeTop,
    );

    return _spawnSingleAt(size, level, selectedColor, position);
  }

  List<Dot> _spawnSingleAt(
      Size size, int level, Color? selectedColor, Offset position) {
    final List<Dot> result = [];

    final isRisk = _rnd.nextDouble() < _riskChance(level);
    final hp = _shieldHp(level);

    final radius = _radius(level);
    final lifetime = _lifetime(level);
    final timeLeft = lifetime;

    Offset velocity = Offset.zero;

    double dashDelay = -1;
    if (level >= 5 && _rnd.nextDouble() < _fakeSafeChance(level)) {
      dashDelay = 0.35 + _rnd.nextDouble() * 0.35;
    }

    final color = selectedColor ?? const Color(0xFF2196F3);

    result.add(
      Dot(
        position: position,
        radius: radius,
        velocity: velocity,
        lifetime: lifetime,
        timeLeft: timeLeft,
        isFake: false,
        isRisk: isRisk,
        hp: hp,
        color: color,
        dashDelay: dashDelay,
      ),
    );

    return result;
  }

  // ======================
  // FAKE + REAL PAIR
  // ======================

  List<Dot> _spawnFakePair(Size size, int level, Color? selectedColor,
      {required bool armSwapTrap}) {
    final radius = _radius(level);

    final realPos = _randomSafePos(size, radius);

    final targetDist =
        _minFakeDistance + _rnd.nextDouble() * (_maxFakeDistance - _minFakeDistance);

    final fakePos = _pickFakePosAround(size, radius, realPos, targetDist);

    if (armSwapTrap) {
      _swapArmed = true;
      _nextRealPosOverride = fakePos;
      _nextFakePosOverride = realPos;
    }

    return _spawnFakePairAt(size, level, selectedColor,
        realPos: realPos, fakePos: fakePos);
  }

  List<Dot> _spawnFakePairAt(Size size, int level, Color? selectedColor,
      {required Offset realPos, required Offset fakePos}) {
    final radius = _radius(level);
    final lifetime = _lifetime(level);
    final timeLeft = lifetime;
    final color = selectedColor ?? const Color(0xFF2196F3);

    final fakeDot = Dot(
      position: fakePos,
      radius: radius,
      velocity: Offset.zero,
      lifetime: lifetime,
      timeLeft: timeLeft,
      isFake: true,
      isRisk: false,
      hp: 1,
      color: color,
      dashDelay: -1,
    );

    final realDotList = _spawnSingleAt(size, level, selectedColor, realPos);

    return [fakeDot, ...realDotList];
  }

  Offset _randomSafePos(Size size, double radius) {
    final safeLeft = _sideMargin + radius;
    final safeRight = size.width - _sideMargin - radius;
    final safeTop = _topMargin + radius;
    final safeBottom = size.height - _bottomMargin - radius;

    return Offset(
      _rnd.nextDouble() * (safeRight - safeLeft) + safeLeft,
      _rnd.nextDouble() * (safeBottom - safeTop) + safeTop,
    );
  }

  Offset _pickFakePosAround(
      Size size, double radius, Offset realPos, double targetDist) {
    final safeLeft = _sideMargin + radius;
    final safeRight = size.width - _sideMargin - radius;
    final safeTop = _topMargin + radius;
    final safeBottom = size.height - _bottomMargin - radius;

    Offset candidate = realPos;

    for (int i = 0; i < 12; i++) {
      final angle = _rnd.nextDouble() * pi * 2;
      final dx = cos(angle) * targetDist;
      final dy = sin(angle) * targetDist;

      candidate = Offset(realPos.dx + dx, realPos.dy + dy);

      if (candidate.dx >= safeLeft &&
          candidate.dx <= safeRight &&
          candidate.dy >= safeTop &&
          candidate.dy <= safeBottom) {
        if ((candidate - realPos).distance >= _minFakeDistance) {
          return candidate;
        }
      }
    }

    for (int t = 0; t < 12; t++) {
      candidate = _randomSafePos(size, radius);
      if ((candidate - realPos).distance >= _minFakeDistance) return candidate;
    }

    final corner = Offset(
      realPos.dx < (safeLeft + safeRight) / 2 ? safeRight : safeLeft,
      realPos.dy < (safeTop + safeBottom) / 2 ? safeBottom : safeTop,
    );
    return corner;
  }

  // ======================
  // BALANCE CURVES (TUNED)
  // ======================

  double _patternChance(int level) {
    if (level <= 6) return 0.0;
    if (level <= 8) return 0.15;
    if (level <= 11) return 0.30;
    return 0.45;
  }

  double _fakeSafeChance(int level) {
    if (level <= 4) return 0.0;
    if (level <= 7) return 0.20;
    if (level <= 11) return 0.35;
    return 0.50;
  }

  double _fakeChance(int level) {
    if (level <= 4) return 0.03;
    if (level <= 7) return 0.12;
    if (level <= 11) return 0.24;
    return 0.34;
  }

  double _riskChance(int level) {
    if (level <= 4) return 0.05;
    if (level <= 7) return 0.14;
    if (level <= 11) return 0.26;
    return 0.36;
  }

  int _shieldHp(int level) {
    if (level <= 4) return 1;
    if (level <= 7) return _rnd.nextDouble() < 0.30 ? 2 : 1;
    if (level <= 11) return _rnd.nextDouble() < 0.55 ? 2 : 1;
    return _rnd.nextDouble() < 0.40 ? 3 : 2;
  }

  double _radius(int level) {
    if (level <= 4) return 30;
    if (level <= 8) return 26;
    return 22;
  }

  double _lifetime(int level) {
    if (level <= 2) return 1.6;
    if (level <= 4) return 1.35;
    if (level <= 6) return 1.05;
    if (level <= 8) return 0.90;
    if (level <= 11) return 0.80;
    return 0.70;
  }
}
