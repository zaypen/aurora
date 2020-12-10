import 'package:aurora/devices/Launchpad.dart';

abstract class Effect {
  final Launchpad launchpad;

  Effect(this.launchpad);

  onInitialize();

  onUpdate(Duration elapsed);
}
