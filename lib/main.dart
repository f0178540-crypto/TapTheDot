import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'game/game_controller.dart';
import 'game/game_screen.dart';
import 'main_menu_screen.dart';
import 'skin_select_screen.dart';
import 'share_screen.dart';

void main() {
  runApp(const TapTheDotApp());
}

enum RootScreen { menu, game, skins, share }

class TapTheDotApp extends StatefulWidget {
  const TapTheDotApp({super.key});

  @override
  State<TapTheDotApp> createState() => _TapTheDotAppState();
}

class _TapTheDotAppState extends State<TapTheDotApp> {
  RootScreen screen = RootScreen.menu;
  bool dailyShown = false;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => GameController(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          body: Builder(
            builder: (context) {
              final controller =
                  Provider.of<GameController>(context, listen: false);

              // ===== DAILY BONUS (ONCE PER APP START) =====
              if (!dailyShown) {
                dailyShown = true;
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  if (!mounted) return;
                  controller.grantDailyBonus();
                  showDialog(
                    context: context,
                    builder: (_) => AlertDialog(
                      title: const Text('Daily Reward'),
                      content: const Text('+50 Coins'),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.of(context).pop(),
                          child: const Text('OK'),
                        ),
                      ],
                    ),
                  );
                });
              }

              // ===== ROUTING =====
              if (screen == RootScreen.menu) {
                return MainMenuScreen(
                  onPlay: () {
                    controller.start(MediaQuery.of(context).size);
                    setState(() => screen = RootScreen.game);
                  },
                  onSkins: () {
                    setState(() => screen = RootScreen.skins);
                  },
                );
              }

              if (screen == RootScreen.skins) {
                return SkinSelectScreen(
                  onBack: () {
                    setState(() => screen = RootScreen.menu);
                  },
                );
              }

              if (screen == RootScreen.share) {
                return ShareScreen(
                  score: controller.score,
                  bestScore: controller.bestScore,
                  onBack: () {
                    setState(() => screen = RootScreen.menu);
                  },
                );
              }

              // ===== GAME =====
              return GameScreen(
                onExitToMenu: () {
                  setState(() => screen = RootScreen.menu);
                },
                onShare: () {
                  setState(() => screen = RootScreen.share);
                },
              );
            },
          ),
        ),
      ),
    );
  }
}
