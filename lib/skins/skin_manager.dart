import 'skin_model.dart';

class SkinManager {
  static const skins = [
    SkinModel(id: 'default', name: 'Classic', price: 0, color: 0xFFE53935),
    SkinModel(id: 'neon', name: 'Neon', price: 200, color: 0xFF00E5FF),
    SkinModel(id: 'gold', name: 'Gold', price: 500, color: 0xFFFFD700),
  ];

  static SkinModel getById(String id) =>
      skins.firstWhere((s) => s.id == id, orElse: () => skins.first);
}
