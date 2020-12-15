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
    final data = List.generate(8, (index) => index)
        .expand((row) => List.generate(8, (index) => index).expand((col) => [
              Launchpad.LIGHTING_TYPE_PULSING,
              Point(8 - col, 8 - row).toNumber(),
              heart[row][col] > 0 ? 5 : 3
            ]))
        .toList();
    launchpad.setCellBatch(data);
  }
}
