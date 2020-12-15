import 'package:aurora/devices/Launchpad.dart';
import 'package:aurora/devices/Palette.dart';
import 'package:aurora/devices/Pos.dart';
import 'package:aurora/effects/Effect.dart';

const frameDuration = Duration(seconds: 1);

class Blink extends Effect {
  Duration nextFrame = Duration.zero;
  int color = Palette.BLACK;

  Blink(Launchpad launchpad) : super(launchpad);

  @override
  onInitialize() {
    launchpad.setProgrammerMode(1);
  }

  @override
  onUpdate(Duration elapsed) {
    if (elapsed > nextFrame) {
      color = color == Palette.BLACK
          ? Palette.WHITE
          : Palette.BLACK;
      _fill(color);
      nextFrame += frameDuration;
    }
  }

  _fill(int color) {
    for (int y = 1; y < 9; y++) {
      for (int x = 1; x < 9; x++) {
        launchpad.setCellPalette(Point(x, y), color);
      }
    }
  }
}
