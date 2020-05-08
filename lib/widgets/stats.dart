import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todostream/blocs/blocs.dart';

class Stats extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<StatsBloc>(
      builder: (context, bloc, child) => Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Actived tasks',
              style: Theme.of(context).textTheme.title,
            ),
            StreamBuilder<int>(
              stream: bloc.activedStream,
              builder: (context, activedNum) => Text(
                '${activedNum.data}',
                style: Theme.of(context).textTheme.subhead,
              ),
            ),
            SizedBox(
              height: 16.0,
            ),
            Text(
              'Completed tasks',
              style: Theme.of(context).textTheme.title,
            ),
            StreamBuilder<int>(
              stream: bloc.completedStream,
              builder: (context, completedNum) => Text(
                '${completedNum.data}',
                style: Theme.of(context).textTheme.subhead,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
