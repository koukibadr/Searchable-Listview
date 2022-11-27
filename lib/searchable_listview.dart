// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:searchable_listview/resources/arrays.dart';
import 'package:searchable_listview/widgets/default_error_widget.dart';
import 'package:searchable_listview/widgets/list_item.dart';
import 'package:searchable_listview/widgets/serach_text_field.dart';

import 'widgets/default_loading_widget.dart';

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
    this.filter,
    this.asyncListFilter,
    this.loadingWidget,
    this.errorWidget,
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
    this.spaceBetweenSearchAndList = 20,
    this.cursorColor,
    this.maxLines,
    this.maxLength,
    this.textAlign = TextAlign.start,
    this.autoCompleteHints = const [],
  }) : super(key: key) {
    if (asyncListCallback == null && initialList == null) {
      throw ('either initialList or asyncListCallback must be provided');
    }
    assert(
      (asyncListCallback != null && asyncListFilter != null) ||
          (initialList != null && filter != null),
    );
    searchTextController ??= TextEditingController();
    seperatorBuilder = null;
  }

  SearchableList.sliver({
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
    this.scrollDirection = Axis.vertical,
    this.searchTextPosition = SearchTextPosition.top,
    this.onPaginate,
    this.spaceBetweenSearchAndList = 20,
    this.cursorColor,
    this.maxLines,
    this.maxLength,
    this.textAlign = TextAlign.start,
    this.autoCompleteHints = const [],
  }) : super(key: key) {
    assert(initialList != null);
    asyncListCallback = null;
    asyncListFilter = null;
    searchTextController ??= TextEditingController();
    seperatorBuilder = null;
    sliverScrollEffect = true;
    onRefresh = null;
  }

  SearchableList.seperated({
    Key? key,
    this.initialList,
    this.asyncListCallback,
    this.filter,
    this.asyncListFilter,
    this.loadingWidget,
    this.errorWidget,
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
    this.spaceBetweenSearchAndList = 20,
    this.cursorColor,
    this.maxLines,
    this.maxLength,
    this.textAlign = TextAlign.start,
    this.autoCompleteHints = const [],
  }) : super(key: key) {
    if (asyncListCallback == null && initialList == null) {
      throw ('either initialList or asyncListCallback must be provided');
    }
    assert(
      (asyncListCallback != null && asyncListFilter != null) ||
          (initialList != null && filter != null),
    );
    searchTextController ??= TextEditingController();
    displayDividder = true;
    assert(seperatorBuilder != null);
  }

  /// Initial list of all elements that will be displayed.
  ///
  ///when [initialList] is null you need to provide [asyncListCallback]
  ///to filter the [initialList] you need provide [filter] callback
  List<T>? initialList;

  /// Callback to filter the list based on the given search value.
  ///
  /// Invoked on changing the text field search if ```searchType == SEARCH_TYPE.onEdit```
  /// or invoked when submiting the text field if ```searchType == SEARCH_TYPE.onSubmit```.
  ///
  /// You should return a list of filtered elements.
  late List<T> Function(String)? filter;

  ///Async callback that return list to be displayed with future builder
  ///
  ///when [asyncListCallback] is null you need to provide [initialList]
  ///to filter the [asyncListCallback] result you need provide [asyncListFilter]
  Future<List<T>?> Function()? asyncListCallback;

  ///Callback invoked when filtring the searchable list
  ///used when providing [asyncListCallback]
  ///
  ///can't be null when [asyncListCallback] isn't null
  late List<T> Function(String, List<T>)? asyncListFilter;

  ///Loading widget displayed when [asyncListCallback] is loading
  ///
  ///if nothing is provided in [loadingWidget] searchable list will display a [CircularProgressIndicator]
  Widget? loadingWidget;

  ///error widget displayed when [asyncListCallback] result is null
  ///
  ///if nothing is provided in [errorWidget] searchable list will display a [Icon]
  Widget? errorWidget;

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

  ///space between the search textfield and the list
  ///by default the padding is set to 20
  final double spaceBetweenSearchAndList;

  ///cusor color used in the search textfield
  final Color? cursorColor;

  ///max lines attribute used in the search textfield
  final int? maxLines;

  ///max length attribute used in the search field
  final int? maxLength;

  ///the text alignement of the search field
  ///by default the alignement is start
  final TextAlign textAlign;

  ///List of strings  to display in an auto complete field
  ///by default list is empty so a simple text field is displayed
  final List<String> autoCompleteHints;

  @override
  State<SearchableList> createState() => _SearchableListState<T>();
}

