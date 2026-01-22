import 'dart:ui';

class ComboColor {
  static Color colorFor(int combo) {
    if (combo < 5) return const Color(0xFFFFFFFF);
    if (combo < 10) return const Color(0xFF7CFF00);
    if (combo < 20) return const Color(0xFFFFC107);
    if (combo < 40) return const Color(0xFFFF5722);
    return const Color(0xFFE91E63);
  }
}
