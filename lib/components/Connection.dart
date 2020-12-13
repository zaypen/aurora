import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_midi_command/flutter_midi_command.dart';

import 'Home.dart';

class Connection extends StatefulWidget {
  Connection({Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => new _ConnectionState();
}

class _ConnectionState extends State<Connection> {
  final MidiCommand _midiCommand = MidiCommand();
  StreamSubscription<String> _setupSubscription;

  @override
  void initState() {
    super.initState();
    _setupSubscription = _midiCommand.onMidiSetupChanged.listen((data) {
      switch (data) {
        case "deviceFound":
          setState(() {});
          break;
        case 'deviceOpened':
        case 'deviceConnected':
          Navigator.push(
              context,
              MaterialPageRoute<Null>(
                builder: (_) => Home(),
                fullscreenDialog: true,
              ));
          break;
        case 'deviceLost':
          while (Navigator.of(context).canPop()) {
            Navigator.of(context).pop();
          }
          break;
        default:
          print("Unhandled setup change: $data");
          break;
      }
    });
  }

  @override
  void dispose() {
    _setupSubscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Choose your device'),
      ),
      body: FutureBuilder(
        future: _midiCommand.devices,
        builder: (_, snapshot) =>
            _buildListView(snapshot.data as List<MidiDevice>),
      ),
    );
  }

  Widget _buildListView(List<MidiDevice> devices) {
    final tiles = (devices ?? []).skipWhile((it) => it == null).map(_buildTile).toList();
    return ListView(children: tiles.length > 0 ? tiles : [buildEmptyTile()].toList());
  }

  Widget _buildTile(MidiDevice device) {
    return ListTile(
      leading: Text(device.id),
      title: Text(
        device.name,
        style: Theme.of(context).textTheme.subtitle1,
      ),
      onTap: () {
        _midiCommand.connectToDevice(device);
      },
    );
  }

  Widget buildEmptyTile() {
    return Container(
      padding: const EdgeInsets.all(12),
      child: Text(
        'No device found.',
        style: Theme.of(context).textTheme.subtitle1,
        textAlign: TextAlign.center,
      ),
    );
  }
}
