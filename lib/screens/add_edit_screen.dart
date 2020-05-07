import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todostream/blocs/blocs.dart';
import 'package:todostream/models/models.dart';

class AddEditScreen extends StatefulWidget {
  final bool isEditing;
  final Todo todo;
  final Function(String, String) onPressed;

  AddEditScreen({
    @required this.isEditing,
    @required this.onPressed,
    this.todo,
  });

  @override
  State<StatefulWidget> createState() {
    return _AddEditScreenState();
  }
}

class _AddEditScreenState extends State<AddEditScreen> {
  static final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String _task;
  String _note;

  bool get isEditing => widget.isEditing;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
        appBar: AppBar(
          title: isEditing ? Text("Edit Todo") : Text("Add Todo"),
        ),
        body: Padding(
          padding: EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: ListView(
              children: [
                TextFormField(
                  initialValue: isEditing ? widget.todo.task : '',
                  autofocus: !isEditing,
                  style: textTheme.headline,
                  decoration: InputDecoration(
                    hintText: "What needs to be done?",
                  ),
                  validator: (val) {
                    return val.trim().isEmpty ? "Please enter some text" : null;
                  },
                  onSaved: (value) => _task = value,
                ),
                TextFormField(
                  initialValue: isEditing ? widget.todo.note : '',
                  maxLines: 10,
                  style: textTheme.subhead,
                  decoration: InputDecoration(
                    hintText: "Additional Notes...",
                  ),
                  onSaved: (value) => _note = value,
                )
              ],
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          tooltip: isEditing ? "Save changes" : "Add todo",
          child: Icon(isEditing ? Icons.check : Icons.add),
          onPressed: () {
            if (_formKey.currentState.validate()) {
              _formKey.currentState.save();
              widget.onPressed(_task, _note);
              Navigator.pop(context);
            }
          },
        ),
      );
  }
}
