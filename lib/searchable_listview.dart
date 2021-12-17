import 'package:flutter/material.dart';
import 'package:searchable_listview/resources/arrays.dart';

class SearchableList<T> extends StatefulWidget {
  final List<T> initialList;
  final Function(String) filter;
  final Widget Function(dynamic) builder;
  final TextEditingController? searchTextController;
  final TextInputAction keyboardAction;
  final InputDecoration? inputDecoration;
  final Function(String?)? onSubmitSearch;
  final SEARCH_TYPE searchType;
  final Widget emptyWidget;

  const SearchableList({
    Key? key,
    required this.initialList,
    required this.filter,
    required this.builder,
    this.searchTextController,
    this.keyboardAction = TextInputAction.done,
    this.inputDecoration,
    this.onSubmitSearch,
    this.searchType = SEARCH_TYPE.onEdit,
    this.emptyWidget = const SizedBox.shrink(),
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
          decoration: widget.inputDecoration,
          controller: widget.searchTextController,
          textInputAction: widget.keyboardAction,
          onSubmitted: (value) {
            widget.onSubmitSearch?.call(value);
            if (widget.searchType == SEARCH_TYPE.onSubmit) {
              _filterList(value);
            }
          },
          onChanged: (value) {
            if (widget.searchType == SEARCH_TYPE.onEdit) {
              _filterList(value);
            }
          },
        ),
        displayedList.isEmpty
            ? widget.emptyWidget
            : Expanded(
                child: ListView.builder(
                  itemCount: displayedList.length,
                  itemBuilder: (context, index) => widget.builder(displayedList[index]),
                ),
              ),
      ],
    );
  }

  void _filterList(String value) {
    setState(
      () {
        displayedList = widget.filter(value);
      },
    );
  }
}
