class Color {
  static const int MIN = 0;
  static const int MAX = 127;

  final int red;
  final int green;
  final int blue;

  Color({int red = 0, int green = 0, int blue = 0})
      : this.red = red.clamp(MIN, MAX),
        this.green = green.clamp(MIN, MAX),
        this.blue = blue.clamp(MIN, MAX);

  List<int> bytes() {
    return [red, green, blue];
  }
}
