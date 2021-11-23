import 'package:flutter/material.dart';

class SearchableList extends StatefulWidget {
  final List<Widget> children;
  final Function onSearch;
  final TextEditingController textEditingController;

  const SearchableList({
    Key? key,
    required this.children,
    required this.onSearch,
    required this.textEditingController,
  }) : super(key: key);

  @override
  State<SearchableList> createState() => _SearchableListState();
}

class _SearchableListState extends State<SearchableList> {

  late List displayedList = widget.children;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          TextField(
            controller: widget.textEditingController,
            onChanged: (value){
              setState(() {
                displayedList = widget.onSearch();
              });
            },
          ),
          Expanded(
            child: ListView.builder(
              itemCount: displayedList.length,
              itemBuilder: (context, index) => displayedList[index],
            ),
          )
        ],
      ),
    );
  }
}
