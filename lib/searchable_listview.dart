// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:searchable_listview/resources/arrays.dart';
import 'package:searchable_listview/widgets/default_error_widget.dart';
import 'package:searchable_listview/widgets/default_loading_widget.dart';
import 'package:searchable_listview/widgets/list_item.dart';
import 'package:searchable_listview/widgets/search_text_field.dart';

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
    required this.initialList,
    required this.itemBuilder,
    this.filter,
    this.loadingWidget,
    this.errorWidget,
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
    this.searchFieldWidth,
    this.searchFieldHeight,
    this.onItemSelected,
    this.displayClearIcon = true,
    this.displaySearchIcon = true,
    this.defaultSuffixIconColor = Colors.grey,
    this.defaultSuffixIconSize = 24,
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
    this.secondaryWidget,
    this.physics,
    this.shrinkWrap = false,
    this.itemExtent,
    this.listViewPadding,
    this.reverse = false,
    this.sortPredicate,
    this.sortWidget,
    this.seperatorBuilder,
    this.scrollController,
    this.closeKeyboardWhenScrolling = false,
  }) : super(key: key) {
    searchTextController ??= TextEditingController();
    expansionListBuilder = null;
    asyncListCallback = null;
    asyncListFilter = null;
    if (sortWidget != null) {
      assert(sortPredicate != null);
    }
  }

  SearchableList.async({
    Key? key,
    required this.asyncListCallback,
    required this.asyncListFilter,
    required this.itemBuilder,
    this.loadingWidget,
    this.errorWidget,
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
    this.searchFieldWidth,
    this.searchFieldHeight,
    this.onItemSelected,
    this.displayClearIcon = true,
    this.displaySearchIcon = true,
    this.defaultSuffixIconColor = Colors.grey,
    this.defaultSuffixIconSize = 24,
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
    this.secondaryWidget,
    this.physics,
    this.shrinkWrap = false,
    this.itemExtent,
    this.listViewPadding,
    this.reverse = false,
    this.seperatorBuilder,
    this.sortPredicate,
    this.sortWidget,
    this.scrollController,
    this.closeKeyboardWhenScrolling = false,
  }) : super(key: key) {
    assert(asyncListCallback != null);
    searchTextController ??= TextEditingController();
    expansionListBuilder = null;
    initialList = [];
    filter = null;
    if (sortWidget != null) {
      assert(sortPredicate != null);
    }
  }

  SearchableList.expansion({
    Key? key,
    required this.expansionListData,
    required this.expansionTitleBuilder,
    required this.filterExpansionData,
    required this.expansionListBuilder,
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
    this.searchFieldWidth,
    this.searchFieldHeight,
    this.onItemSelected,
    this.displayClearIcon = true,
    this.displaySearchIcon = true,
    this.defaultSuffixIconColor = Colors.grey,
    this.defaultSuffixIconSize = 24,
    this.spaceBetweenSearchAndList = 20,
    this.cursorColor,
    this.maxLines,
    this.maxLength,
    this.textAlign = TextAlign.start,
    this.autoCompleteHints = const [],
    this.secondaryWidget,
    this.physics,
    this.shrinkWrap = false,
    this.itemExtent,
    this.listViewPadding,
    this.reverse = false,
    this.scrollController,
    this.closeKeyboardWhenScrolling = false,
    this.hideEmptyExpansionItems = false,
    this.expansionTileEnabled = true,
    this.sortWidget,
    this.sortPredicate,
  }) : super(key: key) {
    searchTextController ??= TextEditingController();
    seperatorBuilder = null;
    isExpansionList = true;
    //! use itemBuiler instead of expansionTitleBuilder and expansionListBuilder
    itemBuilder = null;
    initialList = [];
    if (sortWidget != null) {
      assert(sortPredicate != null);
    }
  }

  SearchableList.sliver({
    Key? key,
    required this.initialList,
    this.filter,
    required this.itemBuilder,
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
    this.searchFieldWidth,
    this.searchFieldHeight,
    this.onItemSelected,
    this.displayClearIcon = true,
    this.displaySearchIcon = true,
    this.defaultSuffixIconColor = Colors.grey,
    this.defaultSuffixIconSize = 24,
    this.scrollDirection = Axis.vertical,
    this.searchTextPosition = SearchTextPosition.top,
    this.onPaginate,
    this.spaceBetweenSearchAndList = 20,
    this.cursorColor,
    this.maxLines,
    this.maxLength,
    this.textAlign = TextAlign.start,
    this.autoCompleteHints = const [],
    this.secondaryWidget,
    this.physics,
    this.scrollController,
    this.closeKeyboardWhenScrolling = false,
    this.sortWidget,
    this.sortPredicate,
  }) : super(key: key) {
    asyncListCallback = null;
    asyncListFilter = null;
    searchTextController ??= TextEditingController();
    seperatorBuilder = null;
    sliverScrollEffect = true;
    onRefresh = null;
    shrinkWrap = false;
    itemExtent = null;
    listViewPadding = null;
    this.reverse = false;
    expansionListBuilder = null;
    if (sortWidget != null) {
      assert(sortPredicate != null);
    }
  }

  /// Initial list of all elements that will be displayed.
  ///to filter the [initialList] you need provide [filter] callback
  late List<T> initialList;

  /// Callback to filter the list based on the given search value.
  /// Invoked on changing the text field search if ```searchType == SEARCH_TYPE.onEdit```
  /// or invoked when submiting the text field if ```searchType == SEARCH_TYPE.onSubmit```.
  /// You should return a list of filtered elements.
  List<T> Function(String query)? filter;

  ///Async callback that return list to be displayed with future builder
  ///to filter the [asyncListCallback] result you need provide [asyncListFilter]
  Future<List<T>?> Function()? asyncListCallback;

  ///Callback invoked when filtring the searchable list
  ///used when providing [asyncListCallback]
  ///can't be null when [asyncListCallback] isn't null
  late List<T> Function(String, List<T>)? asyncListFilter;

  ///Loading widget displayed when [asyncListCallback] is loading
  ///if nothing is provided in [loadingWidget] searchable list will display a [CircularProgressIndicator]
  Widget? loadingWidget;

  ///error widget displayed when [asyncListCallback] result is null
  ///if nothing is provided in [errorWidget] searchable list will display a [Icon]
  Widget? errorWidget;

  /// Builder function that generates the ListView items
  /// based on the returned <T> type item
  late Widget Function(T item)? itemBuilder;

  /// Builder function that generates the Expansion listView items
  /// [expansionGroupIndex] : expansion group index
  /// [listItem] the current item model that will be rendered.
  /// Used only for expansion list constructor
  late Widget Function(int expansionGroupIndex, T listItem)?
      expansionListBuilder;

  /// The widget to be displayed when the filter returns an empty list.
  /// Defaults to `const SizedBox.shrink()`.
  final Widget emptyWidget;

  /// Text editing controller applied on the search field.
  /// Defaults to null.
  late TextEditingController? searchTextController;

  /// The keyboard action key
  /// Defaults to [TextInputAction.done].
  final TextInputAction keyboardAction;

  /// The text field input decoration
  /// Defaults to null.
  final InputDecoration? inputDecoration;

  /// The style for the input text field
  /// Defaults to null.
  final TextStyle? style;

  /// The keyboard text input type
  /// Defaults to [TextInputType.text]
  final TextInputType textInputType;

  /// Callback function invoked when submiting the search text field
  final Function(String?)? onSubmitSearch;

  /// The search type on submiting text field or when changing the text field value
  ///```dart
  ///SEARCH_TYPE.onEdit,
  ///SEARCH_TYPE.onSubmit
  ///```
  /// Defaults to [SearchMode.onEdit].
  final SearchMode searchMode;

  /// Indicate whether the text field input should be obscured or not.
  /// Defaults to `false`.
  final bool obscureText;

  /// Indicate if the search text field is enabled or not.
  /// Defaults to `true`.
  final bool searchFieldEnabled;

  /// max width of search text field
  final double? searchFieldWidth;

  /// height of search text field
  final double? searchFieldHeight;

  /// The focus node applied on the search text field
  final FocusNode? focusNode;

  /// Function invoked when pressing on item
  /// Defaults to null
  final void Function(T)? onItemSelected;

  /// Indicate whether the clear and search icons will be displayed or not
  /// by default it's true, to display the clear icon the inputDecoration should not contains suffix icon
  /// otherwise the initial suffix icon will be displayed
  final bool displayClearIcon;

  /// Indicate whether the search icon will be displayed or not
  /// by default it's true, to display the search icon the inputDecoration should not contains suffix icon
  /// otherwise the initial suffix icon will be displayed
  final bool displaySearchIcon;

  /// The color applied on the suffix icon (if `displayClearIcon = true`).
  /// Defaults to [Colors.grey].
  final Color defaultSuffixIconColor;

  /// The size of the suffix icon (if `displayClearIcon = true`).
  /// Defaults to 24.
  final double defaultSuffixIconSize;

  ///An async callback invoked when dragging down the list
  ///if onRefresh is nullable the drag to refresh is not applied
  late Future<void> Function()? onRefresh;

  ///Builder callback required  when using [seperated] constructor
  ///return the Widget that will seperate all the elements inside the list
  late Widget Function(BuildContext context, int index)? seperatorBuilder;

  ///The scroll direction of the list
  ///by default [Axis.vertical]
  Axis scrollDirection = Axis.vertical;

  ///The position of the text field (bottom or top)
  ///by default the textfield is displayed on top
  SearchTextPosition searchTextPosition = SearchTextPosition.top;

  ///Callback function invoked each time the listview
  ///reached the bottom
  ///used to create pagination in listview
  Future<dynamic> Function()? onPaginate;

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

  ///secondary widget will be displayed alongside the search field
  ///by default it's null
  final Widget? secondaryWidget;

  ///Map of data used to build  searchable expansion list
  ///required when using [expansion] constructor
  late Map<dynamic, List<T>> expansionListData;

  ///callback used when filtering the expansion list
  ///required when using [expansion] constructor
  late Map<dynamic, List<T>> Function(String)? filterExpansionData;

  ///the expansion list title widget builder
  ///required when using [expansion] constructor
  late Widget Function(dynamic) expansionTitleBuilder;

  ///physics attributes used in listview widget
  late ScrollPhysics? physics;

  ///shrinkWrap used in listview widget, not used in sliver searchable list
  ///by default `shrinkWrap = false`
  late bool shrinkWrap;

  ///item extent of the listview
  late double? itemExtent;

  ///listview item padding
  late EdgeInsetsGeometry? listViewPadding;

  ///list items reverse attributes
  ///by default `reverse = false`
  ///not available for sliver listview constructor
  late bool reverse;

  ///Predicate callback invoked when sorting list items
  ///required when `displaySortWidget` is True
  late int Function(T a, T b)? sortPredicate;

  ///Widget displayed when sorting list
  /// available only if `displaySortWidget` is True
  late Widget? sortWidget;

  ///Scroll controller passed to listview widget
  ///by default listview uses scrollcontroller with a listener for pagination if `onPaginate = true`
  ///or `closeKeyboardWhenScrolling = true` to close keyboard when scrolling
  ScrollController? scrollController;

  ///indicates whether the keyboard will be closed when scrolling or not
  ///by default `closeKeyboardWhenScrolling = true`
  final bool closeKeyboardWhenScrolling;

  ///indicate whether the expansion will be shown or not when the expansion group is empty
  late bool hideEmptyExpansionItems = false;

  ///Indicate whether the expansion tile will be enabled or not
  late bool expansionTileEnabled = true;

  bool isExpansionList = false;

  @override
  State<SearchableList> createState() => _SearchableListState<T>();
}

