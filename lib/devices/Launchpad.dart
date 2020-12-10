import 'dart:math';
import 'dart:typed_data';
import 'dart:ui';

import 'package:flutter_midi_command/flutter_midi_command.dart';

class Launchpad {
  static const int COLOR_BLACK = 0;
  static const int COLOR_WHITE = 3;

  final MidiCommand _midiCommand = MidiCommand();

  _limit(int value, int minValue, int maxValue) {
    return max(min(maxValue, value), minValue);
  }

  _write(List<int> bytes) {
    _midiCommand.sendData(Uint8List.fromList(bytes));
  }

  _writeSysEx(List<int> bytes) {
    _write([0xf0] + bytes + [0xf7]);
  }

  reset() {
    setMode(1);
  }

  setMode(int mode) {
    if (mode < 0 || mode > 1) return;
    _writeSysEx([0, 32, 41, 2, 14, 14, mode]);
  }

  setCellRgb(int x, int y, int red, int green, int blue) {
    final r = _limit(red, 0, 63) << 1;
    final g = _limit(green, 0, 63) << 1;
    final b = _limit(blue, 0, 63) << 1;
    final number = _limit(10 * y + x, 0, 127);
    _writeSysEx([0, 32, 41, 2, 14, 3, 3, number, r, g, b]);
  }

  setCellCode(int x, int y, int code) {
    final number = _limit(10 * y + x, 0, 127);
    _write([144, number, code]);
  }
}
