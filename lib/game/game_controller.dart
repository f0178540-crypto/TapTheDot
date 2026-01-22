import 'dart:ui';
import 'dart:math';
import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../audio/sound_manager.dart';
import '../meta/meta_tracker.dart';
import '../meta/achievements.dart';
import 'dot.dart';
import 'hit_detection.dart';
import 'spawn_engine.dart';
import '../meta/upgrades.dart';

// ===== SOFT TUTORIAL =====
enum TutorialStep { none, tapDot, avoidRisk, comboTip }

// ===== ACHIEVEMENT POPUP EVENT =====
class _AchievementPopupEvent {
  final AchievementId id;
  final int rewardCoins;
  _AchievementPopupEvent(this.id, this.rewardCoins);
}

class GameController extends ChangeNotifier {
  List<Dot> dots = [];

  final List<Dot> _patternQueue = [];

  int score = 0;
  int bestScore = 0;

  int xp = 0;
  int level = 1;

  int streak = 0;
  int misses = 0;

  bool rageMode = false;
  bool gameOver = false;
  bool canRevive = true;

  int coins = 0;

  bool hitFlash = false;
  bool perfectFlash = false;
  String? perfectText;

  final List<_HitPopupEvent> _hitPopupEvents = [];

  void _emitHitPopup(Offset pos, int value) {
    _hitPopupEvents.add(_HitPopupEvent(pos, value));
  }

  bool consumeHitPopupEvent(void Function(Offset pos, int value) fn) {
    if (_hitPopupEvents.isEmpty) return false;
    final ev = _hitPopupEvents.removeAt(0);
    fn(ev.pos, ev.value);
    return true;
  }

  final List<_SlowMoEvent> _slowMoEvents = [];

  void _emitSlowMo() {
    _slowMoEvents.add(_SlowMoEvent());
  }

  bool consumeSlowMoEvent(VoidCallback fn) {
    if (_slowMoEvents.isEmpty) return false;
    _slowMoEvents.removeAt(0);
    fn();
    return true;
  }

  // ===== ACHIEVEMENT POPUP QUEUE =====
  final List<_AchievementPopupEvent> _achievementPopupEvents = [];

  bool consumeAchievementPopupEvent(
      void Function(AchievementId id, int rewardCoins) fn) {
    if (_achievementPopupEvents.isEmpty) return false;
    final ev = _achievementPopupEvents.removeAt(0);
    fn(ev.id, ev.rewardCoins);
    return true;
  }

  String? comboText;
  String? chainText;

  int comboChain = 0;
  double _lastHitTimestamp = -999;

  bool levelUpFlash = false;

  double zoomScale = 1.0;
  Offset shakeOffset = Offset.zero;

  bool rewardedReviveAvailable = false;
  bool rewardedBonusAvailable = false;

  DateTime? lastRewardedReviveAt;
  DateTime? lastRewardedBonusAt;

  static const int rewardedCooldownSeconds = 60;

  bool dailyGranted = false;

  final spawnEngine = SpawnEngine();
  final hitDetection = HitDetection();

  static const int baseReviveCost = 20;
  static const double basePerfectWindowSeconds = 0.22;

  final Map<UpgradeId, int> upgrades = {
    UpgradeId.extraTimeWindow: 0,
    UpgradeId.reviveDiscount: 0,
    UpgradeId.scoreBoost: 0,
    UpgradeId.startingStreak: 0,
  };

  final Set<Color> purchasedSkins = <Color>{};
  Color selectedColor = const Color(0xFF00B3FF);

  double _timeSinceStart = 0;
  double _sessionSeconds = 0;

  int runsPlayed = 0;
  int totalScoreAccum = 0;
  double totalSessionSeconds = 0;

  Size _lastSize = const Size(360, 640);

  SharedPreferences? _prefs;

  // ===== SOFT TUTORIAL STATE =====
  bool showTutorial = false;
  TutorialStep tutorialStep = TutorialStep.none;
  bool _tutorialDone = false;

  GameController() {
    _init();
  }

  Future<void> _init() async {
    _prefs = await SharedPreferences.getInstance();
    await MetaTracker.init();

    _tutorialDone = _prefs?.getBool('tutorial_done') ?? false;
    if (!_tutorialDone) {
      showTutorial = true;
      tutorialStep = TutorialStep.tapDot;
    }

    _loadPersistent();
  }

