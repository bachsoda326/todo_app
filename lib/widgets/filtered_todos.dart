import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todostream/blocs/blocs.dart';
import 'package:todostream/models/models.dart';
import 'package:todostream/screens/screens.dart';
import 'package:todostream/widgets/widgets.dart';

class FilteredTodos extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<TodosBloc>(
      builder: (context, bloc, child) => StreamBuilder<List<Todo>>(
        stream: bloc.todosStream,
        initialData: bloc.todos,
        builder: (context, todos) {
          return ListView.builder(
            itemCount: todos.data.length,
            itemBuilder: (context, index) {
              final todo = todos.data[index];
              return TodoItem(
                todo: todo,
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AddEditScreen(
                      isEditing: true,
                      todo: todo,
                      onPressed: (task, note) {
                        bloc.todosEventSink.add(
                            UpdateTodo(todo.copyWith(task: task, note: note)));
                      },
                    ),
                  ),
                ),
                onCheckboxChanged: (_) {
                  bloc.todosEventSink
                      .add(UpdateTodo(todo.copyWith(complete: !todo.complete)));
                },
                onDelete: () => bloc.todosEventSink.add(DeleteTodo(todo.id)),
              );
            },
          );
        },
      ),
    );
  }
}
