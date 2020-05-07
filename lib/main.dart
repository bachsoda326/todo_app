import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todostream/blocs/blocs.dart';
import 'package:todostream/blocs/filtered_todos/filtered_todos.dart';
import 'package:todostream/blocs/tab/tab_bloc.dart';
import 'package:todostream/screens/screens.dart';

void main() => runApp(Provider<TodosBloc>(
      create: (_) => TodosBloc(),
      child: MyApp(),
    ));

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final todosBloc = Provider.of<TodosBloc>(context, listen: false);
    return MaterialApp(
      title: 'Todo Stream',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MultiProvider(
        providers: [
          Provider<FilteredTodosBloc>(
              create: (_) => FilteredTodosBloc(todosBloc: todosBloc)),
          Provider<TabBloc>(create: (_) => TabBloc()),
        ],
        child: HomeScreen(),
      ),
    );
  }
}