  void _loadPersistent() {
    final p = _prefs;
    if (p == null) return;

    coins = p.getInt('coins') ?? 0;
    bestScore = p.getInt('bestScore') ?? 0;

    final colorValue = p.getInt('selectedColor');
    if (colorValue != null) {
      selectedColor = Color(colorValue);
    }

    final skins = p.getStringList('purchasedSkins') ?? <String>[];
    purchasedSkins
      ..clear()
      ..addAll(skins.map((e) => Color(int.parse(e))));

    for (final id in upgrades.keys.toList()) {
      upgrades[id] = p.getInt('upgrade_${id.name}') ?? 0;
    }

    notifyListeners();
  }

  Future<void> _savePersistent() async {
    final p = _prefs;
    if (p == null) return;

    await p.setInt('coins', coins);
    await p.setInt('bestScore', bestScore);
    await p.setInt('selectedColor', selectedColor.value);
    await p.setStringList(
      'purchasedSkins',
      purchasedSkins.map((e) => e.value.toString()).toList(),
    );

    for (final entry in upgrades.entries) {
      await p.setInt('upgrade_${entry.key.name}', entry.value);
    }
  }

  void start(Size size) => restart(size);

  bool canSpendCoins(int cost) => coins >= cost;

  bool spendCoins(int cost) {
    if (coins < cost) return false;
    coins -= cost;
    _savePersistent();
    notifyListeners();
    return true;
  }

  bool get canAffordRevive => coins >= reviveCost();

  bool setUpgradeLevel(UpgradeId id, int newLevel) {
    if (newLevel < 0) return false;
    upgrades[id] = newLevel;
    _savePersistent();
    notifyListeners();
    return true;
  }

  void selectColor(Color color) {
    selectedColor = color;
    _savePersistent();
    notifyListeners();
  }

  bool purchaseSkin(Color color, int cost) {
    if (purchasedSkins.contains(color)) return true;
    if (!spendCoins(cost)) return false;
    purchasedSkins.add(color);
    selectedColor = color;
    _savePersistent();
    notifyListeners();
    return true;
  }

  void grantDailyBonus() {
    if (dailyGranted) return;
    dailyGranted = true;
    addCoins(15);
    notifyListeners();
  }

  void addCoins(int amount) {
    coins += amount;
    _savePersistent();
    notifyListeners();
  }

  int reviveCost() {
    final discount = upgrades[UpgradeId.reviveDiscount] ?? 0;
    final cost = (baseReviveCost * pow(0.85, discount)).round();
    return max(5, cost);
  }

  double get perfectWindowSeconds {
    final up = upgrades[UpgradeId.extraTimeWindow] ?? 0;
    return basePerfectWindowSeconds + up * 0.03;
  }

  double get comboWindowSeconds => rageMode ? 1.2 : 0.8;

  int get flatScoreBonus {
    final up = upgrades[UpgradeId.scoreBoost] ?? 0;
    return up * 2;
  }

  int get startingStreak {
    final up = upgrades[UpgradeId.startingStreak] ?? 0;
    return up * 2;
  }

  void restart(Size size) {
    _lastSize = size;

    runsPlayed++;
    totalScoreAccum += score;
    totalSessionSeconds += _sessionSeconds;

    score = 0;
    xp = 0;
    level = 1;
    streak = startingStreak;
    misses = 0;
    comboChain = 0;
    _lastHitTimestamp = -999;

    gameOver = false;
    canRevive = true;
    rageMode = false;

    comboText = null;
    chainText = null;

    perfectFlash = false;
    perfectText = null;
    hitFlash = false;
    levelUpFlash = false;

    zoomScale = 1.0;
    shakeOffset = Offset.zero;

    _patternQueue.clear();
    dots = spawnEngine.spawn(size, streak, level, selectedColor);

    _timeSinceStart = 0;
    _sessionSeconds = 0;

    notifyListeners();
  }

  void revive(Size size) {
    if (!gameOver || !canRevive) return;

    final cost = reviveCost();
    if (!spendCoins(cost)) return;

    gameOver = false;
    canRevive = false;
    misses = 0;
    comboChain = 0;
    rageMode = false;

    _patternQueue.clear();
    dots = spawnEngine.spawn(size, streak, level, selectedColor);

    notifyListeners();
  }

