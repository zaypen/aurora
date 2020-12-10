import 'dart:math';

import 'package:aurora/devices/Launchpad.dart';
import 'package:aurora/effects/Effect.dart';

const frameDuration = Duration(milliseconds: 100);

class Heart extends Effect {
  final List<List<List<int>>> heart = [
    [
      [0, 0, 0, 0, 0, 0, 0, 0],
      [0, 0, 1, 1, 0, 1, 1, 0],
      [0, 1, 1, 1, 1, 1, 1, 1],
      [0, 1, 1, 1, 1, 1, 1, 1],
      [0, 0, 1, 1, 1, 1, 1, 0],
      [0, 0, 0, 1, 1, 1, 0, 0],
      [0, 0, 0, 0, 1, 0, 0, 0],
      [0, 0, 0, 0, 0, 0, 0, 0],
    ],
    [
      [0, 0, 0, 0, 0, 0, 0, 0],
      [0, 0, 1, 1, 0, 1, 1, 0],
      [0, 1, 1, 1, 1, 1, 1, 1],
      [0, 1, 1, 1, 1, 1, 1, 1],
      [0, 1, 1, 1, 1, 1, 1, 1],
      [0, 0, 1, 1, 1, 1, 1, 0],
      [0, 0, 0, 1, 1, 1, 0, 0],
      [0, 0, 0, 0, 1, 0, 0, 0],
    ],
  ];
  Duration nextFrame = Duration.zero;
  int color = Launchpad.COLOR_BLACK;

  Heart(Launchpad launchpad) : super(launchpad);

  @override
  onInitialize() {
    launchpad.reset();
  }

  @override
  onUpdate(Duration elapsed) {
    if (elapsed > nextFrame) {
      _fill(elapsed.inMilliseconds);
      nextFrame += frameDuration;
    }
  }

  _fill(int ms) {
    for (int y = 0; y < 8; y++) {
      for (int x = 0; x < 8; x++) {
        final int red = max(heart[0][y][x] * 255, heart[1][y][x] * sin(ms / 4).toInt());
        launchpad.setCellRgb(x + 1, y + 1, red, 0, 0);
      }
    }
  }
}
