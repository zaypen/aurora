import 'dart:math' show Point, cos, sin, sqrt;

import 'package:aurora/devices/Launchpad.dart';
import 'package:aurora/devices/Palette.dart';
import 'package:aurora/extensions/launchpad_color.dart';
import 'package:aurora/extensions/launchpad_point.dart';
import 'package:aurora/effects/Effect.dart';
import 'package:flutter/painting.dart';
import 'package:tuple/tuple.dart';

const frameDuration = Duration(milliseconds: 100);

class Aurora extends Effect {
  final indices = List.generate(10, (index) => index)
      .expand((row) => List.generate(10, (col) => Tuple2(col, row))).toList();
  Duration nextFrame = Duration.zero;

  Aurora(Launchpad launchpad) : super(launchpad);

  @override
  onInitialize() {
    launchpad.setProgrammerMode(1);
  }

  @override
  onUpdate(Duration elapsed) {
    if (elapsed > nextFrame) {
      _fill(elapsed);
      while (nextFrame < elapsed) {
        nextFrame += frameDuration;
      }
    }
  }

  _fill(Duration elapsed) {
    int ms = elapsed.inMilliseconds;
    double ox = sin(ms / 500);
    double oy = cos(ms / 500);
    double offset = (ms / 2000).toDouble();
    final data = indices.expand((element) {
      final x = element.item1;
      final y = element.item2;
      final xx = x / 32 + ox;
      final yy = y / 32 + oy;
      final hue = sin(sqrt(xx * xx + yy * yy) + offset) * 180 + 180;
      return [
        Launchpad.LIGHTING_TYPE_RGB,
        Point(x, y).toNumber(),
        ...HSVColor.fromAHSV(1, hue, 1, 1).toColor().toBytes(),
      ];
    }).toList();
    launchpad.setCellBatch(data);
  }
}