  void update(Size size) {
    _lastSize = size;

    if (gameOver) return;

    final dt = 1 / 60;
    _timeSinceStart += dt;
    _sessionSeconds += dt;

    for (final dot in dots) {
      dot.update(dt, size);
    }

    dots.removeWhere((d) => d.timeLeft <= 0);

    if (dots.isEmpty) {
      if (_hasRiskDot()) {
        _triggerGameOver();
      } else {
        _registerMiss(size);
        _spawnNext(size);
      }
      notifyListeners();
    }

    // ===== PUMP ACHIEVEMENT EVENTS FROM META =====
    while (MetaTracker.consumeAchievementEvent((id, coins) {
      _achievementPopupEvents.add(_AchievementPopupEvent(id, coins));
    })) {}
  }

  bool _hasRiskDot() => dots.any((d) => d.isRisk);

  bool handleTap(Offset position, Size size) {
    _lastSize = size;

    if (gameOver) return false;

    for (int i = 0; i < dots.length; i++) {
      final dot = dots[i];
      if (hitDetection.checkHit(position, dot)) {
        if (dot.isFake) {
          MetaTracker.onMiss();
          _resetComboChain();
          _registerMiss(size);

          if (showTutorial && tutorialStep == TutorialStep.tapDot) {
            tutorialStep = TutorialStep.avoidRisk;
            notifyListeners();
          }

          return false;
        }

        if (showTutorial && tutorialStep == TutorialStep.tapDot) {
          tutorialStep = TutorialStep.avoidRisk;
          notifyListeners();
        }

        final dx = position.dx - dot.position.dx;
        final dy = position.dy - dot.position.dy;
        final dist = sqrt(dx * dx + dy * dy);

        final perfectByAim = dist < dot.radius * 0.3;
        final perfectByTime = dot.aliveTime <= perfectWindowSeconds;
        final isPerfect = perfectByAim || perfectByTime;

        dot.hp--;

        SoundManager.hitWithCombo(comboChain, rageMode);
        MetaTracker.onHit();

        _triggerZoomPulse();
        _triggerHitFX();

        if (dot.hp > 0) {
          notifyListeners();
          return true;
        }

        final wasRisk = dot.isRisk;

        final now = _timeSinceStart;
        if (now - _lastHitTimestamp <= comboWindowSeconds) {
          comboChain++;
        } else {
          comboChain = 1;
        }
        _lastHitTimestamp = now;

        MetaTracker.onCombo(comboChain);

        if (comboChain >= 2) {
          chainText = 'CHAIN x$comboChain';
          notifyListeners();
          Future.delayed(const Duration(milliseconds: 300), () {
            chainText = null;
            notifyListeners();
          });
        }

        streak++;
        rageMode = streak >= 12;

        final multiplier = _scoreMultiplier();
        final chainBonus = 1 + (comboChain * 0.3);

        int gainedScore = (multiplier * chainBonus).round();
        gainedScore += flatScoreBonus;

        if (dot.isRisk) {
          gainedScore *= 3;
          addCoins(3);
          MetaTracker.onRiskKill();
        } else {
          addCoins(1 + (comboChain ~/ 3));
        }

        score += gainedScore;

        if (isPerfect) {
          score += 2 * multiplier;
          addCoins(2);
          _triggerPerfect();
          MetaTracker.onPerfect();
        }

        final hitPos = dot.position;
        final popupValue = gainedScore + (isPerfect ? (2 * multiplier) : 0);
        _emitHitPopup(hitPos, popupValue);

        if (wasRisk) {
          _emitSlowMo();
        }

        _gainXp();
        _triggerComboText();

        _spawnNext(size);
        notifyListeners();
        return true;
      }
    }

    if (_hasRiskDot()) {
      MetaTracker.onMiss();
      _triggerGameOver();
      notifyListeners();
      return false;
    }

    MetaTracker.onMiss();
    _resetComboChain();
    _registerMiss(size);

    if (showTutorial && tutorialStep == TutorialStep.comboTip) {
      _finishTutorial();
    }

    return false;
  }

