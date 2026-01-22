import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../game/game_controller.dart';
import '../../social/challenges/challenge.dart';

import '../../cloud/ghost_repo.dart';
import '../../ghost/ghost_player.dart';

class ChallengeScreen extends StatefulWidget {
  const ChallengeScreen({super.key});

  @override
  State<ChallengeScreen> createState() => _ChallengeScreenState();
}

class _ChallengeScreenState extends State<ChallengeScreen> {
  final controller = TextEditingController();

  Challenge? foundChallenge;
  String? statusText;
  bool loadingGhost = false;

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<GameController>(
      builder: (_, ctrl, __) {
        return Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // ===== CREATE CHALLENGE =====
              ElevatedButton(
                onPressed: () {
                  final c = ctrl.createChallenge();
                  showDialog(
                    context: context,
                    builder: (_) => AlertDialog(
                      title: const Text("Challenge Code"),
                      content: SelectableText(
                        c.code,
                        style: const TextStyle(fontSize: 20),
                      ),
                    ),
                  );
                },
                child: const Text("Create Challenge"),
              ),

              const SizedBox(height: 24),

              // ===== FIND CHALLENGE =====
              TextField(
                controller: controller,
                decoration: const InputDecoration(
                  labelText: "Enter challenge code",
                  border: OutlineInputBorder(),
                ),
              ),

              const SizedBox(height: 12),

              ElevatedButton(
                onPressed: () async {
                  final code = controller.text.trim();
                  if (code.isEmpty) return;

                  final c = ctrl.challengeManager.findByCode(code);

                  if (c == null) {
                    setState(() {
                      foundChallenge = null;
                      statusText = "Challenge not found";
                    });
                    return;
                  }

                  setState(() {
                    foundChallenge = c;
                    statusText =
                        "Beat score ${c.targetScore} in ${c.modeId}";
                    loadingGhost = true;
                  });

                  // ===== LOAD GHOST RUN =====
                  final ghost =
                      await GhostRepo.load(c.id, c.creatorId);

                  if (!mounted) return;

                  if (ghost != null) {
                    ctrl.ghostPlayer = GhostPlayer(ghost.frames);
                  } else {
                    ctrl.ghostPlayer = null;
                  }

                  setState(() {
                    loadingGhost = false;
                  });
                },
                child: const Text("Find Challenge"),
              ),

              const SizedBox(height: 20),

              if (statusText != null)
                Text(
                  statusText!,
                  style: const TextStyle(fontSize: 16),
                ),

              const SizedBox(height: 12),

              // ===== PLAY VS GHOST =====
              if (foundChallenge != null)
                ElevatedButton.icon(
                  icon: const Icon(Icons.play_arrow),
                  label: loadingGhost
                      ? const Text("Loading ghost...")
                      : const Text("PLAY VS GHOST"),
                  onPressed: loadingGhost
                      ? null
                      : () {
                          final c = foundChallenge!;
                          ctrl.challengeManager.setActive(c.id);
                          Navigator.of(context).pop(); // back to game
                        },
                ),
            ],
          ),
        );
      },
    );
  }
}
