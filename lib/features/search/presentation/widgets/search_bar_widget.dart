import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sonic_mobile/features/home/presentation/homepage.dart';
import 'package:sonic_mobile/features/search/bloc/search/blocs.dart';
import 'package:sonic_mobile/features/search/presentation/widgets/search_view.dart';

class SearchBarWidget extends StatefulWidget {
  final String hintText;
  final IconData backIcon;
  final Function(String) onSubmitted;

  const SearchBarWidget({
    Key? key,
    required this.hintText,
    required this.backIcon,
    required this.onSubmitted,
  }) : super(key: key);

  @override
  _SearchBarWidgetState createState() => _SearchBarWidgetState();
}

class _SearchBarWidgetState extends State<SearchBarWidget> {
  late TextEditingController _textEditingController;
  Timer? _debounceTimer;

  @override
  void initState() {
    super.initState();
    _textEditingController = TextEditingController();
  }

  @override
  void dispose() {
    _textEditingController.dispose();
    _debounceTimer?.cancel();
    super.dispose();
  }

  void _onTextChanged(String value) {
    _debounceTimer?.cancel();
    _debounceTimer = Timer(const Duration(seconds: 2), () {
      // Perform live searching here

      print('Live searching: $value');
      context.read<SearchBloc>().add(SearchQueryChangedEvent(query: value));
    });
  }

  void _onSubmitted(String value) {
    _debounceTimer?.cancel();
    final searchBloc = context.read<SearchBloc>();

    // Dispatch the PerformSearchEvent to the search bloc
    searchBloc.add(PerformSearchEvent(value));

    // Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(20.0),
      ),
      child: Row(
        children: [
          IconButton(
            icon: Icon(widget.backIcon),
            onPressed: () {
              Navigator.pushReplacementNamed(context, SearchView.routeName);
            },
          ),
          Expanded(
            child: TextField(
              controller: _textEditingController,
              onChanged: _onTextChanged,
              onSubmitted: _onSubmitted,
              decoration: InputDecoration(
                hintText: widget.hintText,
                border: InputBorder.none,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
