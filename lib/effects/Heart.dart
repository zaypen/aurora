import 'dart:math';

import 'package:aurora/devices/Launchpad.dart';
import 'package:aurora/devices/Pos.dart';
import 'package:aurora/effects/Effect.dart';

const frameDuration = Duration(hours: 1);

class Heart extends Effect {
  final List<List<int>> heart = [
    [0, 0, 0, 0, 0, 0, 0, 0],
    [0, 1, 1, 0, 0, 1, 1, 0],
    [1, 1, 1, 1, 1, 1, 1, 1],
    [1, 1, 1, 1, 1, 1, 1, 1],
    [1, 1, 1, 1, 1, 1, 1, 1],
    [0, 1, 1, 1, 1, 1, 1, 0],
    [0, 0, 1, 1, 1, 1, 0, 0],
    [0, 0, 0, 1, 1, 0, 0, 0],
  ];
  Duration nextFrame = Duration.zero;

  Heart(Launchpad launchpad) : super(launchpad);

  @override
  onInitialize() {
    launchpad.setProgrammerMode(1);
  }

  @override
  onUpdate(Duration elapsed) {
    if (elapsed > nextFrame) {
      _fill();
      nextFrame += frameDuration;
    }
  }

  _fill() {
    for (int y = 0; y < 8; y++) {
      for (int x = 0; x < 8; x++) {
        if (heart[y][x] > 0) {
          launchpad.pulseCellPalette(Pos.from(x + 1, y + 1), 5);
        }
      }
    }
  }
}
