import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todostream/blocs/filtered_todos/filtered_todos.dart';
import 'package:todostream/models/models.dart';

class FilterButton extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return FilterButtonState();
  }
}

class FilterButtonState extends State<FilterButton> {
  @override
  Widget build(BuildContext context) {
    return Consumer<FilteredTodosBloc>(
      builder: (context, bloc, child) => StreamBuilder<VisibilityFilter>(
        stream: bloc.filterStream,
        builder: (context, sFilter) {
          return PopupMenuButton<VisibilityFilter>(
            onSelected: (filter) {
              bloc.filterEventSink.add(UpdateFilter(filter));
            },
            icon: Icon(Icons.filter_list),
            itemBuilder: (context) => <PopupMenuItem<VisibilityFilter>>[
              PopupMenuItem(
                value: VisibilityFilter.all,
                child: Text(
                  "Show all",
                  style: sFilter.data == VisibilityFilter.all
                      ? TextStyle(color: Colors.blue)
                      : TextStyle(color: Colors.black),
                ),
              ),
              PopupMenuItem(
                value: VisibilityFilter.active,
                child: Text(
                  "Show active",
                  style: sFilter.data == VisibilityFilter.active
                      ? TextStyle(color: Colors.blue)
                      : TextStyle(color: Colors.black),
                ),
              ),
              PopupMenuItem(
                value: VisibilityFilter.completed,
                child: Text(
                  "Show completed",
                  style: sFilter.data == VisibilityFilter.completed
                      ? TextStyle(color: Colors.blue)
                      : TextStyle(color: Colors.black),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
