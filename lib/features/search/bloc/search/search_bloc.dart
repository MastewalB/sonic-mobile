import 'package:flutter_bloc/flutter_bloc.dart';

import 'search_event.dart';
import 'search_state.dart';
import 'package:sonic_mobile/features/search/repository/http_search.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  final SearchDataProvider searchDataProvider;

  SearchBloc({required this.searchDataProvider}) : super(SearchInitial());

  Stream<SearchState> mapEventToState(SearchEvent event) async* {
    if (event is PerformSearchEvent) {
      yield SearchLoadingState();

      try {
        final searchData = await searchDataProvider.search(event.query);
        yield SearchLoadedState(searchData);
      } catch (error) {
        yield const SearchErrorState('Failed to fetch search results');
      }
    }
  }
}
