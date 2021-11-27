import 'package:collection/collection.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../api/imgur.dart' as imgur;
import '../cubit/auth_cubit.dart';
import '../cubit/search_cubit.dart';
import '../extensions/string_extension.dart';

class SearchFilters extends StatefulWidget {
  const SearchFilters({Key? key}) : super(key: key);

  @override
  _SearchFiltersState createState() => _SearchFiltersState();
}

class _SearchFiltersState extends State<SearchFilters> {
  TextEditingController? textInputController;
  int selectedSortOptionIx = 0;
  int selectedWindowOptionIx = 0;
  String? currentQuery;
  static final List<imgur.ImgurSortOption> sortOptions = <imgur.ImgurSortOption>[
    imgur.ImgurSortOption.time,
    imgur.ImgurSortOption.viral,
    imgur.ImgurSortOption.top,
  ];
  static final List<imgur.ImgurWindowOption> windowOptions = <imgur.ImgurWindowOption>[
    imgur.ImgurWindowOption.all,
    imgur.ImgurWindowOption.day,
    imgur.ImgurWindowOption.week,
    imgur.ImgurWindowOption.month,
    imgur.ImgurWindowOption.year,
  ];

  @override
  void dispose() {
    textInputController!.dispose();
    super.dispose();
  }

  @override
  void initState() {
    textInputController = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final SearchCubit searchCubit = context.read<SearchCubit>();
    searchCubit.ensureSearchResultsPresent(
      query: currentQuery,
      sort: sortOptions[selectedSortOptionIx],
      window: windowOptions[selectedWindowOptionIx],
    );

    return Column(
      children: <Widget>[
        searchBar(context),
        Container(
          padding: const EdgeInsets.all(5),
          child: Column(
            children: <Widget>[
              sortPicker(context),
              windowPicker(context),
            ],
          ),
        ),
      ],
    );
  }

  void _doSearch(BuildContext context) {
    final SearchCubit searchCubit = context.read<SearchCubit>();
    searchCubit.searchImages(
      query: currentQuery,
      sort: sortOptions[selectedSortOptionIx],
      window: windowOptions[selectedWindowOptionIx],
    );
  }

  void _updateQuery(BuildContext context, String query) {
    final AuthState state = context.read<AuthCubit>().state;
    if (state is AuthLoaded) {
      setState(() => currentQuery = query);
      _doSearch(context);
    }
  }

  void _updateSort(BuildContext context, int sortOptionIx) {
    final AuthState state = context.read<AuthCubit>().state;
    if (state is AuthLoaded) {
      setState(() => selectedSortOptionIx = sortOptionIx);
      _doSearch(context);
    }
  }

  void _updateWindow(BuildContext context, int windowOptionIx) {
    final AuthState state = context.read<AuthCubit>().state;
    if (state is AuthLoaded) {
      setState(() => selectedWindowOptionIx = windowOptionIx);
      _doSearch(context);
    }
  }

  Widget searchBar(BuildContext context) {
    return Container(
      alignment: Alignment.topCenter,
      child: TextField(
        onSubmitted: (String query) => _updateQuery(context, query),
        controller: textInputController,
        decoration: const InputDecoration(
            border: InputBorder.none,
            prefixIcon: Icon(Icons.search, color: Colors.grey),
            hintText: 'Search...',
            hintStyle: TextStyle(color: Colors.grey)
        ),
        textAlignVertical: TextAlignVertical.center,
      ),
    );
  }

  Widget sortPicker(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: sortOptions.mapIndexed((int ix, imgur.ImgurSortOption sort) {
        return Container(
          padding: const EdgeInsets.only(right: 5),
          child: InputChip(
            selected: ix == selectedSortOptionIx,
            selectedColor: Colors.lightBlueAccent,
            label: Text(describeEnum(sort).capitalize()),
            onPressed: () => _updateSort(context, ix),
          ),
        );
      }).toList(),
    );
  }

  Widget windowPicker(BuildContext context) {
    return Row(
      children: windowOptions.mapIndexed((int ix, imgur.ImgurWindowOption window) {
        return Container(
          padding: const EdgeInsets.only(right: 5),
          child: InputChip(
            selected: ix == selectedWindowOptionIx,
            selectedColor: Colors.lightBlueAccent,
            label: Text(describeEnum(window).capitalize()),
            onPressed: () => _updateWindow(context, ix),
          ),
        );
      }).toList(),
    );
  }
}