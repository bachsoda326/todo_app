import 'dart:async';

import 'package:rxdart/rxdart.dart';
import 'package:todostream/blocs/blocs.dart';
import 'package:todostream/models/models.dart';

class TodosBloc {
  //example
  static Todo todo = Todo(
    task: "task 1",
    note: "note 1",
    complete: false,
  );
  static Todo todo1 = Todo(
    task: "task 2",
    note: "note 2",
    complete: true,
  );
  List<Todo> todos = [todo, todo1];

  final StreamController<List<Todo>> _todosStateController = BehaviorSubject();
  StreamSink<List<Todo>> get todosSink => _todosStateController.sink;
  Stream<List<Todo>> get todosStream => _todosStateController.stream;

  final StreamController<TodosEvent> _todosEventController = BehaviorSubject();
  Sink<TodosEvent> get todosEventSink => _todosEventController.sink;

  TodosBloc() {
    _todosEventController.stream.listen(_mapEventToState);
  }

  void _mapEventToState(TodosEvent event) {
    if (event is AddTodo) {
      Todo todo = Todo(
        task: event.task,
        note: event.note,
        complete: false,
      );
      todos.add(todo);
      todosSink.add(todos);
    }
    else if (event is UpdateTodo) {
      for (int i = 0; i < todos.length; i++) {
        if (event.todo.id == todos[i].id) {
          todos[i] = event.todo;
          break;
        }
      }
      todosSink.add(todos);
    }
    else if (event is DeleteTodo) {
      for (int i = 0; i < todos.length; i++) {
        if (todos[i].id == event.id) {
          todos.removeAt(i);
          break;
        }
      }
      todosSink.add(todos);
    }
    else if (event is MarkAllComplete) {
      for (int i = 0; i < todos.length; i++) {
        if (!todos[i].complete) {
          final todo = todos[i].copyWith(complete: true);
          todos[i] = todo;
        }
      }
      todosSink.add(todos);
    }
    else if (event is MarkAllIncomplete) {
      for (int i = 0; i < todos.length; i++) {
        if (todos[i].complete) {
          final todo = todos[i].copyWith(complete: false);
          todos[i] = todo;
        }
      }
      todosSink.add(todos);
    }
  }

  void dispose() {
    _todosStateController.close();
    _todosEventController.close();
  }
}
