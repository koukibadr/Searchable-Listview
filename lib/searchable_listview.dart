// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:searchable_listview/resources/arrays.dart';
import 'package:searchable_listview/widgets/default_error_widget.dart';
import 'package:searchable_listview/widgets/default_loading_widget.dart';
import 'package:searchable_listview/widgets/list_view_rendering.dart';
import 'package:searchable_listview/widgets/search_text_field.dart';

class SearchableList<T> extends StatefulWidget {
  /// Indicates whether the ssliver scroll effect will be applied
  /// on the listview and search field or not
  /// by default sliverScrollEffect == [false]
  bool sliverScrollEffect = false;

  /// Indicate if the divider will be displayed or not
  /// if true the listview will be rendered with [ListView.separated] constructor
  bool displayDivider = false;

  SearchableList({
    Key? key,
    required this.initialList,
    required this.itemBuilder,
    required this.filter,
    this.loadingWidget,
    this.errorWidget,
    this.searchTextController,
    this.keyboardAction = TextInputAction.done,
    this.inputDecoration,
    this.textStyle,
    this.onSubmitSearch,
    this.searchMode = SearchMode.onEdit,
    this.emptyWidget,
    this.textInputType = TextInputType.text,
    this.obscureText = false,
    this.focusNode,
    this.searchFieldEnabled = true,
    this.searchFieldWidth,
    this.searchFieldHeight,
    this.displayClearIcon = true,
    this.onRefresh,
    this.scrollDirection = Axis.vertical,
    this.searchTextPosition = SearchTextPosition.top,
    this.onPaginate,
    this.searchFieldPadding,
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
    this.separatorBuilder,
    this.scrollController,
    this.closeKeyboardWhenScrolling = false,
    this.displaySearchIcon = true,
    this.defaultSuffixIconColor = Colors.grey,
    this.defaultSuffixIconSize = 24,
    this.lazyLoadingEnabled = true,
    this.textAlignVertical = TextAlignVertical.center,
    this.labelText,
    this.showSearchField = true,
  }) : super(key: key) {
    searchTextController ??= TextEditingController();
    expansionListBuilder = null;
    asyncListCallback = null;
    asyncListFilter = null;
    assert(filter != null);
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
    this.textStyle,
    this.onSubmitSearch,
    this.searchMode = SearchMode.onEdit,
    this.emptyWidget = const SizedBox.shrink(),
    this.textInputType = TextInputType.text,
    this.obscureText = false,
    this.focusNode,
    this.searchFieldEnabled = true,
    this.searchFieldWidth,
    this.searchFieldHeight,
    this.displayClearIcon = true,
    this.onRefresh,
    this.scrollDirection = Axis.vertical,
    this.searchTextPosition = SearchTextPosition.top,
    this.onPaginate,
    this.searchFieldPadding,
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
    this.separatorBuilder,
    this.sortPredicate,
    this.sortWidget,
    this.scrollController,
    this.closeKeyboardWhenScrolling = false,
    this.displaySearchIcon = true,
    this.defaultSuffixIconColor = Colors.grey,
    this.defaultSuffixIconSize = 24,
    this.lazyLoadingEnabled = true,
    this.textAlignVertical = TextAlignVertical.center,
    this.labelText,
    this.showSearchField = true,
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
    this.textStyle,
    this.onSubmitSearch,
    this.searchMode = SearchMode.onEdit,
    this.emptyWidget = const SizedBox.shrink(),
    this.textInputType = TextInputType.text,
    this.obscureText = false,
    this.focusNode,
    this.searchFieldEnabled = true,
    this.searchFieldWidth,
    this.searchFieldHeight,
    this.displayClearIcon = true,
    this.searchFieldPadding,
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
    this.displaySearchIcon = true,
    this.defaultSuffixIconColor = Colors.grey,
    this.defaultSuffixIconSize = 24,
    this.lazyLoadingEnabled = true,
    this.searchTextPosition = SearchTextPosition.top,
    this.textAlignVertical = TextAlignVertical.center,
    this.labelText,
    this.showSearchField = true,
  }) : super(key: key) {
    searchTextController ??= TextEditingController();
    separatorBuilder = null;
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
    this.textStyle,
    this.onSubmitSearch,
    this.searchMode = SearchMode.onEdit,
    this.emptyWidget = const SizedBox.shrink(),
    this.textInputType = TextInputType.text,
    this.obscureText = false,
    this.focusNode,
    this.searchFieldEnabled = true,
    this.searchFieldWidth,
    this.searchFieldHeight,
    this.displayClearIcon = true,
    this.scrollDirection = Axis.vertical,
    this.searchTextPosition = SearchTextPosition.top,
    this.onPaginate,
    this.searchFieldPadding,
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
    this.displaySearchIcon = true,
    this.defaultSuffixIconColor = Colors.grey,
    this.defaultSuffixIconSize = 24,
    this.lazyLoadingEnabled = true,
    this.textAlignVertical = TextAlignVertical.center,
    this.labelText,
    this.showSearchField = true,
  }) : super(key: key) {
    asyncListCallback = null;
    asyncListFilter = null;
    searchTextController ??= TextEditingController();
    separatorBuilder = null;
    sliverScrollEffect = true;
    onRefresh = null;
    shrinkWrap = false;
    itemExtent = null;
    listViewPadding = null;
    reverse = false;
    expansionListBuilder = null;
    if (sortWidget != null) {
      assert(sortPredicate != null);
    }
  }

  /// Initial list of all elements that will be displayed.
  /// to filter the [initialList] you need provide [filter] callback
  late List<T> initialList;

  /// Callback to filter the list based on the given search value.
  /// Invoked on changing the text field search if ```searchType == SEARCH_TYPE.onEdit```
  /// or invoked when submiting the text field if ```searchType == SEARCH_TYPE.onSubmit```.
  /// You should return a list of filtered elements.
  List<T> Function(String query)? filter;

  /// Async callback that return list to be displayed with future builder
  /// to filter the [asyncListCallback] result you need provide [asyncListFilter]
  Future<List<T>?> Function()? asyncListCallback;

  /// Callback invoked when filtring the searchable list
  /// used when providing [asyncListCallback]
  /// can't be null when [asyncListCallback] isn't null
  late List<T> Function(String, List<T>)? asyncListFilter;

  /// Loading widget displayed when [asyncListCallback] is loading
  /// if nothing is provided in [loadingWidget] searchable list will display a [CircularProgressIndicator]
  Widget? loadingWidget;

  /// Error widget displayed when [asyncListCallback] result is null
  /// if nothing is provided in [errorWidget] searchable list will display a [Icon]
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
  final Widget? emptyWidget;

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
  final TextStyle? textStyle;

  /// The keyboard text input type
  /// Defaults to [TextInputType.text]
  final TextInputType textInputType;

  /// Callback function invoked when submiting the search text field
  final Function(String?)? onSubmitSearch;

  /// The search type on submiting text field or when changing the text field value
  /// ```dart
  /// SEARCH_TYPE.onEdit,
  /// SEARCH_TYPE.onSubmit
  /// ```
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

  /// An async callback invoked when dragging down the list
  /// if onRefresh is nullable the drag to refresh is not applied
  late Future<void> Function()? onRefresh;

  /// Builder callback required  when using [seperated] constructor
  /// return the Widget that will seperate all the elements inside the list
  late Widget Function(BuildContext context, int index)? separatorBuilder;

  /// The scroll direction of the list
  /// by default [Axis.vertical]
  Axis scrollDirection = Axis.vertical;

  /// The position of the text field (bottom or top)
  /// by default the textfield is displayed on top
  SearchTextPosition searchTextPosition = SearchTextPosition.top;

  /// Callback function invoked each time the listview
  /// reached the bottom
  /// used to create pagination in listview
  Future<dynamic> Function()? onPaginate;

  // A padding applied to search field
  final EdgeInsetsGeometry? searchFieldPadding;

  /// Cusor color used in the search textfield
  final Color? cursorColor;

  /// Max lines attribute used in the search textfield
  final int? maxLines;

  /// Max length attribute used in the search field
  final int? maxLength;

  /// The text alignement of the search field
  /// by default the alignement is start
  final TextAlign textAlign;

  /// The text field vertical alignment
  final TextAlignVertical textAlignVertical;

  /// List of strings  to display in an auto complete field
  /// by default list is empty so a simple text field is displayed
  final List<String> autoCompleteHints;

  /// Secondary widget will be displayed alongside the search field
  /// by default it's null
  final Widget? secondaryWidget;

  /// Map of data used to build  searchable expansion list
  /// required when using [expansion] constructor
  late Map<dynamic, List<T>> expansionListData;

  /// Callback used when filtering the expansion list
  /// required when using [expansion] constructor
  late Map<dynamic, List<T>> Function(String)? filterExpansionData;

  /// The expansion list title widget builder
  /// required when using [expansion] constructor
  late Widget Function(dynamic) expansionTitleBuilder;

  /// Physics attributes used in listview widget
  late ScrollPhysics? physics;

  /// ShrinkWrap used in listview widget, not used in sliver searchable list
  /// by default `shrinkWrap = false`
  late bool shrinkWrap;

  /// Item extent of the listview
  late double? itemExtent;

  /// Listview item padding
  late EdgeInsetsGeometry? listViewPadding;

  /// List items reverse attributes
  /// by default `reverse = false`
  /// not available for sliver listview constructor
  late bool reverse;

  /// Predicate callback invoked when sorting list items
  /// required when `displaySortWidget` is True
  late int Function(T a, T b)? sortPredicate;

  /// Widget displayed when sorting list
  /// available only if `displaySortWidget` is True
  late Widget? sortWidget;

  /// Scroll controller passed to listview widget
  /// by default listview uses scrollcontroller with a listener for pagination if `onPaginate = true`
  /// or `closeKeyboardWhenScrolling = true` to close keyboard when scrolling
  ScrollController? scrollController;

  /// Indicates whether the keyboard will be closed when scrolling or not
  /// by default `closeKeyboardWhenScrolling = true`
  final bool closeKeyboardWhenScrolling;

  /// Indicate whether the expansion will be shown or not when the expansion group is empty
  late bool hideEmptyExpansionItems = false;

  /// Indicate whether the expansion tile will be enabled or not
  late bool expansionTileEnabled = true;

  /// max width of search text field
  final double? searchFieldWidth;

  /// height of search text field
  final double? searchFieldHeight;

  // Indicates how list view is rendered if `true` searchable listview
  // uses `Listview.Builder` otherwise it uses `Listview`
  final bool lazyLoadingEnabled;

  /// The text field label text
  /// used to display a label above the text field
  /// this text is displayed only when [inputDecoration] is null.
  final String? labelText;

  /// Indicates whether the search field will be displayed or not
  /// by default `showSearchField = true`
  final bool showSearchField;

  bool isExpansionList = false;

  @override
  State<SearchableList> createState() => _SearchableListState<T>();
}

