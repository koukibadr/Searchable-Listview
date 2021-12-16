import 'package:flutter/material.dart';

class SearchableList<T> extends StatefulWidget {
  final List<T> initialList;
  final Function(String) filter;
  final Widget Function(int) builder;

  const SearchableList({
    Key? key,
    required this.initialList,
    required this.filter,
    required this.builder,
  }) : super(key: key);

  @override
  State<SearchableList> createState() => _SearchableListState<T>();
}

class _SearchableListState<T> extends State<SearchableList> {
  late List<T> displayedList = widget.initialList as List<T>;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextField(
          onChanged: (value) {
            setState(
              () {
                displayedList = widget.filter(value);
              },
            );
          },
        ),
        Expanded(
          child: ListView.builder(
            itemCount: displayedList.length,
            itemBuilder: (context, index) => widget.builder(
              index,
            ),
          ),
        )
      ],
    );
  }
}
