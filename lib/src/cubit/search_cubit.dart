import 'package:equatable/equatable.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../api/imgur.dart' as imgur;
import '../models/imgur_gallery.dart';

part 'search_state.dart';

class SearchCubit extends Cubit<SearchState> {
  SearchCubit() : super(const SearchInitial());

  Future<void> searchImages({
    String? query,
    required imgur.ImgurSortOption sort,
    required imgur.ImgurWindowOption window,
  }) async {
    try {
      Future<ImgurGallery?> searchResults;
      if (query == null || query.isEmpty) {
        searchResults = imgur.getHotImages(sort, window);
      } else {
        searchResults = imgur.searchImages(query, sort, window);
      }
      emit(const SearchInProgress());
      emit(SearchResultsPresent((await searchResults)!));
    } catch (err, stacktrace) {
      print('Error performing search: $err');
      print(stacktrace);
    }
  }

  Future<void> ensureSearchResultsPresent({
    String? query,
    required imgur.ImgurSortOption sort,
    required imgur.ImgurWindowOption window,
  }) async {
    if (state is SearchInitial) {
      searchImages(query: query, sort: sort, window: window);
    }
  }
}
