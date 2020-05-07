import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todostream/blocs/blocs.dart';
import 'package:todostream/models/models.dart';

class ExtraActions extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return ExtraActionsState();
  }
}

class ExtraActionsState extends State<ExtraActions> {
  @override
  Widget build(BuildContext context) {
    return Consumer<TodosBloc>(
      builder: (context, bloc, child) => PopupMenuButton<ExtraAction>(
        onSelected: (action) {
          switch (action) {
            case ExtraAction.allComplete:
              bloc.todosEventSink.add(MarkAllComplete());
              break;
            case ExtraAction.allIncomplete:
              bloc.todosEventSink.add(MarkAllIncomplete());
              break;
            case ExtraAction.clearCompleted:
            // TODO: Handle this case.
              break;
          }
        },
        itemBuilder: (context) => <PopupMenuItem<ExtraAction>>[
          const PopupMenuItem(
            value: ExtraAction.allComplete,
            child: Text("Mark all complete"),
          ),
          const PopupMenuItem(
            value: ExtraAction.allIncomplete,
            child: Text("Mark all incomplete"),
          ),
          const PopupMenuItem(
            value: ExtraAction.clearCompleted,
            child: Text("Clear completed"),
          ),
        ],
      ),
    );
  }
}
