// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:searchable_listview/resources/arrays.dart';
import 'package:searchable_listview/widgets/list_item.dart';
import 'package:searchable_listview/widgets/serach_text_field.dart';

class SearchableList<T> extends StatefulWidget {
  ///indicates whether the ssliver scroll effect will be applied
  ///on the listview and search field or not
  ///by default sliverScrollEffect == [false]
  bool sliverScrollEffect = false;

  ///indicate if the divider will be displayed or not
  ///if true the listview will be rendered with [ListView.separated] constructor
  bool displayDividder = false;

  SearchableList({
    Key? key,
    this.initialList,
    this.asyncListCallback,
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
    this.scrollDirection = Axis.vertical,
    this.searchTextPosition = SearchTextPosition.top,
    this.onPaginate,
  }) : super(key: key) {
    if(asyncListCallback == null && initialList == null){
      throw('either initialList or asyncListCallback must be provided');
    }
    searchTextController ??= TextEditingController();
    seperatorBuilder = null;
  }

  SearchableList.sliver({
    Key? key,
    this.initialList,
    this.asyncListCallback,
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
    this.scrollDirection = Axis.vertical,
    this.searchTextPosition = SearchTextPosition.top,
    this.onPaginate,
  }) : super(key: key) {
    if(asyncListCallback == null && initialList == null){
      throw('either initialList or asyncListCallback must be provided');
    }
    searchTextController ??= TextEditingController();
    seperatorBuilder = null;
    sliverScrollEffect = true;
    onRefresh = null;
  }

  SearchableList.seperated({
    Key? key,
    required this.initialList,
    required this.filter,
    required this.builder,
    required this.seperatorBuilder,
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
    this.displayDividder = false,
    this.onRefresh,
    this.scrollDirection = Axis.vertical,
    this.searchTextPosition = SearchTextPosition.top,
    this.onPaginate,
  }) : super(key: key) {
    searchTextController ??= TextEditingController();
    displayDividder = true;
    assert(seperatorBuilder != null);
  }

  /// Initial list of all elements that will be displayed.
  List<T>? initialList;

  Future<List<T>>? asyncListCallback;

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
  late Future<void> Function()? onRefresh;

  ///Builder callback required  when using [seperated] constructor
  ///return the Widget that will seperate all the elements inside the list
  late Widget Function(BuildContext, int)? seperatorBuilder;

  ///The scroll direction of the list
  ///by default [Axis.vertical]
  final Axis scrollDirection;

  ///The position of the text field (bottom or top)
  ///by default the textfield is displayed on top
  final SearchTextPosition searchTextPosition;

  ///Callback function invoked each time the listview
  ///reached the bottom
  ///used to create pagination in listview
  final Future<dynamic> Function()? onPaginate;

  @override
  State<SearchableList> createState() => _SearchableListState<T>();
}

