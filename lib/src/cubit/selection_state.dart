part of 'selection_cubit.dart';

abstract class SelectionState extends Equatable {
  const SelectionState();
}

class SelectionInitial extends SelectionState {
  @override
  List<Object> get props => <Object>[];
}

class SelectionPresent extends SelectionState {
  const SelectionPresent(this.selection);

  final Selection selection;

  @override
  List<Object> get props => selection.props;
}


