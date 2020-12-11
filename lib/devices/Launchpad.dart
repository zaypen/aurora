import 'dart:typed_data';

import 'package:flutter_midi_command/flutter_midi_command.dart';

class Launchpad {
  final MidiCommand _midiCommand = MidiCommand();

  _write(List<int> bytes) {
    _midiCommand.sendData(Uint8List.fromList(bytes));
  }

  _writeSysEx(List<int> bytes) {
    _write([0xf0] + bytes + [0xf7]);
  }

  setProgrammerMode(int mode) {
    _writeSysEx([0, 32, 41, 2, 14, 14, mode.clamp(0, 1)]);
  }

  setCellRgb(int x, int y, int red, int green, int blue) {
    final r = red.clamp(0, 63);
    final g = green.clamp(0, 63);
    final b = blue.clamp(0, 63);
    final number = _translate(x, y);
    _writeSysEx([0, 32, 41, 2, 14, 3, 3, number, r, g, b]);
  }

  setCellCode(int x, int y, int code) {
    final number = _translate(x, y);
    _write([144, number, code]);
  }

  int _translate(int x, int y) {
    return (10 * y + x).clamp(0, 127);
  }
}
