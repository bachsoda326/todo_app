import 'package:equatable/equatable.dart';
import 'package:todostream/models/models.dart';

abstract class StatsEvent extends Equatable {
  const StatsEvent();
}

class UpdateStats extends StatsEvent {
  //final List<Todo> todos;

  const UpdateStats();

  @override
  List<Object> get props => null;
}