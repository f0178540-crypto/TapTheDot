class DailyRewardCalendar {
  static List<int> coinRewards = [50, 80, 120, 180, 250, 400, 600];

  static int rewardForDay(int dayIndex) {
    if (dayIndex < 0) return coinRewards.first;
    if (dayIndex >= coinRewards.length) return coinRewards.last;
    return coinRewards[dayIndex];
  }
}
