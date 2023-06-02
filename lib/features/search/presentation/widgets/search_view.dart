import 'package:flutter/material.dart';
import 'package:sonic_mobile/features/album/presentation/widgets/audio_list.dart';
import 'package:sonic_mobile/features/search/presentation/widgets/search_bar3.dart';
import 'empty_screen.dart';
import 'search_bar_2.dart';
import 'results_view.dart';
import 'package:sonic_mobile/features/search/repository/http_search.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sonic_mobile/features/search/bloc/search/blocs.dart';

class SearchView extends StatefulWidget {
  final String query;
  final bool autofocus;

  const SearchView({
    Key? key,
    required this.query,
    this.autofocus = false,
  }) : super(key: key);

  @override
  _SearchViewState createState() => _SearchViewState();
}

class _SearchViewState extends State<SearchView> {
  late SearchBloc searchBloc; // Add a reference to the SearchBloc

  @override
  void initState() {
    searchBloc = context.read<SearchBloc>(); // Initialize the SearchBloc
    super.initState();
  }

  Widget nothingFound(BuildContext context) {
    return emptyScreen(
      context,
      0,
      ':( ',
      100,
      'SORRY',
      60,
      'Results Not Found',
      20,
    );
  }
  // Rest of the code...

  @override
  Widget build(BuildContext context) {
    // Wrap the body content with a BlocBuilder to listen to state changes
    return BlocBuilder<SearchBloc, SearchState>(
      builder: (context, state) {
        return SafeArea(
          child: Column(
            children: [
              Expanded(
                child: Scaffold(
                  resizeToAvoidBottomInset: false,
                  backgroundColor: Colors.transparent,
                  body: SearchBarWidget(
                    hintText: 'Songs, Artists, or Albums',
                    backIcon: Icons.arrow_back_rounded,
                    onSubmitted: (String submittedQuery) {
                      // Dispatch the PerformSearchEvent with the submitted query
                      context
                          .read<SearchBloc>()
                          .add(PerformSearchEvent(submittedQuery));
                    },
                  ),
                ),
              ),
              // Display the search result widget based on the state

              if (state is SearchLoadedState)
                Column(
                  children: [
                    SearchResultsWidget(
                      searchType: 'Song',
                      items: state.searchData[0],
                    ),
                    SearchResultsWidget(
                      searchType: 'Album',
                      items: state.searchData[1],
                    ),
                    SearchResultsWidget(
                      searchType: 'Artist',
                      items: state.searchData[2],
                    ),
                  ],
                )
              else if (state is SearchEmptyState)
                nothingFound(context)
              else if (state is SearchErrorState)
                Text(state.errorMessage),
            ],
          ),
        );
      },
    );
  }
}