class _SearchableListState<T> extends State<SearchableList<T>> {
  ///create scroll controller instance
  ///attached to the listview widget
  ScrollController scrollController = ScrollController();

  List<T> asyncListResult = [];
  List<T> filtredAsyncListResult = [];

  bool dataDownloaded = false;

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
        : widget.asyncListCallback != null
            ? _renderAsyncListView()
            : _renderSearchableListView(
                list: widget.initialList!,
              );
  }

  Widget _renderAsyncListView() {
    return dataDownloaded
        ? _renderSearchableListView(list: filtredAsyncListResult)
        : FutureBuilder(
            future: widget.asyncListCallback!.call(),
            builder: (context, snapshot) {
              dataDownloaded =
                  snapshot.connectionState != ConnectionState.waiting;
              if (!dataDownloaded) {
                return widget.loadingWidget ?? const DefaultLoadingWidget();
              }
              if (snapshot.data == null) {
                return widget.errorWidget ?? const DefaultErrorWidget();
              }
              asyncListResult = snapshot.data as List<T>;
              filtredAsyncListResult = asyncListResult;
              return _renderSearchableListView(list: filtredAsyncListResult);
            },
          );
  }

  Widget _renderSearchableListView({
    required List<T> list,
  }) {
    return Column(
      children: widget.searchTextPosition == SearchTextPosition.top
          ? [
              _renderSearchField(),
              SizedBox(
                height: widget.spaceBetweenSearchAndList,
              ),
              _renderListView(
                list: list,
              ),
            ]
          : [
              _renderListView(
                list: list,
              ),
              SizedBox(
                height: widget.spaceBetweenSearchAndList,
              ),
              _renderSearchField(),
            ],
    );
  }

  ///creates listview based on the items passed to the widget
  ///check whether the [widget.onRefresh] parameter is nullable or not
  ///if [widget.displayDividder] is true
  /// function will runder [ListView.separated]
  ///else the function will render a normal listview [ListView.builder]
  Widget _renderListView({
    required List<T> list,
  }) {
    if (list.isEmpty) {
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
                        itemCount: list.length,
                        itemBuilder: (context, index) => ListItem<T>(
                          builder: widget.builder,
                          item: list[index],
                          onItemSelected: widget.onItemSelected,
                        ),
                      ),
              )
            : widget.displayDividder
                ? _renderSeperatedListView()
                : ListView.builder(
                    controller: scrollController,
                    scrollDirection: widget.scrollDirection,
                    itemCount: list.length,
                    itemBuilder: (context, index) => ListItem<T>(
                      builder: widget.builder,
                      item: list[index],
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
                    _renderSearchField(),
                    SizedBox(
                      height: widget.spaceBetweenSearchAndList,
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
                    SizedBox(
                      height: widget.spaceBetweenSearchAndList,
                    ),
                    _renderSearchField(),
                  ],
          )
        : CustomScrollView(
            scrollDirection: widget.scrollDirection,
            slivers: widget.searchTextPosition == SearchTextPosition.top
                ? [
                    SliverAppBar(
                      backgroundColor: Colors.transparent,
                      flexibleSpace: _renderSearchField(),
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
                      flexibleSpace: _renderSearchField(),
                    ),
                  ],
          );
  }

  void _filterList(String value) {
    setState(
      () {
        if (widget.asyncListCallback != null) {
          filtredAsyncListResult = widget.asyncListFilter!(
            value,
            asyncListResult,
          );
        } else {
          widget.initialList = widget.filter!(value);
        }
      },
    );
  }

  /// render search field widget
  Widget _renderSearchField() {
    return SearchTextField(
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
      textStyle: widget.style,
      cursorColor: widget.cursorColor,
      maxLength: widget.maxLength,
      maxLines: widget.maxLines,
      textAlign: widget.textAlign,
      autoCompleteHints: widget.autoCompleteHints,
    );
  }
}
