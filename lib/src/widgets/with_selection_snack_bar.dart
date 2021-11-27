import 'dart:core';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_stream_listener/flutter_stream_listener.dart';
import 'package:rxdart/rxdart.dart';

import '../cubit/selection_cubit.dart';
import '../models/selection.dart';

class WithSelectionSnackBar extends StatelessWidget {
  const WithSelectionSnackBar({Key? key, required this.child}) : super(key: key);

  final Widget child;

  @override
  Widget build(BuildContext context) {
    final Stream<SelectionState> stream = context.read<SelectionCubit>().stream;
    return StreamListener<SelectionState>(
      stream: stream.debounceTime(const Duration(milliseconds: 250)),
      onData: (SelectionState state) => _update(context, state),
      child: child,
    );
  }

  void _update(BuildContext context, SelectionState state) {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    if (state is SelectionPresent) {
      final Selection selection = state.selection;
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('${selection.size} Selected'),
        duration: const Duration(days: 1),
        action: SnackBarAction(
          label: 'Deselect All',
          onPressed: () {
            context.read<SelectionCubit>().removeAll();
          },
        ),
      ));
    }
  }

}