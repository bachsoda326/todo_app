import 'dart:async';

import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';
import 'package:todostream/blocs/blocs.dart';

class StatsBloc {
  final TodosBloc todosBloc;
  int activedNum;
  int completedNum;

  final StreamController<int> _activedStateController = BehaviorSubject();
  StreamSink<int> get _activedSink => _activedStateController.sink;
  Stream<int> get activedStream => _activedStateController.stream;

  final StreamController<int> _completedStateController = BehaviorSubject();
  StreamSink<int> get _completedSink => _completedStateController.sink;
  Stream<int> get completedStream => _completedStateController.stream;

  final StreamController<StatsEvent> _statsEventController = BehaviorSubject();
  StreamSink<StatsEvent> get statsEventSink => _statsEventController.sink;

  StatsBloc({@required this.todosBloc}) {
    //statsEventSink.add(UpdateStats());
    _statsEventController.stream.listen(_mapEventToState);
  }

  void _mapEventToState(StatsEvent event) {
    if (event is UpdateStats) {
      activedNum = todosBloc.todos.where((todo) => !todo.complete).toList().length;
      completedNum = todosBloc.todos.where((todo) => todo.complete).toList().length;

      _activedSink.add(activedNum);
      _completedSink.add(completedNum);
    }
  }

  void dispose() {
    _activedStateController.close();
    _completedStateController.close();
    _statsEventController.close();
  }
}