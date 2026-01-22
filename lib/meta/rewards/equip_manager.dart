class EquipManager {
  String? equippedTrail;
  String? equippedBurst;
  String? equippedBanner;

  void equip(String collectibleId) {
    if (collectibleId.startsWith('trail_')) {
      equippedTrail = collectibleId;
    } else if (collectibleId.startsWith('hit_burst_')) {
      equippedBurst = collectibleId;
    } else if (collectibleId.startsWith('banner_')) {
      equippedBanner = collectibleId;
    }
  }
}
