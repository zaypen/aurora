import 'dart:typed_data';

import 'package:aurora/devices/Color.dart';
import 'package:aurora/devices/Pos.dart';
import 'package:flutter_midi_command/flutter_midi_command.dart';

class Launchpad {
  static const SYS_EX_START = 240;
  static const SYS_EX_END = 247;
  static const SYS_EX_HEADER = [0, 32, 41, 2];
  final MidiCommand _midiCommand = MidiCommand();

  _write(List<int> bytes) {
    _midiCommand.sendData(Uint8List.fromList(bytes));
  }

  _writeSysEx(List<int> bytes) {
    _write([SYS_EX_START] + bytes + [SYS_EX_END]);
  }

  setLayout(int layout, int page) {
    _writeSysEx(SYS_EX_HEADER + [14, 0, layout.clamp(0, 19), page, 0]);
  }

  setProgrammerMode(int mode) {
    _writeSysEx(SYS_EX_HEADER + [14, 14, mode.clamp(0, 1)]);
  }

  setCellRgb(Pos pos, Color color) {
    _writeSysEx(SYS_EX_HEADER + [14, 3, 3, pos.number] + color.bytes());
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
