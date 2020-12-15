import 'dart:typed_data';

import 'package:aurora/devices/Color.dart';
import 'package:aurora/devices/Pos.dart';
import 'package:flutter_midi_command/flutter_midi_command.dart';

class Launchpad {
  static const LIGHTING_TYPE_STATIC = 0;
  static const LIGHTING_TYPE_FLASHING = 1;
  static const LIGHTING_TYPE_PULSING = 2;
  static const LIGHTING_TYPE_RGB = 3;
  static const SYS_EX_START = 240;
  static const SYS_EX_END = 247;
  static const SYS_EX_HEADER = [0, 32, 41, 2];
  final MidiCommand _midiCommand = MidiCommand();

  write(List<int> bytes) {
    _midiCommand.sendData(Uint8List.fromList(bytes));
  }

  writeSysEx(List<int> bytes) {
    write([SYS_EX_START] + bytes + [SYS_EX_END]);
  }

  setLayout(int layout, int page) {
    writeSysEx(SYS_EX_HEADER + [14, 0, layout.clamp(0, 19), page, 0]);
  }

  setProgrammerMode(int mode) {
    writeSysEx(SYS_EX_HEADER + [14, 14, mode.clamp(0, 1)]);
  }

  setCellRgb(Point point, Color color) {
    writeSysEx(SYS_EX_HEADER + [14, 3, 3, point.toNumber()] + color.bytes());
  }

  setCellPalette(Point point, int color) {
    write([144, point.toNumber(), color]);
  }

  flashCellPalette(Point point, int color) {
    write([145, point.toNumber(), color]);
  }

  pulseCellPalette(Point point, int color) {
    write([146, point.toNumber(), color]);
  }

  /// Set cells in a batch
  ///
  /// The data for each pad is structured as follows:
  /// * Lighting type (1 byte)
  /// * LED index (1 byte)
  /// * Lighting data (1 – 3 bytes)
  ///
  /// Lighting types:
  /// * Hex: 00h / Decimal: 0 --- Static colour from palette, Lighting data is 1 byte specifying palette entry.
  /// * Hex: 01h / Decimal: 1 --- Flashing colour, Lighting data is 2 bytes specifying Colour B and Colour A.
  /// * Hex: 02h / Decimal: 2 --- Pulsing colour, Lighting data is 1 byte specifying palette entry.
  /// * Hex: 03h / Decimal: 3 --- RGB colour, Lighting data is 3 bytes for Red, Green and Blue (127: Max, 0: Min).
  ///
  /// The message may contain up to 106 entries to light up the entire Launchpad Pro MK3 surface.
  setCellBatch(List<int> data) {
    writeSysEx(SYS_EX_HEADER + [14, 3] + data);
  }

}
