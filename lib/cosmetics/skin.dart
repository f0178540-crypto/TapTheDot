import 'package:flutter/material.dart';

class Skin {
  final String id;
  final String name;
  final Color color;
  final int price;
  bool unlocked;

  Skin({
    required this.id,
    required this.name,
    required this.color,
    required this.price,
    this.unlocked = false,
  });

  Map<String, dynamic> toJson() => {
        'id': id,
        'unlocked': unlocked,
      };

  static Skin fromJson(Map<String, dynamic> json, Skin template) {
    return Skin(
      id: template.id,
      name: template.name,
      color: template.color,
      price: template.price,
      unlocked: json['unlocked'] ?? false,
    );
  }
}
