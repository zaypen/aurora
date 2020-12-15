import 'dart:math';

import 'package:aurora/devices/Launchpad.dart';
import 'package:aurora/extensions/launchpad_point.dart';

abstract class Effect {
  final Launchpad launchpad;

  Effect(this.launchpad);

  onInitialize() {}

  onUpdate(Duration elapsed);

  onExit() {
    final data = List.generate(8, (index) => index)
        .expand((row) => List.generate(8, (index) => index).expand((col) => [
      Launchpad.LIGHTING_TYPE_STATIC,
      Point(8 - col, 8 - row).toNumber(),
      0
    ]))
        .toList();
    launchpad.setCellBatch(data);
  }
}
