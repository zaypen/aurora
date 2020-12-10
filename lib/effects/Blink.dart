import 'package:aurora/devices/Launchpad.dart';
import 'package:aurora/effects/Effect.dart';

const frameDuration = Duration(seconds: 1);

class Blink extends Effect {
  Duration nextFrame = Duration.zero;
  int color = Launchpad.COLOR_BLACK;

  Blink(Launchpad launchpad) : super(launchpad);

  @override
  onInitialize() {
    launchpad.reset();
  }

  @override
  onUpdate(Duration elapsed) {
    if (elapsed > nextFrame) {
      color = color == Launchpad.COLOR_BLACK
          ? Launchpad.COLOR_WHITE
          : Launchpad.COLOR_BLACK;
      _fill(color);
      nextFrame += frameDuration;
    }
  }

  _fill(int color) {
    for (int y = 1; y < 9; y++) {
      for (int x = 1; x < 9; x++) {
        launchpad.setCellCode(x, y, color);
      }
    }
  }
}
