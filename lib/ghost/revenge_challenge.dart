import '../seed/run_seed.dart';
import 'ghost_frame.dart';

class RevengeChallenge {
  final RunSeed seed;
  final List<GhostFrame> ghost;

  RevengeChallenge({
    required this.seed,
    required this.ghost,
  });

  Map<String, dynamic> toJson() => {
        'seed': seed.seed,
        'ghost': ghost
            .map((g) => {
                  'x': g.position.dx,
                  'y': g.position.dy,
                  't': g.time,
                })
            .toList(),
      };

  static RevengeChallenge fromJson(Map<String, dynamic> m) {
    final seed = RunSeed(m['seed']);
    final frames = (m['ghost'] as List)
        .map((e) => GhostFrame(
              Offset(e['x'], e['y']),
              (e['t'] as num).toDouble(),
            ))
        .toList();

    return RevengeChallenge(seed: seed, ghost: frames);
  }
}
