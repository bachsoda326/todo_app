import 'dart:async';

import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';
import 'package:todostream/blocs/blocs.dart';
import 'package:todostream/models/models.dart';

class TabBloc {
  final StatsBloc statsBloc;
  AppTab tab;

  final StreamController<AppTab> _tabStateController = BehaviorSubject();
  StreamSink<AppTab> get _tabSink => _tabStateController.sink;
  Stream<AppTab> get tabStream => _tabStateController.stream;

  final StreamController<TabEvent> _tabEventController = BehaviorSubject();
  Sink<TabEvent> get tabEventSink => _tabEventController.sink;

  TabBloc({@required this.statsBloc}) {
    _tabEventController.stream.listen(_mapEventToState);
  }

  void _mapEventToState(TabEvent event) {
    if (event is UpdateTab) {
      tab = event.tab;
      if (tab == AppTab.stats) {
        statsBloc.statsEventSink.add(UpdateStats());
      }
      _tabSink.add(tab);
    }
  }

  void dispose() {
    _tabStateController.close();
    _tabEventController.close();
  }
}