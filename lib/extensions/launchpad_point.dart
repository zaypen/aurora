import 'dart:math';

extension LaunchpadPoint<T extends num> on Point<T> {
  static const int NUMBER_MIN = 0;
  static const int NUMBER_MAX = 109;
  static const int X_MIN = 0;
  static const int X_MAX = 10;
  static const int Y_MIN = 0;
  static const int Y_MAX = 11;
  T toNumber() => (y * X_MAX + x).clamp(NUMBER_MIN, NUMBER_MAX);
}
