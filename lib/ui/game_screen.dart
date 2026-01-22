import 'package:flutter/material.dart';
import '../core/game_controller.dart';
import '../core/difficulty_manager.dart';
import '../core/score_storage.dart';
import '../ui/game_over_overlay.dart';
import '../ui/hud_overlay.dart';
import '../ads/admob_service.dart';
import '../ads/interstitial_controller.dart';
import '../ads/rewarded_controller.dart';
import '../economy/iap_manager.dart';
import '../economy/store_manager.dart';
import '../ui/store/store_screen.dart';
import '../ui/combo/combo_indicator.dart';
import '../daily_rewards/daily_reward_manager.dart';
import '../economy/coin_wallet.dart';
import '../ui/rewards/daily_reward_popup.dart';
import '../ui/events/event_popup.dart';
import '../events/event_manager.dart';
import '../services/share_service.dart';

class GameScreen extends StatefulWidget {
  const GameScreen({super.key});

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  late final GameController controller;

  final interstitial = InterstitialController();
  final rewarded = RewardedController();

  final iap = IapManager();
  final store = StoreManager();

  final dailyRewards = DailyRewardManager();
  final wallet = CoinWallet();
  final events = EventManager();

  int best = 0;
  int? dailyCoins;

  bool showEvent = false;

  @override
  void initState() {
    super.initState();

    controller = GameController(DifficultyManager());
    controller.onUpdate = () => setState(() {});
    controller.onGameOver = _onGameOver;

    _boot();
  }

  Future<void> _boot() async {
    await AdMobService.init();
    interstitial.load();
    rewarded.load();

    if (await dailyRewards.canClaim()) {
      final coins = await dailyRewards.claim();
      await wallet.add(coins);
      setState(() => dailyCoins = coins);
    }

    best = await ScoreStorage.loadBest();
    setState(() {});
  }

  Future<void> _onGameOver() async {
    if (controller.score > best) {
      best = controller.score;
      await ScoreStorage.saveBest(best);
    }

    // interstitial logic stays where it already is in your project
    if (interstitial.shouldShow()) {
      await interstitial.show();
    }

    setState(() {});
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      final size = Size(constraints.maxWidth, constraints.maxHeight);

      return Scaffold(
        backgroundColor: Colors.black,
        body: Stack(
          children: [
            GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTapDown: (d) => controller.onTap(d.localPosition, size),
              child: CustomPaint(
                size: Size.infinite,
                painter: controller.painter,
              ),
            ),

            if (controller.dot != null)
              Positioned(
                left: controller.dot!.position.dx - controller.dot!.radius,
                top: controller.dot!.position.dy - controller.dot!.radius,
                child: Container(
                  width: controller.dot!.radius * 2,
                  height: controller.dot!.radius * 2,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.redAccent,
                  ),
                ),
              ),

            // ===== HUD (PATCHED) =====
            HudOverlay(controller: controller),

            ComboIndicator(combo: controller.combo.combo),

            if (controller.state == GameState.gameOver)
              GameOverOverlay(
                score: controller.score,
                best: best,
                canRevive: controller.reviveManager.canRevive(),
                onRetry: () => controller.start(size),
                onRevive: () async {
                  final ok = await rewarded.show();
                  if (ok) controller.revive(size);
                },
                onShare: () => ShareService.shareScore(controller.score),
                canBonus: true,
                onBonus: () async {
                  final ok = await rewarded.show();
                  if (!ok) return;
                  await wallet.add(25);
                  // Reuse existing popup plumbing (non-blocking).
                  setState(() => dailyCoins = 25);
                },
              ),

            Positioned(
              right: 10,
              top: 40,
              child: Column(
                children: [
                  IconButton(
                    icon: const Icon(Icons.store),
                    onPressed: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => StoreScreen(iap: iap, store: store),
                      ),
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.emoji_events),
                    onPressed: () => setState(() => showEvent = true),
                  ),
                ],
              ),
            ),

            if (dailyCoins != null)
              DailyRewardPopup(
                coins: dailyCoins!,
                onClose: () => setState(() => dailyCoins = null),
              ),

            if (showEvent)
              EventPopup(
                event: events.getCurrentEvent(),
                onClose: () => setState(() => showEvent = false),
              ),
          ],
        ),
      );
    });
  }
}
