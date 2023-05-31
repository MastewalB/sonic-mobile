import 'package:flutter/material.dart';
import 'package:sonic_mobile/features/album/presentation/widgets/audio_list.dart';
import 'empty_screen.dart';
import 'search_bar_2.dart';
import 'results_view.dart';
import 'package:sonic_mobile/features/search/repository/http_search.dart';

class SearchView extends StatefulWidget {
  final String query;
  final bool autofocus;
  const SearchView({
    super.key,
    required this.query,
    this.autofocus = false,
  });

  @override
  _SearchViewState createState() => _SearchViewState();
}

class _SearchViewState extends State<SearchView> {
  String query = '';
  bool status = false;
  Map searchedData = {};
  bool fetched = false;
  bool alertShown = false;

  List search = [];
  bool liveSearch = true;

  final controller = TextEditingController();

  @override
  void initState() {
    controller.text = widget.query;
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  // Future<void> fetchResults() async {
  //   // this fetches top 5 songs results
  //   final Map result = await SaavnAPI().fetchSongSearchResults(
  //     searchQuery: query == '' ? widget.query : query,
  //     count: 5,
  //   );
  //   final List songResults = result['songs'] as List;
  //   if (songResults.isNotEmpty) searchedData['Songs'] = songResults;
  //   fetched = true;
  //   // this fetches albums, playlists, artists, etc
  //   final List<Map> value =
  //       await SaavnAPI().fetchSearchResults(query == '' ? widget.query : query);

  //   searchedData.addEntries(value[0].entries);
  //   position = value[1];
  //   sortedKeys = position.keys.toList()..sort();
  //   albumFetched = true;
  //   setState(
  //     () {},
  //   );
  // }

  // Future<void> getTrendingSearch() async {
  //   topSearch.value = await SaavnAPI().getTopSearches();
  // }

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

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          Expanded(
            child: Scaffold(
              resizeToAvoidBottomInset: false,
              backgroundColor: Colors.transparent,
              body: SearchBar2(
                controller: controller,
                liveSearch: liveSearch,
                autofocus: widget.autofocus,
                hintText: 'Songs, Artists, or Albums',
                leading: IconButton(
                  icon: const Icon(Icons.arrow_back_rounded),
                  onPressed: () => Navigator.pop(context),
                ),
                body: (searchedData.isEmpty)
                    ? nothingFound(context)
                    : SearchResultsWidget(searchType: 'Song', items: const []),
                //to do
                onSubmitted: (String submittedQuery) {
                  setState(
                    () {
                      fetched = false;
                      query = submittedQuery;
                      status = false;
                      searchedData = {};
                    },
                  );
                },
                onQueryCleared: () {
                  setState(() {});
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
