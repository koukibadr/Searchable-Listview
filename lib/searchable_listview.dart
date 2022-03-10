// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:searchable_listview/resources/arrays.dart';

class SearchableList<T> extends StatefulWidget {
  SearchableList({
    Key? key,
    required this.initialList,
    required this.filter,
    required this.builder,
    this.searchTextController,
    this.keyboardAction = TextInputAction.done,
    this.inputDecoration,
    this.style,
    this.onSubmitSearch,
    this.searchType = SEARCH_TYPE.onEdit,
    this.emptyWidget = const SizedBox.shrink(),
    this.textInputType = TextInputType.text,
    this.obscureText = false,
    this.focusNode,
    this.searchFieldEnabled = true,
    this.onItemSelected,
    this.displayClearIcon = true,
    this.defaultSuffixIconColor = Colors.grey,
  }) : super(key: key) {
    searchTextController ??= TextEditingController();
  }

  ///initial list to be displayed which contains all elements
  late List<T> initialList;

  ///Callback filter the list based  on the given search value
  ///
  ///invoked on changing the text field search if ```searchType == SEARCH_TYPE.onEdit```
  ///or invoked when submiting the text field if ```searchType == SEARCH_TYPE.onSubmit```
  ///
  ///return List of dynamic objects
  final List Function(String) filter;

  ///builder function that generate the listview children widget
  ///based on the given object
  final Widget Function(T) builder;

  ///the widget that will be displayed when the filter return an empty list
  ///
  ///by default it's `const SizedBox.shrink()`
  final Widget emptyWidget;

  ///text editing controller applied on the search field
  ///
  ///by default it's null
  late TextEditingController? searchTextController;

  ///the keyboard action key
  ///
  ///by default `TextInputAction.done`
  final TextInputAction keyboardAction;

  ///the text field input decoration
  ///
  ///by default it's null
  final InputDecoration? inputDecoration;

  ///the style for the input text field
  ///
  /// by default it's null
  final TextStyle? style;

  ///the keyboard text input type
  ///
  ///by default it's `TextInputType.text`
  final TextInputType textInputType;

  ///callback function invoked when submiting the search text field
  final Function(String?)? onSubmitSearch;

  ///the search type on submiting text field or when changing the text field value
  ///```dart
  ///SEARCH_TYPË.onEdit,
  ///SEARCH_TYPË.onSubmit
  ///```
  ///
  ///by default it's onEdit
  final SEARCH_TYPE searchType;

  ///indicate whether the text field input is obscure or not
  ///by default  `obscureText = false`
  final bool obscureText;

  ///indicate if the search text field is enabled or not
  ///by default `searchFieldEnabled = true`
  final bool searchFieldEnabled;

  ///the focus node applied on the search text field
  final FocusNode? focusNode;

  ///function invoked when pressing on item
  ///by default it's null
  final void Function<T>(T)? onItemSelected;

  ///indicate whether the clear icon will be displayed or not
  ///by default it's true, to display the clear icon the inputDecoration should not contains suffix icon
  ///otherwise the initial suffix icon will be displayed
  final bool displayClearIcon;

  ///the color applied on the suffix icon (if displayClearIcon = true)
  ///by default the color is grey
  final Color defaultSuffixIconColor;

  @override
  State<SearchableList> createState() => _SearchableListState<T>();
}

class _SearchableListState<T> extends State<SearchableList> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextField(
          focusNode: widget.focusNode,
          enabled: widget.searchFieldEnabled,
          decoration: widget.inputDecoration?.copyWith(
            suffix: widget.inputDecoration?.suffix ?? _renderSuffixIcon(),
          ),
          controller: widget.searchTextController,
          textInputAction: widget.keyboardAction,
          keyboardType: widget.textInputType,
          obscureText: widget.obscureText,
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
        const SizedBox(
          height: 20,
        ),
        widget.initialList.isEmpty
            ? widget.emptyWidget
            : Expanded(
                child: ListView.builder(
                  itemCount: widget.initialList.length,
                  itemBuilder: (context, index) => widget.onItemSelected == null
                      ? widget.builder(
                          widget.initialList[index],
                        )
                      : InkWell(
                          onTap: () {
                            widget.onItemSelected!.call(
                              widget.initialList[index],
                            );
                          },
                          child: widget.builder(
                            widget.initialList[index],
                          ),
                        ),
                ),
              ),
      ],
    );
  }

  void _filterList(String value) {
    setState(
      () {
        widget.initialList = widget.filter(value);
      },
    );
  }

  Widget? _renderSuffixIcon() {
    return !widget.displayClearIcon
        ? null
        : widget.searchTextController!.text.isNotEmpty
            ? InkWell(
                onTap: () {
                  widget.searchTextController!.clear();
                  _filterList(widget.searchTextController!.text);
                },
                child: Icon(
                  Icons.clear,
                  color: widget.defaultSuffixIconColor,
                ),
              )
            : Icon(
                Icons.search,
                color: widget.defaultSuffixIconColor,
              );
  }
}
