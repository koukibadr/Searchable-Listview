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
    this.searchMode = SearchMode.onEdit,
    this.emptyWidget = const SizedBox.shrink(),
    this.textInputType = TextInputType.text,
    this.obscureText = false,
    this.focusNode,
    this.searchFieldEnabled = true,
    this.onItemSelected,
    this.displayClearIcon = true,
    this.defaultSuffixIconColor = Colors.grey,
    this.onRefresh,
    this.sliverScrollEffect = false,
    this.displayDividder = false,
  }) : super(key: key) {
    searchTextController ??= TextEditingController();
    if (sliverScrollEffect && onRefresh != null) {
      throw ("sliverScrollEffect will disable the pull-to-refresh effect, remove sliverScrollEffect or pulltToRefresh");
    }
  }

  /// Initial list of all elements that will be displayed.
  late List<T> initialList;

  /// Callback to filter the list based on the given search value.
  ///
  /// Invoked on changing the text field search if ```searchType == SEARCH_TYPE.onEdit```
  /// or invoked when submiting the text field if ```searchType == SEARCH_TYPE.onSubmit```.
  ///
  /// You should return a list of filtered elements.
  final List<T> Function(String) filter;

  /// Builder function that generates the ListView items
  /// based on the given element.
  final Widget Function(T) builder;

  /// The widget to be displayed when the filter returns an empty list.
  ///
  /// Defaults to `const SizedBox.shrink()`.
  final Widget emptyWidget;

  /// Text editing controller applied on the search field.
  ///
  /// Defaults to null.
  late TextEditingController? searchTextController;

  /// The keyboard action key
  ///
  /// Defaults to [TextInputAction.done].
  final TextInputAction keyboardAction;

  /// The text field input decoration
  ///
  /// Defaults to null.
  final InputDecoration? inputDecoration;

  /// The style for the input text field
  ///
  /// Defaults to null.
  final TextStyle? style;

  /// The keyboard text input type
  ///
  /// Defaults to [TextInputType.text]
  final TextInputType textInputType;

  /// Callback function invoked when submiting the search text field
  final Function(String?)? onSubmitSearch;

  /// The search type on submiting text field or when changing the text field value
  ///```dart
  ///SEARCH_TYPE.onEdit,
  ///SEARCH_TYPE.onSubmit
  ///```
  ///
  /// Defaults to [SearchMode.onEdit].
  final SearchMode searchMode;

  /// Indicate whether the text field input should be obscured or not.
  /// Defaults to `false`.
  final bool obscureText;

  /// Indicate if the search text field is enabled or not.
  /// Defaults to `true`.
  final bool searchFieldEnabled;

  /// The focus node applied on the search text field
  final FocusNode? focusNode;

  /// Function invoked when pressing on item
  /// Defaults to null
  final void Function(T)? onItemSelected;

  /// Indicate whether the clear icon will be displayed or not
  /// by default it's true, to display the clear icon the inputDecoration should not contains suffix icon
  /// otherwise the initial suffix icon will be displayed
  final bool displayClearIcon;

  /// The color applied on the suffix icon (if `displayClearIcon = true`).
  /// Defaults to [Colors.grey].
  final Color defaultSuffixIconColor;

  ///An async callback invoked when dragging down the list
  ///if onRefresh is nullable the drag to refresh is not applied
  final Future<void> Function()? onRefresh;

  ///indicates whether the ssliver scroll effect will be applied
  ///on the listview and search field or not
  ///by default sliverScrollEffect == [false]
  final bool sliverScrollEffect;

  final bool displayDividder;

  @override
  State<SearchableList> createState() => _SearchableListState<T>();
}

class _SearchableListState<T> extends State<SearchableList<T>> {
  @override
  Widget build(BuildContext context) {
    return widget.sliverScrollEffect
        ? _renderSliverEffect()
        : Column(
            children: [
              _renderSearchField(),
              const SizedBox(
                height: 20,
              ),
              _renderListView()
            ],
          );
  }

  Widget _renderListView() {
    if (widget.initialList.isEmpty) {
      return widget.emptyWidget;
    } else {
      return Expanded(
        child: widget.onRefresh != null
            ? RefreshIndicator(
                onRefresh: widget.onRefresh!,
                child: ListView.separated(
                  itemCount: widget.initialList.length,
                  itemBuilder: (context, index) => _renderListItem(index),
                  separatorBuilder: (ctx, index) {
                    return widget.displayDividder
                        ? const SizedBox()
                        : const Divider();
                  },
                ),
              )
            : ListView.separated(
                itemCount: widget.initialList.length,
                itemBuilder: (context, index) => _renderListItem(index),
                separatorBuilder: (ctx, index) {
                  return widget.displayDividder
                      ? const SizedBox()
                      : const Divider();
                },
              ),
      );
    }
  }

  Widget _renderSliverEffect() {
    return CustomScrollView(
      slivers: [
        SliverAppBar(
          backgroundColor: Colors.transparent,
          flexibleSpace: _renderSearchField(),
        ),
        SliverList(
          delegate: widget.initialList.isEmpty
              ? SliverChildBuilderDelegate(
                  (context, index) => widget.emptyWidget,
                  childCount: 1,
                )
              : SliverChildBuilderDelegate(
                  (context, index) => _renderListItem(index),
                  childCount: widget.initialList.length,
                ),
        )
      ],
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

  Widget _renderSearchField() {
    return TextField(
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
        if (widget.searchMode == SearchMode.onSubmit) {
          _filterList(value);
        }
      },
      onChanged: (value) {
        if (widget.searchMode == SearchMode.onEdit) {
          _filterList(value);
        }
      },
    );
  }

  Widget _renderListItem(index) {
    return widget.onItemSelected == null
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
          );
  }

  void _filterList(String value) {
    setState(
      () {
        widget.initialList = widget.filter(value);
      },
    );
  }
}
