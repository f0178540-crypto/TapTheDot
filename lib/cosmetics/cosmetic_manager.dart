import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'skin.dart';
import 'package:flutter/material.dart';

class CosmeticManager {
  final List<Skin> skins;

  CosmeticManager(this.skins);

  static CosmeticManager createDefault() {
    return CosmeticManager([
      Skin(id: "red", name: "Red", color: Colors.redAccent, price: 0, unlocked: true),
      Skin(id: "blue", name: "Blue", color: Colors.blueAccent, price: 50),
      Skin(id: "green", name: "Green", color: Colors.greenAccent, price: 80),
      Skin(id: "purple", name: "Purple", color: Colors.purpleAccent, price: 120),
      Skin(id: "gold", name: "Gold", color: Colors.amber, price: 200),
    ]);
  }

  Skin get activeSkin => skins.firstWhere((s) => s.unlocked);

  void unlock(String id) {
    for (final s in skins) {
      if (s.id == id) {
        s.unlocked = true;
      }
    }
  }

  Map<String, dynamic> toJson() => {
        'skins': skins.map((s) => s.toJson()).toList(),
      };

  static CosmeticManager fromJson(Map<String, dynamic> json) {
    final template = createDefault();
    final list = json['skins'] as List<dynamic>;

    final skins = <Skin>[];

    for (final t in template.skins) {
      final found = list.firstWhere(
        (e) => e['id'] == t.id,
        orElse: () => null,
      );
      if (found != null) {
        skins.add(Skin.fromJson(found, t));
      } else {
        skins.add(t);
      }
    }

    return CosmeticManager(skins);
  }

  Future<void> save() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('cosmetics', jsonEncode(toJson()));
  }

  static Future<CosmeticManager> load() async {
    final prefs = await SharedPreferences.getInstance();
    final raw = prefs.getString('cosmetics');

    if (raw == null) return createDefault();

    final decoded = jsonDecode(raw) as Map<String, dynamic>;
    return fromJson(decoded);
  }
}
