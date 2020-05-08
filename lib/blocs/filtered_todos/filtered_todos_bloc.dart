import 'dart:async';

import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';
import 'package:todostream/blocs/blocs.dart';
import 'package:todostream/models/models.dart';

import '../blocs.dart';

class FilteredTodosBloc {
  final TodosBloc todosBloc;
  VisibilityFilter filter;

  final StreamController<VisibilityFilter> _filterStateController =
      BehaviorSubject();
  StreamSink<VisibilityFilter> get _filterSink => _filterStateController.sink;
  Stream<VisibilityFilter> get filterStream => _filterStateController.stream;

  final StreamController<FilteredTodosEvent> _filterEventController =
      BehaviorSubject();
  Sink<FilteredTodosEvent> get filterEventSink => _filterEventController.sink;

  FilteredTodosBloc({@required this.todosBloc}) {
    _filterEventController.stream.listen(_mapEventToState);
  }

  void _mapEventToState(FilteredTodosEvent event) {
    if (event is UpdateFilter) {
      filter = event.filter;
      _filterSink.add(filter);
      _mapTodosToFilteredTodos();
    }
  }

  void _mapTodosToFilteredTodos() {
    final filteredTodos = todosBloc.todos.where((todo) {
      if (filter == VisibilityFilter.all) {
        return true;
      } else if (filter == VisibilityFilter.active) {
        return !todo.complete;
      } else {
        return todo.complete;
      }
    }).toList();
    todosBloc.todosSink.add(filteredTodos);
  }

  void dispose() {
    _filterStateController.close();
    _filterEventController.close();
  }
}
