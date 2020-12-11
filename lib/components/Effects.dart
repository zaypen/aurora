import 'package:aurora/components/EffectPlayer.dart';
import 'package:aurora/devices/Launchpad.dart';
import 'package:aurora/effects/Blink.dart';
import 'package:aurora/effects/Heart.dart';
import 'package:flutter/material.dart';
import 'package:tuple/tuple.dart';

class Effects extends StatelessWidget {
  final Launchpad _launchpad = Launchpad();
  final List<Tuple2<String, Function>> _effects = [
    Tuple2('Blink', (l) => Blink(l)),
    Tuple2('Heart', (l) => Heart(l)),
  ];

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(8.0),
      children: _effects
          .map((e) => _buildEffectTile(context, e.item1, e.item2))
          .toList(),
    );
  }

  Widget _buildEffectTile(BuildContext context, String name, Function build) {
    return ListTile(
      leading: Icon(Icons.movie),
      title: Text(name),
      trailing: RaisedButton(
        color: Colors.blue,
        child: Icon(Icons.play_arrow, color: Colors.white),
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => EffectPlayer(build(_launchpad))));
        },
      ),
    );
  }
}
