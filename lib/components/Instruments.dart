import 'dart:async';
import 'dart:developer' as d;
import 'dart:typed_data';

import 'package:aurora/extensions/hex.dart';
import 'package:flutter/material.dart';
import 'package:flutter_midi_command/flutter_midi_command.dart';
import 'package:flutter_midi_synthesizer/flutter_midi_synthesizer.dart';
import 'package:tonic/tonic.dart';

class Instruments extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _InstrumentsState();
}

class _InstrumentsState extends State<Instruments> {
  final MidiCommand _midiCommand = MidiCommand();
  StreamSubscription<Uint8List> _rxSubscription;

  initMidi() async {
    await MidiSynthesizer.start();
  }

  @override
  initState() {
    super.initState();
    initMidi();
    _rxSubscription = _midiCommand.onMidiDataReceived.listen(_handleMidiData);
  }

  @override
  void dispose() {
    _rxSubscription.cancel();
    MidiSynthesizer.stop();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8),
      child: Icon(Icons.music_note, size: 48),
    );
  }

  void _handleMidiData(Uint8List data) {
    var status = data[0];
    final type = (status & 0xF0);
    final channel = (status & 0x0F);

    d.log('MIDI Data: ${data.map((b) => b.toHex()).toList()}', level: 0);
    switch (type) {
      case 0x80: // Note on: [pitch, velocity]
        final pitch = data[1];
        final velocity = data[2];
        MidiSynthesizer.write(data);
        d.log(
            'Note on: $pitch(${Pitch.fromMidiNumber(pitch)}), $velocity @ $channel');
        break;
      case 0x90: // Note off: [pitch, velocity]
        final pitch = data[1];
        final velocity = data[2];
        MidiSynthesizer.write(data);
        d.log('Note off: $pitch(${Pitch.fromMidiNumber(pitch)}) @ $channel');
        break;
      case 0xA0: // Key pressure: [key, pressure]
        break;
      case 0xB0: // Controller change: [controller, value]
        break;
      case 0xC0: // Program change: [preset]
        break;
      case 0xD0: // Channel pressure: [pressure]
        break;
      case 0xE0: // Pitch bend
        break;
      default:
    }
  }
}