  void _finishTutorial() async {
    showTutorial = false;
    tutorialStep = TutorialStep.none;
    await _prefs?.setBool('tutorial_done', true);
    notifyListeners();
  }

  void _resetComboChain() {
    comboChain = 0;
    _lastHitTimestamp = -999;
    chainText = null;
  }

  void _spawnNext(Size size) {
    if (_patternQueue.isNotEmpty) {
      dots = [_patternQueue.removeAt(0)];
      return;
    }

    dots = spawnEngine.spawn(size, streak, level, selectedColor);
  }

  int _scoreMultiplier() {
    if (rageMode) return 3;
    if (comboChain >= 8) return 3;
    if (comboChain >= 4) return 2;
    return 1;
  }

  void _triggerZoomPulse() {
    zoomScale = 1.06;
    notifyListeners();
    Future.delayed(const Duration(milliseconds: 80), () {
      zoomScale = 1.0;
      notifyListeners();
    });
  }

  void _triggerHitFX() {
    hitFlash = true;
    notifyListeners();
    Future.delayed(const Duration(milliseconds: 60), () {
      hitFlash = false;
      notifyListeners();
    });
  }

  void _triggerPerfect() {
    perfectFlash = true;
    perfectText = "PERFECT!";
    notifyListeners();
    Future.delayed(const Duration(milliseconds: 140), () {
      perfectFlash = false;
      notifyListeners();
    });
    Future.delayed(const Duration(milliseconds: 220), () {
      perfectText = null;
      notifyListeners();
    });
  }

  void _triggerComboText() {
    if (comboChain < 2) return;

    if (comboChain >= 5) {
      comboText = "x5";
    } else if (comboChain >= 3) {
      comboText = "x3";
    } else {
      comboText = "x2";
    }

    notifyListeners();
    Future.delayed(const Duration(milliseconds: 220), () {
      comboText = null;
      notifyListeners();
    });
  }

  void _registerMiss(Size size) {
    misses++;

    shakeOffset = const Offset(6, 0);
    notifyListeners();
    Future.delayed(const Duration(milliseconds: 60), () {
      shakeOffset = Offset.zero;
      notifyListeners();
    });

    if (misses >= 3) {
      _triggerGameOver();
    }
  }

  void _triggerGameOver() {
    gameOver = true;

    if (score > bestScore) bestScore = score;
    _savePersistent();

    MetaTracker.onRunEnd();

    if (showTutorial) {
      _finishTutorial();
    }

    notifyListeners();
  }

  void _gainXp() {
    xp += 4;
    final nextLevelXp = 20 + (level - 1) * 10;

    if (xp >= nextLevelXp) {
      xp -= nextLevelXp;
      level++;

      MetaTracker.onLevelUp(level);

      levelUpFlash = true;
      notifyListeners();
      Future.delayed(const Duration(milliseconds: 220), () {
        levelUpFlash = false;
        notifyListeners();
      });
    }
  }

  bool _cooldownPassed(DateTime? last) {
    if (last == null) return true;
    return DateTime.now().difference(last).inSeconds >= rewardedCooldownSeconds;
  }

  void markRewardedReviveAvailable() {
    if (!_cooldownPassed(lastRewardedReviveAt)) return;
    rewardedReviveAvailable = true;
    notifyListeners();
  }

  void consumeRewardedRevive() {
    rewardedReviveAvailable = false;
    lastRewardedReviveAt = DateTime.now();
    notifyListeners();
  }

  void markRewardedBonusAvailable() {
    if (!_cooldownPassed(lastRewardedBonusAt)) return;
    rewardedBonusAvailable = true;
    notifyListeners();
  }

  void consumeRewardedBonus() {
    rewardedBonusAvailable = false;
    lastRewardedBonusAt = DateTime.now();
    notifyListeners();
  }

  int get runsCount => runsPlayed;

  double get averageScorePerRun {
    if (runsPlayed == 0) return 0;
    return totalScoreAccum / runsPlayed;
  }

  double get averageSessionLength {
    if (runsPlayed == 0) return 0;
    return totalSessionSeconds / runsPlayed;
  }
}

class _HitPopupEvent {
  final Offset pos;
  final int value;

  _HitPopupEvent(this.pos, this.value);
}

class _SlowMoEvent {
  _SlowMoEvent();
}
