import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'game_controller.dart';
import '../ui/hud_overlay.dart';
import '../ui/game_over_overlay.dart';

class GameScreen extends StatefulWidget {
  final VoidCallback onExitToMenu;
  final VoidCallback onShare;

  const GameScreen({
    super.key,
    required this.onExitToMenu,
    required this.onShare,
  });

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen>
    with TickerProviderStateMixin {
  final List<_ScorePopup> _popups = [];

  // ===== SLOW-MO VISUAL FX (RISK FINISH) =====
  double _timeScale = 1.0;
  bool _slowMoActive = false;
  bool _slowMoFlash = false;

  void _triggerSlowMo() {
    if (_slowMoActive) return;
    _slowMoActive = true;

    setState(() {
      _timeScale = 0.65; // jači bullet-time
      _slowMoFlash = true;
    });

    Future.delayed(const Duration(milliseconds: 70), () {
      if (!mounted) return;
      setState(() {
        _slowMoFlash = false;
      });
    });

    Future.delayed(const Duration(milliseconds: 140), () {
      if (!mounted) return;
      setState(() {
        _timeScale = 1.0;
        _slowMoActive = false;
      });
    });
  }
  // =========================================

  @override
  void dispose() {
    for (final p in _popups) {
      p.controller.dispose();
    }
    super.dispose();
  }

  void _spawnPopup(Offset pos, int value) {
    final controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );

    final popup = _ScorePopup(
      position: pos,
      value: value,
      controller: controller,
    );

    setState(() => _popups.add(popup));

    controller.forward();

    controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        setState(() => _popups.remove(popup));
        controller.dispose();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final controller = context.watch<GameController>();

    // ===== CONSUME EVENTS =====
    WidgetsBinding.instance.addPostFrameCallback((_) {
      while (controller.consumeHitPopupEvent((pos, value) {
        _spawnPopup(pos, value);
      })) {}

      while (controller.consumeSlowMoEvent(() {
        _triggerSlowMo();
      })) {}
    });
    // ==========================

    return LayoutBuilder(
      builder: (context, constraints) {
        final size = Size(constraints.maxWidth, constraints.maxHeight);

        return GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTapDown: (details) {
            if (controller.gameOver) return;
            controller.handleTap(details.localPosition, size);
          },
          child: Transform.scale(
            scale: controller.zoomScale,
            child: Transform.translate(
              offset: controller.shakeOffset,
              child: AnimatedScale(
                scale: _timeScale,
                duration: const Duration(milliseconds: 40),
                curve: Curves.easeOut,
                child: Stack(
                  children: [
                    Positioned.fill(child: Container(color: Colors.black)),

                    // ===== RISK FINISH FLASH =====
                    if (_slowMoFlash)
                      Positioned.fill(
                        child: Container(
                          color: Colors.redAccent.withOpacity(0.12),
                        ),
                      ),

                    // ===== DOT LIFETIME PROGRESS BAR =====
                    if (!controller.gameOver && controller.dots.isNotEmpty)
                      Positioned(
                        top: 18,
                        left: 20,
                        right: 20,
                        child: LinearProgressIndicator(
                          value: controller.dots.first.timeLeft /
                              controller.dots.first.lifetime,
                          backgroundColor: Colors.white12,
                          valueColor: AlwaysStoppedAnimation<Color>(
                            controller.dots.first.isRisk
                                ? Colors.redAccent
                                : Colors.blueAccent,
                          ),
                          minHeight: 6,
                        ),
                      ),

                    // ===== DOTS =====
                    ...controller.dots.map((dot) {
                      Color drawColor = dot.drawColor;

                      if (dot.isRisk) {
                        drawColor = Colors.redAccent;
                      } else if (dot.isFake) {
                        drawColor = Colors.white24;
                      }

                      return Positioned(
                        left: dot.position.dx - dot.drawRadius,
                        top: dot.position.dy - dot.drawRadius,
                        child: Container(
                          width: dot.drawRadius * 2,
                          height: dot.drawRadius * 2,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: drawColor,
                          ),
                        ),
                      );
                    }),

                    // ===== SCORE POPUP FX LAYER =====
                    ..._popups.map((p) {
                      final anim = CurvedAnimation(
                        parent: p.controller,
                        curve: Curves.easeOut,
                      );

                      final dy =
                          Tween<double>(begin: 0, end: -30).evaluate(anim);
                      final opacity =
                          Tween<double>(begin: 1, end: 0).evaluate(anim);

                      return Positioned(
                        left: p.position.dx - 20,
                        top: p.position.dy + dy - 10,
                        child: Opacity(
                          opacity: opacity,
                          child: Text(
                            "+${p.value}",
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.w900,
                              shadows: [
                                Shadow(
                                  color: Colors.black54,
                                  blurRadius: 4,
                                  offset: Offset(1, 1),
                                )
                              ],
                            ),
                          ),
                        ),
                      );
                    }),

                    // ===== HIT FLASH =====
                    if (controller.hitFlash)
                      Positioned.fill(
                        child: Container(
                          color: Colors.white.withOpacity(0.06),
                        ),
                      ),

                    // ===== PERFECT FLASH + TEXT =====
                    if (controller.perfectFlash)
                      Positioned.fill(
                        child: Container(
                          color: Colors.yellow.withOpacity(0.05),
                        ),
                      ),
                    if (controller.perfectText != null)
                      Center(
                        child: Text(
                          controller.perfectText!,
                          style: const TextStyle(
                            color: Colors.yellow,
                            fontSize: 34,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                      ),

                    // ===== COMBO TEXT =====
                    if (controller.comboText != null)
                      Positioned(
                        top: 130,
                        left: 0,
                        right: 0,
                        child: Center(
                          child: Text(
                            controller.comboText!,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 24,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                        ),
                      ),

                    // ===== CHAIN TEXT =====
                    if (controller.chainText != null)
                      Positioned(
                        top: 170,
                        left: 0,
                        right: 0,
                        child: Center(
                          child: Text(
                            controller.chainText!,
                            style: const TextStyle(
                              color: Colors.white70,
                              fontSize: 18,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                      ),

                    // ===== LEVEL UP OVERLAY =====
                    if (controller.levelUpFlash)
                      Positioned.fill(
                        child: Container(
                          color: Colors.white.withOpacity(0.05),
                          child: const Center(
                            child: Text(
                              "LEVEL UP!",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 40,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),

                    // ===== HUD =====
                    HudOverlay(controller: controller),

                    // ===== SOFT TUTORIAL OVERLAY =====
                    if (controller.showTutorial)
                      Positioned(
                        bottom: 140,
                        left: 0,
                        right: 0,
                        child: Center(
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 18,
                              vertical: 10,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(color: Colors.white24),
                            ),
                            child: Text(
                              _tutorialText(controller.tutorialStep),
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                        ),
                      ),

                    // ===== GAME OVER OVERLAY =====
                    if (controller.gameOver)
                      GameOverOverlay(
                        controller: controller,
                        onRetry: () => controller.restart(size),
                        onRevive: () => controller.revive(size),
                      ),

                    // ===== SHARE + MENU (ONLY AFTER GAME OVER) =====
                    if (controller.gameOver)
                      Positioned(
                        bottom: 40,
                        left: 0,
                        right: 0,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ElevatedButton.icon(
                              onPressed: widget.onShare,
                              icon: const Icon(Icons.share),
                              label: const Text("SHARE"),
                            ),
                            const SizedBox(width: 16),
                            ElevatedButton.icon(
                              onPressed: widget.onExitToMenu,
                              icon: const Icon(Icons.close),
                              label: const Text("MENU"),
                            ),
                          ],
                        ),
                      ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  String _tutorialText(TutorialStep step) {
    switch (step) {
      case TutorialStep.tapDot:
        return "TAP THE DOT";
      case TutorialStep.avoidRisk:
        return "AVOID RED DOTS";
      case TutorialStep.comboTip:
        return "HIT FAST TO BUILD COMBO";
      case TutorialStep.none:
        return "";
    }
  }
}

class _ScorePopup {
  final Offset position;
  final int value;
  final AnimationController controller;

  _ScorePopup({
    required this.position,
    required this.value,
    required this.controller,
  });
}
