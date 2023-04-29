import 'package:flutter/material.dart';

class RootScaffold extends StatefulWidget {
  const RootScaffold({
    Key? key,
    required this.screens,
    required this.icons,
    required this.names,
    this.initialIndex = 0,
    this.floatingActions,
  }) : super(key: key);

  final List<Widget> screens;
  final List<IconData> icons;
  final List<String> names;
  final int initialIndex;
  final List<FloatingActionButton>? floatingActions;

  @override
  State<RootScaffold> createState() => _RootScaffoldState();
}

class _RootScaffoldState extends State<RootScaffold> {
  int _selectedIndex = 0;

  @override
  void initState() {
    _selectedIndex = widget.initialIndex;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    List<BottomNavigationBarItem> bottomNavItems = [];
    for (int i = 0; i < widget.icons.length; i++) {
      bottomNavItems.add(BottomNavigationBarItem(
          icon: Icon(widget.icons[i]), label: widget.names[i]));
    }
    return Scaffold(
      body: IndexedStack(
        index: _selectedIndex,
        children: widget.screens,
      ),
      bottomNavigationBar: BottomNavigationBar(
        elevation: 3,
        currentIndex: _selectedIndex,
        onTap: (index) => setState(() {
          _selectedIndex = index;
        }),
        items: bottomNavItems,
      ),
      floatingActionButton: (widget.floatingActions != null)
          ? widget.floatingActions![_selectedIndex]
          : null,
    );
  }
}
