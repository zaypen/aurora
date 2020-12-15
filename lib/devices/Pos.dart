class Point {
  static const int NUMBER_MIN = 0;
  static const int NUMBER_MAX = 109;
  static const int X_MIN = 0;
  static const int X_MAX = 10;
  static const int Y_MIN = 0;
  static const int Y_MAX = 11;

  final int x;
  final int y;

  Point(this.x, this.y);

  int toNumber() {
    return (y * X_MAX + x).clamp(NUMBER_MIN, NUMBER_MAX);
  }
}
