import 'dart:async';

import 'package:aurora/components/Effects.dart';
import 'package:flutter/material.dart';
import 'package:flutter_midi_command/flutter_midi_command.dart';
import 'package:tuple/tuple.dart';

import 'Games.dart';
import 'Instruments.dart';

class Home extends StatefulWidget {
  Home({Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Future<bool> _onClose() {
    MidiCommand().teardown();
    return Future.value(true);
  }

  @override
  Widget build(BuildContext context) {
    final List<Tuple2<Widget, Widget>> tabs = [
      Tuple2(Tab(icon: Icon(Icons.music_video), text: 'Instruments'), Instruments()),
      Tuple2(Tab(icon: Icon(Icons.video_library), text: 'Effects'), Effects()),
      Tuple2(Tab(icon: Icon(Icons.videogame_asset), text: 'Games'), Games()),
    ];
    return WillPopScope(
      onWillPop: _onClose,
      child: DefaultTabController(
        length: tabs.length,
        child: Scaffold(
          appBar: AppBar(
            title: Text('Connected'),
          ),
          body: TabBarView(
            children: tabs.map((p) => p.item2).toList(),
          ),
          bottomNavigationBar: SafeArea(
            child: Container(
              color: Theme.of(context).primaryColor,
              child: TabBar(
                labelColor: Theme.of(context).bottomAppBarTheme.color,
                indicatorColor: Colors.white,
                tabs: tabs.map((p) => p.item1).toList(),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
