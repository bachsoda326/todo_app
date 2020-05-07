import 'package:equatable/equatable.dart';

abstract class FilteredTodosEvent extends Equatable {
  const FilteredTodosEvent();
}

class UpdateFilter extends FilteredTodosEvent {
  final filter;

  const UpdateFilter(this.filter);

  @override
  List<Object> get props => null;
}