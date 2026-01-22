import '../../monetization/boosts/boost.dart';

class TournamentReward {
  final int coins;
  final List<BoostType> boosts;

  TournamentReward({
    required this.coins,
    this.boosts = const [],
  });

  factory TournamentReward.small() => TournamentReward(
        coins: 100,
      );

  factory TournamentReward.medium() => TournamentReward(
        coins: 300,
        boosts: [BoostType.extraTime],
      );

  factory TournamentReward.big() => TournamentReward(
        coins: 800,
        boosts: [BoostType.extraTime, BoostType.doubleScore],
      );
}
