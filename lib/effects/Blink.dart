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
      color = color == Palette.BLACK ? Palette.WHITE : Palette.BLACK;
      _fill(color);
      while (nextFrame < elapsed) {
        nextFrame += frameDuration;
      }
    }
  }

  _fill(int color) {
    final indices = List.generate(8, (index) => 1 + index).expand(
        (row) => List.generate(8, (index) => Point(1 + index, row).toNumber()));
    final data = indices
        .expand((number) => [Launchpad.LIGHTING_TYPE_STATIC, number, color])
        .toList();
    launchpad.setCellBatch(data);
  }
}
