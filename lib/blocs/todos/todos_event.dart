import 'package:equatable/equatable.dart';
import 'package:todostream/models/models.dart';

abstract class TodosEvent extends Equatable {
  const TodosEvent();

  @override
  List<Object> get props => [];
}

class AddTodo extends TodosEvent {
  final String task;
  final String note;

  const AddTodo(this.task, this.note);

  @override
  List<Object> get props => [task, note];
}

class UpdateTodo extends TodosEvent {
  final Todo todo;

  const UpdateTodo(this.todo);

  @override
  List<Object> get props => [todo];
}

class DeleteTodo extends TodosEvent {
  final String id;

  const DeleteTodo(this.id);

  @override
  List<Object> get props => [id];
}

class MarkAllComplete extends TodosEvent {}

class MarkAllIncomplete extends TodosEvent {}
