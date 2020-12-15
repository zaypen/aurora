import 'package:aurora/effects/Effect.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

class EffectPlayer extends StatefulWidget {
  final Effect _effect;

  const EffectPlayer(this._effect, {Key key})
      : assert(_effect != null),
        super(key: key);

  @override
  State<StatefulWidget> createState() => _EffectPlayerState();
}

class _EffectPlayerState extends State<EffectPlayer>
    with SingleTickerProviderStateMixin {
  Ticker _ticker;

  _onTick(Duration elapsed) {
    widget._effect.onUpdate(elapsed);
  }

  @override
  void initState() {
    super.initState();
    _ticker = createTicker(_onTick);
    _ticker.start();
  }

  @override
  void dispose() {
    _ticker.stop();
    _ticker.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              flex: 2,
              child: Center(child: CircularProgressIndicator()),
            ),
            Expanded(
              child: Center(
                child: RaisedButton(
                  child: const Text('Stop'),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
