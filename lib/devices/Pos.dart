class Pos {
  static const int NUMBER_MIN = 0;
  static const int NUMBER_MAX = 127;
  static const int NUMBER_PER_LINE = 10;

  final int number;

  Pos(int number) : this.number = number.clamp(NUMBER_MIN, NUMBER_MAX);

  factory Pos.from(int x, int y) {
    return Pos(y * NUMBER_PER_LINE + x);
  }
}
