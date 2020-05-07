import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todostream/blocs/blocs.dart';
import 'package:todostream/blocs/tab/tab.dart';
import 'package:todostream/models/models.dart';
import 'package:todostream/screens/screens.dart';
import 'package:todostream/widgets/widgets.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<TabBloc>(
      builder: (context, bloc, child) => StreamBuilder<AppTab>(
        stream: bloc.tabStream,
        initialData: AppTab.todos,
        builder: (context, activeTab) {
          return Scaffold(
            appBar: AppBar(
              title: Text("Todo List"),
              actions: [
                FilterButton(),
                ExtraActions(),
              ],
            ),
            body: activeTab.data == AppTab.todos ? FilteredTodos() : Stats(),
            floatingActionButton: Consumer<TodosBloc>(
              builder: (context, bloc, child) => FloatingActionButton(
                onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AddEditScreen(
                      isEditing: false,
                      onPressed: (task, note) {
                        bloc.todosEventSink.add(AddTodo(task, note));
                      },
                    ),
                  ),
                ),
                child: Icon(Icons.add),
                tooltip: "Add todo",
              ),
            ),
            bottomNavigationBar: TabSelector(
              activeTab: activeTab.data,
              onTabSelected: (tab) => bloc.tabEventSink.add(UpdateTab(tab)),
            ),
          );
        },
      ),
    );
  }
}
