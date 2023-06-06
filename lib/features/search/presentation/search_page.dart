import 'package:flutter/material.dart';
import 'package:sonic_mobile/features/search/presentation/widgets/search_bar.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
        backgroundColor: Color.fromARGB(255, 31, 29, 43),
        body: SafeArea(child: SearchBar()));

    // return Scaffold(
    //   appBar: AppBar(
    //     title: Text('Music Player'),
    //   ),
    //   body: Container(
    //     margin: EdgeInsets.all(16.0), // set margin for the container
    //     child: Column(
    //       crossAxisAlignment: CrossAxisAlignment.stretch,
    //       children: [
    //         Container(
    //           padding: EdgeInsets.all(8.0), // set padding for the container
    //           child: TextField(
    //             decoration: InputDecoration(
    //               hintText: 'Search for songs or podcasts',
    //               prefixIcon: Icon(Icons.search),
    //               border: OutlineInputBorder(
    //                 borderRadius: BorderRadius.circular(16.0),
    //               ),
    //             ),
    //           ),
    //         ),
    //         SizedBox(
    //             height:
    //                 16.0), // add some spacing between the search bar and the next widget
    //         Text(
    //           'Recommended',
    //           style: TextStyle(
    //             fontSize: 24.0,
    //             fontWeight: FontWeight.bold,
    //           ),
    //         ),
    //         // add more widgets here
    //       ],
    //     ),
    //   ),
    // );
  }
}