class _SearchableListState<T> extends State<SearchableList<T>> {
  ///create scroll controller instance
  ///attached to the listview widget
  ScrollController scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    if (widget.onPaginate != null) {
      scrollController.addListener(() {
        if (scrollController.position.pixels ==
            scrollController.position.maxScrollExtent) {
          widget.onPaginate?.call();
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return widget.sliverScrollEffect
        ? _renderSliverEffect()
        : Column(
            children: widget.searchTextPosition == SearchTextPosition.top
                ? [
                    SearchTextField(
                      filterList: _filterList,
                      focusNode: widget.focusNode,
                      inputDecoration: widget.inputDecoration,
                      keyboardAction: widget.keyboardAction,
                      obscureText: widget.obscureText,
                      onSubmitSearch: widget.onSubmitSearch,
                      searchFieldEnabled: widget.searchFieldEnabled,
                      searchMode: widget.searchMode,
                      searchTextController: widget.searchTextController,
                      textInputType: widget.textInputType,
                      displayClearIcon: widget.displayClearIcon,
                      defaultSuffixIconColor: widget.defaultSuffixIconColor,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    _renderListView(),
                  ]
                : [
                    _renderListView(),
                    const SizedBox(
                      height: 20,
                    ),
                    SearchTextField(
                      filterList: _filterList,
                      focusNode: widget.focusNode,
                      inputDecoration: widget.inputDecoration,
                      keyboardAction: widget.keyboardAction,
                      obscureText: widget.obscureText,
                      onSubmitSearch: widget.onSubmitSearch,
                      searchFieldEnabled: widget.searchFieldEnabled,
                      searchMode: widget.searchMode,
                      searchTextController: widget.searchTextController,
                      textInputType: widget.textInputType,
                      displayClearIcon: widget.displayClearIcon,
                      defaultSuffixIconColor: widget.defaultSuffixIconColor,
                    ),
                  ],
          );
  }

  ///creates listview based on the items passed to the widget
  ///check whether the [widget.onRefresh] parameter is nullable or not
  ///if [widget.displayDividder] is true
  /// function will runder [ListView.separated]
  ///else the function will render a normal listview [ListView.builder]
  Widget _renderListView() {
    if (widget.initialList!.isEmpty) {
      return widget.emptyWidget;
    } else {
      return Expanded(
        child: widget.onRefresh != null
            ? RefreshIndicator(
                triggerMode: RefreshIndicatorTriggerMode.onEdge,
                onRefresh: widget.onRefresh!,
                child: widget.displayDividder
                    ? _renderSeperatedListView()
                    : ListView.builder(
                        controller: scrollController,
                        scrollDirection: widget.scrollDirection,
                        itemCount: widget.initialList!.length,
                        itemBuilder: (context, index) => ListItem<T>(
                          builder: widget.builder,
                          item: widget.initialList![index],
                          onItemSelected: widget.onItemSelected,
                        ),
                      ),
              )
            : widget.displayDividder
                ? _renderSeperatedListView()
                : ListView.builder(
                    controller: scrollController,
                    scrollDirection: widget.scrollDirection,
                    itemCount: widget.initialList!.length,
                    itemBuilder: (context, index) => ListItem<T>(
                      builder: widget.builder,
                      item: widget.initialList![index],
                      onItemSelected: widget.onItemSelected,
                    ),
                  ),
      );
    }
  }

  ///renders a seperated listview using [ListView.separated]
  Widget _renderSeperatedListView() {
    return ListView.separated(
      controller: scrollController,
      scrollDirection: widget.scrollDirection,
      itemCount: widget.initialList!.length,
      itemBuilder: (context, index) => ListItem<T>(
        builder: widget.builder,
        item: widget.initialList![index],
        onItemSelected: widget.onItemSelected,
      ),
      separatorBuilder: widget.seperatorBuilder!,
    );
  }

  ///render sliver listview
  ///if [widget.scrollDirection] set to [Axis.horizontal]
  ///the function will render an horizontal sliver listview
  ///else it will render a vertical listview
  Widget _renderSliverEffect() {
    return widget.scrollDirection == Axis.horizontal
        ? Column(
            children: widget.searchTextPosition == SearchTextPosition.top
                ? [
                    SearchTextField(
                      filterList: _filterList,
                      focusNode: widget.focusNode,
                      inputDecoration: widget.inputDecoration,
                      keyboardAction: widget.keyboardAction,
                      obscureText: widget.obscureText,
                      onSubmitSearch: widget.onSubmitSearch,
                      searchFieldEnabled: widget.searchFieldEnabled,
                      searchMode: widget.searchMode,
                      searchTextController: widget.searchTextController,
                      textInputType: widget.textInputType,
                      displayClearIcon: widget.displayClearIcon,
                      defaultSuffixIconColor: widget.defaultSuffixIconColor,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Expanded(
                      child: CustomScrollView(
                        scrollDirection: widget.scrollDirection,
                        controller: scrollController,
                        slivers: [
                          SliverList(
                            delegate: widget.initialList!.isEmpty
                                ? SliverChildBuilderDelegate(
                                    (context, index) => widget.emptyWidget,
                                    childCount: 1,
                                  )
                                : SliverChildBuilderDelegate(
                                    (context, index) => ListItem<T>(
                                      builder: widget.builder,
                                      item: widget.initialList![index],
                                      onItemSelected: widget.onItemSelected,
                                    ),
                                    childCount: widget.initialList!.length,
                                  ),
                          )
                        ],
                      ),
                    ),
                  ]
                : [
                    Expanded(
                      child: CustomScrollView(
                        scrollDirection: widget.scrollDirection,
                        controller: scrollController,
                        slivers: [
                          SliverList(
                            delegate: widget.initialList!.isEmpty
                                ? SliverChildBuilderDelegate(
                                    (context, index) => widget.emptyWidget,
                                    childCount: 1,
                                  )
                                : SliverChildBuilderDelegate(
                                    (context, index) => ListItem<T>(
                                      builder: widget.builder,
                                      item: widget.initialList![index],
                                      onItemSelected: widget.onItemSelected,
                                    ),
                                    childCount: widget.initialList!.length,
                                  ),
                          )
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    SearchTextField(
                      filterList: _filterList,
                      focusNode: widget.focusNode,
                      inputDecoration: widget.inputDecoration,
                      keyboardAction: widget.keyboardAction,
                      obscureText: widget.obscureText,
                      onSubmitSearch: widget.onSubmitSearch,
                      searchFieldEnabled: widget.searchFieldEnabled,
                      searchMode: widget.searchMode,
                      searchTextController: widget.searchTextController,
                      textInputType: widget.textInputType,
                      displayClearIcon: widget.displayClearIcon,
                      defaultSuffixIconColor: widget.defaultSuffixIconColor,
                    ),
                  ],
          )
        : CustomScrollView(
            scrollDirection: widget.scrollDirection,
            slivers: widget.searchTextPosition == SearchTextPosition.top
                ? [
                    SliverAppBar(
                      backgroundColor: Colors.transparent,
                      flexibleSpace: SearchTextField(
                        filterList: _filterList,
                        focusNode: widget.focusNode,
                        inputDecoration: widget.inputDecoration,
                        keyboardAction: widget.keyboardAction,
                        obscureText: widget.obscureText,
                        onSubmitSearch: widget.onSubmitSearch,
                        searchFieldEnabled: widget.searchFieldEnabled,
                        searchMode: widget.searchMode,
                        searchTextController: widget.searchTextController,
                        textInputType: widget.textInputType,
                        displayClearIcon: widget.displayClearIcon,
                        defaultSuffixIconColor: widget.defaultSuffixIconColor,
                      ),
                    ),
                    SliverList(
                      delegate: widget.initialList!.isEmpty
                          ? SliverChildBuilderDelegate(
                              (context, index) => widget.emptyWidget,
                              childCount: 1,
                            )
                          : SliverChildBuilderDelegate(
                              (context, index) => ListItem<T>(
                                builder: widget.builder,
                                item: widget.initialList![index],
                                onItemSelected: widget.onItemSelected,
                              ),
                              childCount: widget.initialList!.length,
                            ),
                    )
                  ]
                : [
                    SliverList(
                      delegate: widget.initialList!.isEmpty
                          ? SliverChildBuilderDelegate(
                              (context, index) => widget.emptyWidget,
                              childCount: 1,
                            )
                          : SliverChildBuilderDelegate(
                              (context, index) => ListItem<T>(
                                builder: widget.builder,
                                item: widget.initialList![index],
                                onItemSelected: widget.onItemSelected,
                              ),
                              childCount: widget.initialList!.length,
                            ),
                    ),
                    SliverAppBar(
                      backgroundColor: Colors.transparent,
                      flexibleSpace: SearchTextField(
                        filterList: _filterList,
                        focusNode: widget.focusNode,
                        inputDecoration: widget.inputDecoration,
                        keyboardAction: widget.keyboardAction,
                        obscureText: widget.obscureText,
                        onSubmitSearch: widget.onSubmitSearch,
                        searchFieldEnabled: widget.searchFieldEnabled,
                        searchMode: widget.searchMode,
                        searchTextController: widget.searchTextController,
                        textInputType: widget.textInputType,
                        displayClearIcon: widget.displayClearIcon,
                        defaultSuffixIconColor: widget.defaultSuffixIconColor,
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
}
