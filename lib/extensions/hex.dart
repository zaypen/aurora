extension IntToHex on int {
  String toHex() => this.toRadixString(16).toUpperCase().padLeft(2, '0');
}