class _SearchableListState<T> extends State<SearchableList<T>> {
  ///create scroll controller instance
  ///attached to the listview widget
  late ScrollController scrollController =
      widget.scrollController ?? ScrollController();
  List<T> asyncListResult = [];
  List<T> filtredAsyncListResult = [];
  bool dataDownloaded = false;

  @override
  void initState() {
    super.initState();
    scrollController.addListener(() {
      if (widget.closeKeyboardWhenScrolling) {
        FocusScope.of(context).requestFocus(FocusNode());
      }
      if (widget.onPaginate != null &&
          scrollController.position.pixels ==
              scrollController.position.maxScrollExtent) {
        widget.onPaginate?.call();
      }
    });
    widget.searchTextController?.addListener(() {
      filterList(widget.searchTextController?.text ?? '');
    });
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return widget.isExpansionList
        ? renderSearchableExpansionList()
        : widget.sliverScrollEffect
            ? renderSliverEffect()
            : Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: widget.searchTextPosition == SearchTextPosition.top
                    ? [
                        SizedBox(
                          width: widget.searchFieldWidth,
                          height: widget.searchFieldHeight,
                          child: SearchTextField(
                            filterList: filterList,
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
                            displaySearchIcon: widget.displaySearchIcon,
                            defaultSuffixIconColor:
                                widget.defaultSuffixIconColor,
                            defaultSuffixIconSize: widget.defaultSuffixIconSize,
                            textStyle: widget.style,
                            cursorColor: widget.cursorColor,
                            maxLength: widget.maxLength,
                            maxLines: widget.maxLines,
                            textAlign: widget.textAlign,
                            autoCompleteHints: widget.autoCompleteHints,
                            secondaryWidget: widget.secondaryWidget,
                            onSortTap: sortList,
                            sortWidget: widget.sortWidget,
                          ),
                        ),
                        SizedBox(
                          height: widget.spaceBetweenSearchAndList,
                        ),
                        Expanded(
                          child: widget.asyncListCallback != null &&
                                  !dataDownloaded
                              ? renderAsyncListView()
                              : renderSearchableListView(),
                        ),
                      ]
                    : [
                        Expanded(
                          child: widget.asyncListCallback != null &&
                                  !dataDownloaded
                              ? renderAsyncListView()
                              : renderSearchableListView(),
                        ),
                        SizedBox(
                          height: widget.spaceBetweenSearchAndList,
                        ),
                        SizedBox(
                          width: widget.searchFieldWidth,
                          height: widget.searchFieldHeight,
                          child: SearchTextField(
                            filterList: filterList,
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
                            displaySearchIcon: widget.displaySearchIcon,
                            defaultSuffixIconColor:
                                widget.defaultSuffixIconColor,
                            defaultSuffixIconSize: widget.defaultSuffixIconSize,
                            textStyle: widget.style,
                            cursorColor: widget.cursorColor,
                            maxLength: widget.maxLength,
                            maxLines: widget.maxLines,
                            textAlign: widget.textAlign,
                            autoCompleteHints: widget.autoCompleteHints,
                            secondaryWidget: widget.secondaryWidget,
                            onSortTap: sortList,
                            sortWidget: widget.sortWidget,
                          ),
                        ),
                      ],
              );
  }

  Widget renderAsyncListView() {
    return FutureBuilder(
      future: widget.asyncListCallback!.call(),
      builder: (context, snapshot) {
        dataDownloaded = snapshot.connectionState != ConnectionState.waiting;
        if (!dataDownloaded) {
          return widget.loadingWidget ?? const DefaultLoadingWidget();
        }
        if (snapshot.data == null) {
          return widget.errorWidget ?? const DefaultErrorWidget();
        }
        asyncListResult = snapshot.data as List<T>;
        filtredAsyncListResult = asyncListResult;
        return renderSearchableListView();
      },
    );
  }

  Widget renderSearchableListView() {
    List<T> renderedList = widget.asyncListCallback != null
        ? filtredAsyncListResult
        : widget.initialList;
    return renderListView(
      list: renderedList,
    );
  }

  Widget renderSearchableExpansionList() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: widget.searchFieldWidth,
          height: widget.searchFieldHeight,
          child: SearchTextField(
            filterList: filterList,
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
            displaySearchIcon: widget.displaySearchIcon,
            defaultSuffixIconColor: widget.defaultSuffixIconColor,
            defaultSuffixIconSize: widget.defaultSuffixIconSize,
            textStyle: widget.style,
            cursorColor: widget.cursorColor,
            maxLength: widget.maxLength,
            maxLines: widget.maxLines,
            textAlign: widget.textAlign,
            autoCompleteHints: widget.autoCompleteHints,
            secondaryWidget: widget.secondaryWidget,
          ),
        ),
        SizedBox(
          height: widget.spaceBetweenSearchAndList,
        ),
        renderExpansionListView(),
      ],
    );
  }

  ///creates listview based on the items passed to the widget
  ///check whether the [widget.onRefresh] parameter is nullable or not
  ///if [widget.displayDividder] is true
  /// function will runder [ListView.separated]
  ///else the function will render a normal listview [ListView.builder]
  Widget renderListView({
    required List<T> list,
  }) {
    if (list.isEmpty) {
      return widget.emptyWidget;
    } else {
      return widget.onRefresh != null
          ? RefreshIndicator(
              triggerMode: RefreshIndicatorTriggerMode.onEdge,
              onRefresh: widget.onRefresh!,
              child: widget.seperatorBuilder != null
                  ? renderSeperatedListView(list)
                  : ListView.builder(
                      physics: widget.physics,
                      shrinkWrap: widget.shrinkWrap,
                      itemExtent: widget.itemExtent,
                      padding: widget.listViewPadding,
                      reverse: widget.reverse,
                      controller: scrollController,
                      scrollDirection: widget.scrollDirection,
                      itemCount: list.length,
                      itemBuilder: (context, index) => ListItem<T>(
                        builder: widget.itemBuilder!,
                        item: list[index],
                        onItemSelected: widget.onItemSelected,
                      ),
                    ),
            )
          : widget.seperatorBuilder != null
              ? renderSeperatedListView(list)
              : ListView.builder(
                  physics: widget.physics,
                  shrinkWrap: widget.shrinkWrap,
                  itemExtent: widget.itemExtent,
                  padding: widget.listViewPadding,
                  reverse: widget.reverse,
                  controller: scrollController,
                  scrollDirection: widget.scrollDirection,
                  itemCount: list.length,
                  itemBuilder: (context, index) => ListItem<T>(
                    builder: widget.itemBuilder!,
                    item: list[index],
                    onItemSelected: widget.onItemSelected,
                  ),
                );
    }
  }

  Widget renderExpansionListView() {
    if (widget.expansionListData.isEmpty ||
        widget.expansionListData.values.every((element) => element.isEmpty)) {
      return widget.emptyWidget;
    } else {
      if (widget.hideEmptyExpansionItems) {
        widget.expansionListData.removeWhere((key, value) => value.isEmpty);
      }
      return Expanded(
        child: ListView.builder(
          controller: scrollController,
          scrollDirection: widget.scrollDirection,
          itemCount: widget.expansionListData.length,
          physics: widget.physics,
          shrinkWrap: widget.shrinkWrap,
          itemExtent: widget.itemExtent,
          padding: widget.listViewPadding,
          reverse: widget.reverse,
          itemBuilder: (context, index) {
            var entryKey = widget.expansionListData.keys.toList()[index];
            var entryValueList = widget.expansionListData[entryKey];
            return ExpansionTile(
              title: widget.expansionTitleBuilder.call(entryKey),
              enabled: widget.expansionTileEnabled,
              children: entryValueList?.map(
                    (listItem) {
                      return widget.onItemSelected == null
                          ? widget.expansionListBuilder!(index, listItem)
                          : InkWell(
                              onTap: () {
                                widget.onItemSelected?.call(listItem);
                              },
                              child:
                                  widget.expansionListBuilder!(index, listItem),
                            );
                    },
                  ).toList() ??
                  [],
            );
          },
        ),
      );
    }
  }

  ///renders a seperated listview using [ListView.separated]
  Widget renderSeperatedListView(List<T> list) {
    return ListView.separated(
      controller: scrollController,
      scrollDirection: widget.scrollDirection,
      itemCount: list.length,
      physics: widget.physics,
      shrinkWrap: widget.shrinkWrap,
      padding: widget.listViewPadding,
      reverse: widget.reverse,
      itemBuilder: (context, index) => ListItem<T>(
        builder: widget.itemBuilder!,
        item: list[index],
        onItemSelected: widget.onItemSelected,
      ),
      separatorBuilder: widget.seperatorBuilder!,
    );
  }

  ///render sliver listview
  ///if [widget.scrollDirection] set to [Axis.horizontal]
  ///the function will render an horizontal sliver listview
  ///else it will render a vertical listview
  Widget renderSliverEffect() {
    return widget.scrollDirection == Axis.horizontal
        ? Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: widget.searchTextPosition == SearchTextPosition.top
                ? [
                    SizedBox(
                      width: widget.searchFieldWidth,
                      child: SearchTextField(
                        filterList: filterList,
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
                        displaySearchIcon: widget.displaySearchIcon,
                        defaultSuffixIconColor: widget.defaultSuffixIconColor,
                        defaultSuffixIconSize: widget.defaultSuffixIconSize,
                        textStyle: widget.style,
                        cursorColor: widget.cursorColor,
                        maxLength: widget.maxLength,
                        maxLines: widget.maxLines,
                        textAlign: widget.textAlign,
                        autoCompleteHints: widget.autoCompleteHints,
                        secondaryWidget: widget.secondaryWidget,
                        onSortTap: sortList,
                        sortWidget: widget.sortWidget,
                      ),
                    ),
                    SizedBox(
                      height: widget.spaceBetweenSearchAndList,
                    ),
                    Expanded(
                      child: CustomScrollView(
                        scrollDirection: widget.scrollDirection,
                        physics: widget.physics,
                        controller: scrollController,
                        slivers: [
                          SliverList(
                            delegate: widget.initialList.isEmpty
                                ? SliverChildBuilderDelegate(
                                    (context, index) => widget.emptyWidget,
                                    childCount: 1,
                                  )
                                : SliverChildBuilderDelegate(
                                    (context, index) => ListItem<T>(
                                      builder: widget.itemBuilder!,
                                      item: widget.initialList[index],
                                      onItemSelected: widget.onItemSelected,
                                    ),
                                    childCount: widget.initialList.length,
                                  ),
                          ),
                        ],
                      ),
                    ),
                  ]
                : [
                    Expanded(
                      child: CustomScrollView(
                        scrollDirection: widget.scrollDirection,
                        controller: scrollController,
                        physics: widget.physics,
                        slivers: [
                          SliverList(
                            delegate: widget.initialList.isEmpty
                                ? SliverChildBuilderDelegate(
                                    (context, index) => widget.emptyWidget,
                                    childCount: 1,
                                  )
                                : SliverChildBuilderDelegate(
                                    (context, index) => ListItem<T>(
                                      builder: widget.itemBuilder!,
                                      item: widget.initialList[index],
                                      onItemSelected: widget.onItemSelected,
                                    ),
                                    childCount: widget.initialList.length,
                                  ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: widget.spaceBetweenSearchAndList,
                    ),
                    SizedBox(
                      width: widget.searchFieldWidth,
                      child: SearchTextField(
                        filterList: filterList,
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
                        displaySearchIcon: widget.displaySearchIcon,
                        defaultSuffixIconColor: widget.defaultSuffixIconColor,
                        defaultSuffixIconSize: widget.defaultSuffixIconSize,
                        textStyle: widget.style,
                        cursorColor: widget.cursorColor,
                        maxLength: widget.maxLength,
                        maxLines: widget.maxLines,
                        textAlign: widget.textAlign,
                        autoCompleteHints: widget.autoCompleteHints,
                        secondaryWidget: widget.secondaryWidget,
                        onSortTap: sortList,
                        sortWidget: widget.sortWidget,
                      ),
                    ),
                  ],
          )
        : CustomScrollView(
            scrollDirection: widget.scrollDirection,
            physics: widget.physics,
            slivers: widget.searchTextPosition == SearchTextPosition.top
                ? [
                    SliverAppBar(
                      backgroundColor: Colors.transparent,
                      flexibleSpace: SearchTextField(
                        filterList: filterList,
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
                        displaySearchIcon: widget.displaySearchIcon,
                        defaultSuffixIconColor: widget.defaultSuffixIconColor,
                        defaultSuffixIconSize: widget.defaultSuffixIconSize,
                        textStyle: widget.style,
                        cursorColor: widget.cursorColor,
                        maxLength: widget.maxLength,
                        maxLines: widget.maxLines,
                        textAlign: widget.textAlign,
                        autoCompleteHints: widget.autoCompleteHints,
                        secondaryWidget: widget.secondaryWidget,
                        onSortTap: sortList,
                        sortWidget: widget.sortWidget,
                      ),
                    ),
                    SliverList(
                      delegate: widget.initialList.isEmpty
                          ? SliverChildBuilderDelegate(
                              (context, index) => widget.emptyWidget,
                              childCount: 1,
                            )
                          : SliverChildBuilderDelegate(
                              (context, index) => ListItem<T>(
                                builder: widget.itemBuilder!,
                                item: widget.initialList[index],
                                onItemSelected: widget.onItemSelected,
                              ),
                              childCount: widget.initialList.length,
                            ),
                    ),
                  ]
                : [
                    SliverList(
                      delegate: widget.initialList.isEmpty
                          ? SliverChildBuilderDelegate(
                              (context, index) => widget.emptyWidget,
                              childCount: 1,
                            )
                          : SliverChildBuilderDelegate(
                              (context, index) => ListItem<T>(
                                builder: widget.itemBuilder!,
                                item: widget.initialList[index],
                                onItemSelected: widget.onItemSelected,
                              ),
                              childCount: widget.initialList.length,
                            ),
                    ),
                    SliverAppBar(
                      backgroundColor: Colors.transparent,
                      flexibleSpace: SearchTextField(
                        filterList: filterList,
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
                        displaySearchIcon: widget.displaySearchIcon,
                        defaultSuffixIconColor: widget.defaultSuffixIconColor,
                        defaultSuffixIconSize: widget.defaultSuffixIconSize,
                        textStyle: widget.style,
                        cursorColor: widget.cursorColor,
                        maxLength: widget.maxLength,
                        maxLines: widget.maxLines,
                        textAlign: widget.textAlign,
                        autoCompleteHints: widget.autoCompleteHints,
                        secondaryWidget: widget.secondaryWidget,
                        onSortTap: sortList,
                        sortWidget: widget.sortWidget,
                      ),
                    ),
                  ],
          );
  }

  void filterList(String value) {
    if (widget.isExpansionList) {
      setState(() {
        widget.expansionListData =
            widget.filterExpansionData?.call(value) ?? {};
      });
    } else if (widget.asyncListCallback != null) {
      setState(() {
        filtredAsyncListResult = widget.asyncListFilter!(
          value,
          asyncListResult,
        );
      });
    } else {
      setState(() {
        widget.initialList = widget.filter!(value);
      });
    }
  }

  void sortList() {
    if (widget.asyncListCallback != null) {
      setState(() {
        filtredAsyncListResult.sort(widget.sortPredicate);
      });
    } else {
      setState(() {
        widget.initialList.sort(widget.sortPredicate);
      });
    }
  }
}