class _SearchableListState<T> extends State<SearchableList<T>> {
  /// Create scroll controller instance
  /// attached to the listview widget
  late ScrollController scrollController =
      widget.scrollController ?? ScrollController();
  List<T> asyncListResult = [];
  late List<T> filtredListResult = widget.initialList;
  List<T> filtredAsyncListResult = [];
  String searchText = '';
  bool dataDownloaded = false;
  List<ExpansionTileController> expansionTileControllers = [];

  @override
  void initState() {
    super.initState();
    scrollController.addListener(() {
      if (widget.closeKeyboardWhenScrolling &&
          widget.focusNode?.hasFocus == true) {
        FocusScope.of(context).requestFocus(FocusNode());
      }
      if (widget.onPaginate != null &&
          scrollController.position.pixels ==
              scrollController.position.maxScrollExtent) {
        setState(() {
          widget.onPaginate?.call();
        });
      }
    });
    widget.searchTextController?.addListener(_textControllerListener);
  }

  @override
  void dispose() {
    if (widget.scrollController == null) {
      scrollController.dispose();
    }
    widget.searchTextController?.removeListener(_textControllerListener);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return widget.isExpansionList
        ? buildExpandableListView()
        : widget.sliverScrollEffect
            ? renderSliverEffect()
            : Column(
                verticalDirection:
                    widget.searchTextPosition == SearchTextPosition.top
                        ? VerticalDirection.down
                        : VerticalDirection.up,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (widget.showSearchField)
                    Padding(
                      padding: widget.searchFieldPadding ?? EdgeInsets.zero,
                      child: SizedBox(
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
                          textStyle: widget.textStyle,
                          cursorColor: widget.cursorColor,
                          maxLength: widget.maxLength,
                          maxLines: widget.maxLines,
                          textAlign: widget.textAlign,
                          autoCompleteHints: widget.autoCompleteHints,
                          secondaryWidget: widget.secondaryWidget,
                          onSortTap: sortList,
                          sortWidget: widget.sortWidget,
                          verticalTextAlign: widget.textAlignVertical,
                          labelText: widget.labelText,
                        ),
                      ),
                    ),
                  Expanded(
                    child: widget.asyncListCallback != null && !dataDownloaded
                        ? renderAsyncListView()
                        : renderSearchableListView(),
                  ),
                ],
              );
  }

  Widget renderAsyncListView() {
    return FutureBuilder(
      future: widget.asyncListCallback!.call(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return widget.loadingWidget ?? const DefaultLoadingWidget();
        }
        dataDownloaded = true;
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
        : filtredListResult;
    return buildSearchableListView(
      list: renderedList,
    );
  }

  /// Creates listview based on the items passed to the widget
  /// check whether the [widget.onRefresh] parameter is nullable or not
  /// if [widget.displayDividder] is true
  /// function will runder [ListView.separated]
  /// else the function will render a normal listview [ListView.builder]
  Widget buildSearchableListView({
    required List<T> list,
  }) {
    if (list.isEmpty) {
      return widget.emptyWidget ?? const SizedBox.shrink();
    } else {
      return widget.onRefresh != null
          ? RefreshIndicator(
              triggerMode: RefreshIndicatorTriggerMode.onEdge,
              onRefresh: widget.onRefresh!,
              child: ListViewRendering(
                physics: widget.physics,
                shrinkWrap: widget.shrinkWrap,
                itemExtent: widget.itemExtent,
                padding: widget.listViewPadding,
                reverse: widget.reverse,
                scrollController: scrollController,
                scrollDirection: widget.scrollDirection,
                isLazyLoadingEnabled: widget.lazyLoadingEnabled,
                list: list,
                itemBuilder: widget.itemBuilder,
                isListViewSeparated: widget.separatorBuilder != null,
                seperatorBuilder: widget.separatorBuilder,
              ),
            )
          : ListViewRendering(
              physics: widget.physics,
              shrinkWrap: widget.shrinkWrap,
              itemExtent: widget.itemExtent,
              padding: widget.listViewPadding,
              reverse: widget.reverse,
              scrollController: scrollController,
              scrollDirection: widget.scrollDirection,
              isLazyLoadingEnabled: widget.lazyLoadingEnabled,
              list: list,
              itemBuilder: widget.itemBuilder,
              isListViewSeparated: widget.separatorBuilder != null,
              seperatorBuilder: widget.separatorBuilder,
            );
    }
  }

  Widget buildExpandableListView() {
    if (widget.expansionListData.isEmpty ||
        widget.expansionListData.values.every((element) => element.isEmpty)) {
      return widget.emptyWidget ?? const SizedBox.shrink();
    } else {
      expansionTileControllers.addAll(
        List.generate(
          widget.expansionListData.length,
          (e) => ExpansionTileController(),
        ),
      );
      if (widget.hideEmptyExpansionItems) {
        widget.expansionListData.removeWhere((key, value) => value.isEmpty);
      }
      return Column(
        verticalDirection: widget.searchTextPosition == SearchTextPosition.top
            ? VerticalDirection.down
            : VerticalDirection.up,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (widget.showSearchField)
            Padding(
              padding: widget.searchFieldPadding ?? const EdgeInsets.all(0),
              child: SizedBox(
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
                  textStyle: widget.textStyle,
                  cursorColor: widget.cursorColor,
                  maxLength: widget.maxLength,
                  maxLines: widget.maxLines,
                  textAlign: widget.textAlign,
                  autoCompleteHints: widget.autoCompleteHints,
                  secondaryWidget: widget.secondaryWidget,
                  verticalTextAlign: widget.textAlignVertical,
                  labelText: widget.labelText,
                ),
              ),
            ),
          Expanded(
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
                  controller: expansionTileControllers[index],
                  children: entryValueList?.map(
                        (listItem) {
                          return widget.expansionListBuilder!(index, listItem);
                        },
                      ).toList() ??
                      [],
                );
              },
            ),
          ),
        ],
      );
    }
  }

  /// Render sliver listview
  /// if [widget.scrollDirection] set to [Axis.horizontal]
  /// the function will render an horizontal sliver listview
  /// else it will render a vertical listview
  Widget renderSliverEffect() {
    return widget.scrollDirection == Axis.horizontal
        ? Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            verticalDirection:
                widget.searchTextPosition == SearchTextPosition.top
                    ? VerticalDirection.down
                    : VerticalDirection.up,
            children: [
              if (widget.showSearchField)
                Padding(
                  padding: widget.searchFieldPadding ?? const EdgeInsets.all(0),
                  child: SizedBox(
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
                      textStyle: widget.textStyle,
                      cursorColor: widget.cursorColor,
                      maxLength: widget.maxLength,
                      maxLines: widget.maxLines,
                      textAlign: widget.textAlign,
                      autoCompleteHints: widget.autoCompleteHints,
                      secondaryWidget: widget.secondaryWidget,
                      onSortTap: sortList,
                      sortWidget: widget.sortWidget,
                      verticalTextAlign: widget.textAlignVertical,
                      labelText: widget.labelText,
                    ),
                  ),
                ),
              Expanded(
                child: CustomScrollView(
                  scrollDirection: widget.scrollDirection,
                  physics: widget.physics,
                  controller: scrollController,
                  slivers: [
                    renderSliverListView(),
                  ],
                ),
              ),
            ],
          )
        : CustomScrollView(
            scrollDirection: widget.scrollDirection,
            physics: widget.physics,
            reverse: widget.searchTextPosition == SearchTextPosition.bottom,
            slivers: [
              if (widget.showSearchField)
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
                    textStyle: widget.textStyle,
                    cursorColor: widget.cursorColor,
                    maxLength: widget.maxLength,
                    maxLines: widget.maxLines,
                    textAlign: widget.textAlign,
                    autoCompleteHints: widget.autoCompleteHints,
                    secondaryWidget: widget.secondaryWidget,
                    onSortTap: sortList,
                    sortWidget: widget.sortWidget,
                    verticalTextAlign: widget.textAlignVertical,
                    labelText: widget.labelText,
                  ),
                ),
              renderSliverListView(),
            ],
          );
  }

  Widget renderSliverListView() {
    return SliverList(
      delegate: filtredListResult.isEmpty
          ? SliverChildBuilderDelegate(
              (context, index) => widget.emptyWidget,
              childCount: 1,
            )
          : SliverChildBuilderDelegate(
              (context, index) => widget.itemBuilder!(
                filtredListResult[index],
              ),
              childCount: filtredListResult.length,
            ),
    );
  }

  void filterList(String value) {
    searchText = value;
    if (widget.isExpansionList) {
      setState(() {
        widget.expansionListData =
            widget.filterExpansionData?.call(value) ?? {};
      });
      for (var controller in expansionTileControllers) {
        try {
          controller.expand();
        } catch (e) {
          // ignore: avoid_print
          print('Error expanding tile: $e');
        }
      }
    } else if (widget.asyncListCallback != null) {
      setState(() {
        filtredAsyncListResult = widget.asyncListFilter!(
          value,
          asyncListResult,
        );
      });
    } else {
      setState(() {
        filtredListResult = widget.filter?.call(value) ?? [];
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
        filtredListResult.sort(widget.sortPredicate);
      });
    }
  }

  void _textControllerListener() {
    if (searchText != widget.searchTextController?.text) {
      filterList(widget.searchTextController?.text ?? '');
    }
  }
}
