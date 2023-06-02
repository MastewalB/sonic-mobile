import 'package:flutter_bloc/flutter_bloc.dart';

import 'search_event.dart';
import 'search_state.dart';
import 'package:sonic_mobile/features/search/repository/http_search.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  final SearchDataProvider searchDataProvider;

  SearchBloc(this.searchDataProvider) : super(SearchInitial()) {
    on<PerformSearchEvent>(_performSearch);
    on<SearchQueryChangedEvent>(_handleSearchQueryChanged);
  }

  Future<void> _performSearch(
      PerformSearchEvent event, Emitter<SearchState> emit) async {
    emit(SearchLoadingState());

    try {
      final searchData = await searchDataProvider.search(event.query);

      if (searchData.isEmpty) {
        emit(SearchEmptyState());
      } else {
        emit(SearchLoadedState(searchData));
      }
    } catch (error) {
      emit(SearchErrorState('Failed to perform search: $error'));
    }
  }

  void _handleSearchQueryChanged(
      SearchQueryChangedEvent event, Emitter<SearchState> emit) async {
    // Handle search query changed event here
    // You can choose to update the search results instantly or debounce the search
    // and perform the search when the user pauses typing
    emit(SearchLoadingState());

    try {
      final searchData = await searchDataProvider.search(event.query);

      if (searchData.isEmpty) {
        emit(SearchEmptyState());
      } else {
        emit(SearchLoadedState(searchData));
      }
    } catch (error) {
      emit(SearchErrorState('Failed to perform search: $error'));
    }
  }
}
