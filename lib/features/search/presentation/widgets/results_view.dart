import 'package:flutter/material.dart';
import 'dart:math';

class SearchResultsWidget<T> extends StatelessWidget {
  final String searchType;
  final List<T> items;
  final int count;

  const SearchResultsWidget({
    super.key,
    required this.searchType,
    required this.items,
  }) : count = items.length;

  @override
  Widget build(BuildContext context) {
    // print(items);
    String getTitle(inpt) {
      var inp = inpt['data'];
      if (searchType == 'Song') {
        return inp['title'] as String;
      } else if (searchType == 'Artist') {
        return inp['name'] as String;
      } else if (searchType == 'Album') {
        return inp['name'] as String;
      }
      return ''; // Default value
    }

    String getImageUrl(inpt) {
      var inp = inpt['data'];
      if (searchType == 'Song') {
        // print('the input');
        // print(inp);
        return inp['s_album']['cover'] as String;
      } else if (searchType == 'Artist') {
        return inp['picture'] as String;
      } else if (searchType == 'Album') {
        return inp['cover'] as String;
      }
      return ''; // Default value
    }

    String getSubtitle(inpt) {
      var inp = inpt['data'];
      if (searchType == 'Song') {
        return inp['s_artist']['name'] as String;
      } else if (searchType == 'Album') {
        return inp['artist']['name'] as String;
      }
      return '';
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: 55,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Search results for $searchType', // Display the search type
                style: const TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              TextButton(
                onPressed: () {
                  // Handle the view all button action
                },
                child: const Text(
                  'View All',
                  style: TextStyle(
                    fontSize: 16.0,
                    color: Colors.blue,
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 8.0),
        ListView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemCount: min(items.length, 5),
          itemBuilder: (BuildContext context, int index) {
            final item = items[index]; // Get the item at the current index

            return Material(
              child: ListTile(
                leading: Container(
                  height: 50.0,
                  width: 50.0,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: NetworkImage(
                        getImageUrl(item),
                      ),
                    ),
                  ),
                ),
                title: Text(
                  getTitle(item), // Display the item
                  style: const TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                subtitle: Text(
                  getSubtitle(item),
                  style: TextStyle(
                    fontSize: 14.0,
                    color: Colors.grey[600],
                  ),
                ),
                onTap: () {
                  // Handle the result tap action
                },
              ),
            );
          },
        ),
      ],
    );
  }
}
