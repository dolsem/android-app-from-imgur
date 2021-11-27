import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../models/selection.dart';

part 'selection_state.dart';

class SelectionCubit extends Cubit<SelectionState> {
  SelectionCubit() : super(SelectionInitial());

  static bool allowMultiSelect = true;

  void setSelection(Selection selection) {
    if (selection.images.isEmpty) {
      emit(SelectionInitial());
    } else {
      emit(SelectionPresent(selection));
    }
  }

  void addImage(String image) {
    if (state is SelectionPresent && allowMultiSelect) {
      emit(SelectionPresent((state as SelectionPresent).selection.addImage(image)));
    } else {
      emit(SelectionPresent(Selection(<String>[image])));
    }
  }

  void removeImage(String image) {
    if (state is SelectionPresent) {
      final Selection updated = (state as SelectionPresent).selection.removeImage(image);
      if (updated.isEmpty) {
        emit(SelectionInitial());
      } else {
        emit(SelectionPresent(updated));
      }
    }
  }

  void removeAll() {
    emit(SelectionInitial());
  }

  void toggleImage(String image) {
    if (hasImage(image)) {
      removeImage(image);
    } else {
      addImage(image);
    }
  }

  bool hasImage(String image) {
    if (state is SelectionPresent) {
      return (state as SelectionPresent).selection.hasImage(image);
    }

    return false;
  }
}
