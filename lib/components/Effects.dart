import 'package:aurora/devices/Launchpad.dart';
import 'package:aurora/effects/Blink.dart';
import 'package:aurora/effects/Effect.dart';
import 'package:aurora/effects/Heart.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:tuple/tuple.dart';

class Effects extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _EffectsState();
}

class _EffectsState extends State<Effects> with SingleTickerProviderStateMixin {
  final Launchpad _launchpad = Launchpad();
  List<Tuple2<String, Function>> _effects;
  Effect _effect;
  Ticker _ticker;

  _EffectsState() {
    _effects = [
      Tuple2('Blink', (l) => Blink(l)),
      Tuple2('Heart', (l) => Heart(l)),
    ];
  }

  _onTick(Duration elapsed) {
    if (_effect == null) return;
    _effect.onUpdate(elapsed);
  }

  @override
  void initState() {
    super.initState();
    _ticker = createTicker(_onTick);
    _ticker.start();
  }

  @override
  void dispose() {
    _ticker.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(8.0),
      children:
          _effects.map((e) => _buildEffectTile(e.item1, e.item2)).toList(),
    );
  }

  Widget _buildEffectTile(String name, Function builder) {
    return ListTile(
      leading: Icon(Icons.movie),
      title: Text(name),
      trailing: RaisedButton(
        color: Colors.blue,
        child: Icon(Icons.play_arrow, color: Colors.white),
        onPressed: () {
          setState(() {
            _effect = builder(_launchpad);
          });
        },
      ),
    );
  }
}
