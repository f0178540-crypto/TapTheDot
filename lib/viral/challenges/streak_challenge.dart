class StreakChallenge {
  int target;
  bool completed = false;

  StreakChallenge(this.target);

  bool check(int combo) {
    if (!completed && combo >= target) {
      completed = true;
      return true;
    }
    return false;
  }
}
