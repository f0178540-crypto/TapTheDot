import 'season_model.dart';

class SeasonRewards {
  static List<SeasonLevel> levels = List.generate(
    30,
    (i) => SeasonLevel(i + 1, 50 + (i * 10)),
  );
}
