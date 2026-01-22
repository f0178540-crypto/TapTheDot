import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../game/game_controller.dart';
import '../../viral/share/share_card_generator.dart';
import '../../viral/share/share_service.dart';
import '../../viral/video/highlight_service.dart';

class ShareScreen extends StatefulWidget {
  const ShareScreen({super.key});

  @override
  State<ShareScreen> createState() => _ShareScreenState();
}

class _ShareScreenState extends State<ShareScreen> {
  final _refCtrl = TextEditingController();
  bool _sending = false;
  String? _msg;

  @override
  Widget build(BuildContext context) {
    final ctrl = context.watch<GameController>();

    return Scaffold(
      appBar: AppBar(title: const Text("Share & Rewards")),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const Text(
            "Share your run",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          const Text(
            "Share your latest score or video highlight and challenge your friends.",
          ),
          const SizedBox(height: 12),

          // ===== SHARE IMAGE =====
          ElevatedButton.icon(
            icon: const Icon(Icons.image),
            label: const Text("Share Score Image"),
            onPressed: _sending
                ? null
                : () async {
                    setState(() => _sending = true);
                    final img = await ShareCardGenerator.generate(
                      score: ctrl.shareScore,
                      mode: ctrl.shareModeName,
                    );
                    await ShareService.shareImage(img);
                    setState(() => _sending = false);
                  },
          ),

          const SizedBox(height: 8),

          // ===== SHARE VIDEO =====
          ElevatedButton.icon(
            icon: const Icon(Icons.videocam),
            label: const Text("Share Video Highlight"),
            onPressed: ctrl.lastHighlightPath == null
                ? null
                : () async {
                    await HighlightService.shareVideo(
                      ctrl.lastHighlightPath!,
                    );
                  },
          ),

          if (ctrl.lastHighlightPath == null)
            const Padding(
              padding: EdgeInsets.only(top: 6),
              child: Text(
                "Play a round first to generate video highlight.",
                style: TextStyle(fontSize: 12, color: Colors.grey),
              ),
            ),

          const Divider(height: 32),

          // ===== REFERRAL =====
          const Text(
            "Your referral code",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),

          SelectableText(
            ctrl.referralCode,
            style: const TextStyle(fontSize: 28, letterSpacing: 4),
          ),

          const SizedBox(height: 8),
          const Text("Share this code. Both players get rewards."),

          const Divider(height: 32),

          const Text(
            "Enter referral code",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),

          const SizedBox(height: 8),
          TextField(
            controller: _refCtrl,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              hintText: "Enter code",
            ),
          ),

          const SizedBox(height: 8),

          ElevatedButton(
            onPressed: () async {
              final ok = await ctrl.applyReferral(_refCtrl.text.trim());
              setState(() {
                _msg = ok
                    ? "Referral applied! +300 coins"
                    : "Invalid or already used code";
              });
            },
            child: const Text("Apply Code"),
          ),

          if (_msg != null) ...[
            const SizedBox(height: 8),
            Text(
              _msg!,
              style: TextStyle(
                color: _msg!.contains("300") ? Colors.green : Colors.red,
              ),
            ),
          ],
        ],
      ),
    );
  }
}
