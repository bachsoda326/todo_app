import 'package:flutter/material.dart';
import 'package:todostream/models/models.dart';

class TodoItem extends StatelessWidget {
  final Todo todo;
  final GestureTapCallback onTap;
  final ValueChanged<bool> onCheckboxChanged;
  final Function onDelete;

  TodoItem({
    @required this.todo,
    @required this.onTap,
    @required this.onCheckboxChanged,
    @required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      key: Key(todo.id),
      onTap: onTap,
      leading: Checkbox(
        value: todo.complete,
        onChanged: onCheckboxChanged,
      ),
      title: Text(todo.task),
      subtitle: todo.note.isNotEmpty
          ? Text(
              todo.note,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context).textTheme.subhead,
            )
          : null,
      trailing: IconButton(
        icon: Icon(
          Icons.delete,
          color: Colors.red,
        ),
        onPressed: onDelete,
      ),
    );
  }
}
