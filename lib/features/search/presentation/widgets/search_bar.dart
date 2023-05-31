// import 'package:anim_search_bar/anim_search_bar.dart';
// import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'search_view.dart';

class SearchBar extends StatelessWidget {
  const SearchBar({super.key});

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
          children: const [
            Icon(Icons.search),
            SizedBox(width: 8),
            Text('Search'),
          ],
        ),
      ),
    ));
  }
}
