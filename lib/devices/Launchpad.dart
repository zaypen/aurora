import 'dart:typed_data';

import 'package:aurora/devices/Color.dart';
import 'package:aurora/devices/Pos.dart';
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

  setCellRgb(Pos pos, Color color) {
    _writeSysEx([0, 32, 41, 2, 14, 3, 3, pos.number] + color.bytes());
  }

  setCellPalette(Pos pos, int color) {
    _write([144, pos.number, color]);
  }

  flashCellPalette(Pos pos, int color) {
    _write([145, pos.number, color]);
  }

  pulseCellPalette(Pos pos, int color) {
    _write([146, pos.number, color]);
  }
}
