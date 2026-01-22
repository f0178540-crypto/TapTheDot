import 'dart:math';
import 'package:flutter/widgets.dart';

enum PatternType { single, line, circle }

class SpawnPattern {
  final PatternType type;
  final int count;

  const SpawnPattern(this.type, this.count);

  List<Offset> generate(Size area, double radius) {
    final rnd = Random();

    Offset clamp(Offset p) {
      final dx = p.dx.clamp(radius, area.width - radius).toDouble();
      final dy = p.dy.clamp(radius, area.height - radius).toDouble();
      return Offset(dx, dy);
    }

    switch (type) {
      case PatternType.line: {
        final y = radius + rnd.nextDouble() * (area.height - radius * 2);
        return List.generate(count, (i) {
          final x = area.width * (i + 1) / (count + 1);
          return clamp(Offset(x, y));
        });
      }

      case PatternType.circle: {
        final center = Offset(
          radius + rnd.nextDouble() * (area.width - radius * 2),
          radius + rnd.nextDouble() * (area.height - radius * 2),
        );

        final r = (radius * 2) + rnd.nextDouble() * 70;
        return List.generate(count, (i) {
          final a = i * 2 * pi / count;
          return clamp(Offset(
            center.dx + cos(a) * r,
            center.dy + sin(a) * r,
          ));
        });
      }

      case PatternType.single:
      default:
        return [
          clamp(Offset(
            radius + rnd.nextDouble() * (area.width - radius * 2),
            radius + rnd.nextDouble() * (area.height - radius * 2),
          ))
        ];
    }
  }
}
