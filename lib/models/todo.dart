import 'package:equatable/equatable.dart';
import 'package:uuid/uuid.dart';
//import 'package:meta/meta.dart';

//@immutable
class Todo extends Equatable {
  final String id;
  final String task;
  final String note;
  final bool complete;

  Todo({String id, this.task, String note = "", this.complete = false})
      : id = id ?? Uuid().v4(),
        note = note;

  Todo copyWith({String id, String task, String note, bool complete}) {
    return Todo(
      id: id ?? this.id,
      task: task ?? this.task,
      note: note ?? this.note,
      complete: complete ?? this.complete,
    );
  }

  @override
  List<Object> get props => [id, task, note, complete];
}
