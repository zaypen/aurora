import 'package:aurora/components/Connection.dart';
import 'package:flutter/material.dart';

import 'Connection.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Aurora',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: Connection(),
    );
  }
}
