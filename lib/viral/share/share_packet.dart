class SharePacket {
  final int? seed;
  final int? score;
  final String? fromPlayer;
  final String? tag;

  SharePacket({
    this.seed,
    this.score,
    this.fromPlayer,
    this.tag,
  });

  bool get isChallenge => seed != null && score != null;
}
