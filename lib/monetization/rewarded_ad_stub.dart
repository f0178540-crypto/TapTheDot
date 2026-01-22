typedef RewardCallback = void Function();

class RewardedAdStub {
  RewardCallback? onReward;

  void show() {
    // STUB: kasnije se kači pravi SDK
    onReward?.call();
  }
}
