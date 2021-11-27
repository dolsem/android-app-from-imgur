part of 'search_cubit.dart';

@immutable
abstract class SearchState extends Equatable {
  const SearchState();
}

class SearchInitial extends SearchState {
  const SearchInitial();

  @override
  List<Object> get props => <Object>[];
}

class SearchInProgress extends SearchState {
  const SearchInProgress();

  @override
  List<Object> get props => <Object>[];
}

class SearchResultsPresent extends SearchState {
  const SearchResultsPresent(this.searchResults);

  final ImgurGallery searchResults;

  @override
  List<Object> get props => <Object>[searchResults];
}