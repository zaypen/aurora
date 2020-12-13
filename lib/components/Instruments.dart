import 'dart:async';
import 'dart:typed_data';

import 'package:aurora/extensions/hex.dart';
import 'package:flutter/material.dart';
import 'package:flutter_midi_command/flutter_midi_command.dart';
import 'package:flutter_midi_synthesizer/flutter_midi_synthesizer.dart';

class Instruments extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _InstrumentsState();
}

class _InstrumentsState extends State<Instruments> {
  final MidiCommand _midiCommand = MidiCommand();
  StreamSubscription<Uint8List> _rxSubscription;

  @override
  initState() {
    super.initState();
    _rxSubscription = _midiCommand.onMidiDataReceived.listen(_handleMidiData);
  }

  @override
  dispose() {
    _rxSubscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8),
      child: Icon(Icons.music_note, size: 48),
    );
  }

  _handleMidiData(Uint8List data) {
    print('MIDI Data: ${data.map((b) => b.toHex()).toList()}');
    MidiSynthesizer.write(data);
  }
}
