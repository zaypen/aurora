import 'package:flutter/painting.dart';

extension LaunchpadColor on Color {
  List<int> toBytes() => [this.red >> 1, this.green >> 1, this.blue >> 1];
}
