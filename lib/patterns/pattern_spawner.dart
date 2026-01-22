import 'patterns.dart';

class PatternSpawner {
  SpawnPattern next(int score, int combo) {
    // Minimalno rizično: prvo single, onda line, pa circle.
    // Skaluje se preko score (progresija po sesiji).
    if (score < 10) return const SpawnPattern(PatternType.single, 1);

    if (score < 25) {
      return (combo >= 8)
          ? const SpawnPattern(PatternType.line, 4)
          : const SpawnPattern(PatternType.single, 1);
    }

    if (score < 60) {
      return const SpawnPattern(PatternType.line, 4);
    }

    return const SpawnPattern(PatternType.circle, 6);
  }
}
