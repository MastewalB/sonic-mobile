import 'package:flutter/material.dart';
import 'package:sonic_mobile/features/album/presentation/widgets/audio_list.dart';
import 'package:sonic_mobile/features/search/presentation/widgets/search_bar_widget.dart';
import 'empty_screen.dart';
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
  final TrackingScrollController _trackingScrollController =
      TrackingScrollController();
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
    return BlocBuilder<SearchBloc, SearchState>(builder: (context, state) {
      return Scaffold(
          backgroundColor: Colors.transparent,
          body: NestedScrollView(
              headerSliverBuilder:
                  (BuildContext context, bool innerBoxIsScrolled) {
                return <Widget>[
                  SliverOverlapAbsorber(
                      handle: NestedScrollView.sliverOverlapAbsorberHandleFor(
                          context),
                      sliver: SliverAppBar(
                        title: SearchBarWidget(
                          hintText: 'Songs, Artists, or Albums',
                          backIcon: Icons.arrow_back_rounded,
                          onSubmitted: (String submittedQuery) {
                            // Dispatch the PerformSearchEvent with the submitted query
                            context
                                .read<SearchBloc>()
                                .add(PerformSearchEvent(submittedQuery));
                          },
                        ),
                        backgroundColor: const Color.fromARGB(255, 31, 29, 43),
                        forceElevated: innerBoxIsScrolled,
                        automaticallyImplyLeading: false,
                        expandedHeight: 5.0,
                        flexibleSpace: FlexibleSpaceBar(),
                      )),
                ];
              },
              body: (state is SearchLoadedState)
                  ? ListView(children: [
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
                      )
                    ])
                  : (state is SearchEmptyState)
                      ? nothingFound(context)
                      : (state is SearchErrorState)
                          ? Text(state.errorMessage)
                          : SizedBox()));
    });
  }
}
                  

//               Expanded(
//                 child: Scaffold(
//                   resizeToAvoidBottomInset: false,
//                   backgroundColor: Colors.grey[600],
//                   body: SearchBarWidget(
//                     hintText: 'Songs, Artists, or Albums',
//                     backIcon: Icons.arrow_back_rounded,
//                     onSubmitted: (String submittedQuery) {
//                       // Dispatch the PerformSearchEvent with the submitted query
//                       context
//                           .read<SearchBloc>()
//                           .add(PerformSearchEvent(submittedQuery));
//                     },
//                   ),
//                 ),
//               ),
//               // Display the search result widget based on the state

//               if (state is SearchLoadedState)
//                 Column(
//                   children: [
//                     SearchResultsWidget(
//                       searchType: 'Song',
//                       items: state.searchData[0],
//                     ),
//                     SearchResultsWidget(
//                       searchType: 'Album',
//                       items: state.searchData[1],
//                     ),
//                     SearchResultsWidget(
//                       searchType: 'Artist',
//                       items: state.searchData[2],
//                     ),
//                   ],
//                 )
//               else if (state is SearchEmptyState)
//                 nothingFound(context)
//               else if (state is SearchErrorState)
//                 Text(state.errorMessage),
//             ],
//           ),
//         );
//       },
//     );
//   }
// }
