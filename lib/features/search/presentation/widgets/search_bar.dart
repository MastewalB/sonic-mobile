import 'package:anim_search_bar/anim_search_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'search_view.dart';

class SearchBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: GestureDetector(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const SearchView(
            query: '',
          ),
        ),
      ),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.grey[200],
          borderRadius: BorderRadius.circular(20),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 15),
        margin: const EdgeInsets.fromLTRB(0, 20, 0, 0),
        child: Row(
          children: [
            Icon(Icons.search),
            const SizedBox(width: 8),
            Text('Search'),
          ],
        ),
      ),
    ));

    // );
    // return GestureDetector(
    //   child: Padding(
    //     padding: const EdgeInsets.fromLTRB(20.0, 80.0, 20.0, 0),
    //     child: Row(
    //       // mainAxisAlignment: MainAxisAlignment.center,
    //       // crossAxisAlignment: CrossAxisAlignment.center,
    //       children: [
    //         const SizedBox(
    //           width: 10.0,
    //         ),
    //         Icon(
    //           CupertinoIcons.search,
    //           color: Theme.of(context).colorScheme.secondary,
    //         ),
    //         const SizedBox(
    //           width: 10.0,
    //         ),
    //         Text(
    //           // AppLocalizations.of(
    //           //   context,
    //           // )!
    //           //     .searchText,
    //           'To Search',
    //           style: TextStyle(
    //             fontSize: 16.0,
    //             color: Theme.of(context).textTheme.bodySmall!.color,
    //             fontWeight: FontWeight.normal,
    //           ),
    //         ),
    //       ],
    //     ),
    //   ),
    //   onTap: () => Navigator.push(
    //     context,
    //     MaterialPageRoute(
    //       builder: (context) => const SearchView(
    //         query: '',
    //       ),
    //     ),
    //   ),
    // );
  }
}


// class App extends StatefulWidget {
//   @override
//   _AppState createState() => _AppState();
// }

// class _AppState extends State<App> {
//   TextEditingController textController = TextEditingController();

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.only(top: 58.0, right: 10, left: 10),

//       /// In AnimSearchBar widget, the width, textController, onSuffixTap are required properties.
//       /// You have also control over the suffixIcon, prefixIcon, helpText and animationDurationInMilli
//       child: AnimSearchBar(
//         width: 400,
//         textController: textController,
//         onSuffixTap: () {
//           setState(() {
//             textController.clear();
//           });
//         },
//         onSubmitted: (String) {},
//       ),
//     );
//   }
// }
