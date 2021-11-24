import 'package:flutter/material.dart';

class SearchableList<T> extends StatefulWidget {
  final List<T> initialList;
  final Function(String) filter;
  final Function(T) builder;

  const SearchableList({
    Key? key,
    required this.initialList,
    required this.filter,
    required this.builder,
  }) : super(key: key);

  @override
  State<SearchableList> createState() => _SearchableListState();
}

class _SearchableListState extends State<SearchableList> {

  late List displayedList = widget.initialList;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextField(
          onChanged: (value){
            setState(() {
              displayedList = widget.filter(value);
            });
          },
        ),
        Expanded(
          child: ListView.builder(
            itemCount: displayedList.length,
            itemBuilder: (context, index) => widget.builder(displayedList[index]),
          ),
        )
      ],
    );
  }
}
