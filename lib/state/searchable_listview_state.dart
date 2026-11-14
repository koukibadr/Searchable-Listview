import 'dart:async';
import 'dart:developer';

import 'package:async/async.dart';
import 'package:material_ui/material_ui.dart';
import 'package:searchable_listview/resources/arrays.dart';
import 'package:searchable_listview/resources/debouncer.dart';
import 'package:searchable_listview/searchable_listview.dart';
import 'package:searchable_listview/state/searchable_list_value.dart';
import 'package:searchable_listview/widgets/default_error_widget.dart';
import 'package:searchable_listview/widgets/default_loading_widget.dart';
import 'package:searchable_listview/widgets/list_view_rendering.dart';
import 'package:searchable_listview/widgets/search_text_field.dart';

class SearchableListState<T> extends State<SearchableList<T>> {
  /// Create scroll controller instance
  /// attached to the listview widget
  late ScrollController scrollController =
      widget.scrollController ?? ScrollController();
  List<T> asyncListResult = [];
  late List<T> filtredListResult = widget.initialList;
  List<T> filtredAsyncListResult = [];
  String searchText = '';
  bool asyncError = false;
  // Current async task running, null otherwise
  CancelableOperation<List<T>?>? _activeOperation;
  Debouncer? _debouncer;
  List<ExpansionTileController> expansionTileControllers = [];
  bool isAsyncCallBackRunning = true;

  @override
  void initState() {
    super.initState();

    // Attach the filter callback to the controller if provided
    widget.controller?.attach(_filterFromController);
    _publishAfterFrame();

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

    if (widget.asyncListCallback != null) {
      // Load the initial list for the async constructor
      WidgetsBinding.instance.addPostFrameCallback((_) async {
        await _asyncInitialList();
        if (mounted) setState(() {});
      });
      _debouncer = Debouncer(milliseconds: widget.asyncDebounceTime);
    }
  }

  @override
  void dispose() {
    log('disposing searchable listview');

    // Detach the filter callback from the controller when disposing
    widget.controller?.detach(_filterFromController);

    _debouncer?.dispose();
    if (widget.focusNode?.hasFocus == true) {
      FocusScope.of(context).requestFocus(FocusNode());
    }
    if (widget.scrollController == null) {
      scrollController.dispose();
    }
    widget.searchTextController?.removeListener(_textControllerListener);
    super.dispose();
  }

  @override
  void didUpdateWidget(covariant SearchableList<T> oldWidget) {
    super.didUpdateWidget(oldWidget);

    // Reload the list if the initialList changed
    if (oldWidget.initialList != widget.initialList) {
      if (searchText.isEmpty) {
        setState(() {
          filtredListResult = widget.initialList;
        });
      } else {
        filterList(searchText);
      }
    }
    if (widget.isExpansionList &&
        oldWidget.expansionListData != widget.expansionListData) {
      filterList(searchText);
    }

    if (oldWidget.controller != widget.controller) {
      oldWidget.controller?.detach(_filterFromController);
      widget.controller?.attach(_filterFromController);
      _publishAfterFrame();
    }
  }

  @override
  Widget build(BuildContext context) {
    return widget.sliverScrollEffect
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
                    child: _buildSearchTextField(),
                  ),
                ),
              Expanded(
                child: widget.isExpansionList
                    ? renderExpandableListView()
                    : (widget.asyncListCallback != null
                          ? renderAsyncListView()
                          : renderSearchableListView()),
              ),
            ],
          );
  }

  Widget renderAsyncListView() {
    if (asyncError) {
      return widget.errorWidget ?? const DefaultErrorWidget();
    }
    if (_activeOperation != null || isAsyncCallBackRunning) {
      return widget.loadingWidget ?? const DefaultLoadingWidget();
    }
    return renderSearchableListView();
  }

  Widget renderSearchableListView() {
    List<T> renderedList = widget.asyncListCallback != null
        ? filtredAsyncListResult
        : filtredListResult;
    return buildSearchableListView(list: renderedList);
  }

  /// Creates listview based on the items passed to the widget
  /// check whether the [widget.onRefresh] parameter is nullable or not
  /// if [widget.displayDividder] is true
  /// function will runder [ListView.separated]
  /// else the function will render a normal listview [ListView.builder]
  Widget buildSearchableListView({required List<T> list}) {
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

  Widget renderExpandableListView() {
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
      return ListView.builder(
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
            initiallyExpanded: widget.initiallyExpanded,
            title: widget.expansionTitleBuilder.call(entryKey),
            enabled: widget.expansionTileEnabled,
            controller: expansionTileControllers[index],
            children:
                entryValueList?.map((listItem) {
                  return widget.expansionListBuilder!(index, listItem);
                }).toList() ??
                [],
          );
        },
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
                    child: _buildSearchTextField(),
                  ),
                ),
              Expanded(
                child: CustomScrollView(
                  scrollDirection: widget.scrollDirection,
                  physics: widget.physics,
                  controller: scrollController,
                  slivers: [renderSliverListView()],
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
                  flexibleSpace: _buildSearchTextField(),
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
              (context, index) => widget.itemBuilder!(filtredListResult[index]),
              childCount: filtredListResult.length,
            ),
    );
  }

  void filterList(String value) {
    if (widget.searchableFields != null) {
      _filterWithSearchStrategy(value);
      return;
    }

    searchText = value;

    if (widget.isExpansionList) {
      setState(() {
        widget.expansionListData =
            widget.filterExpansionData?.call(value) ?? {};
      });
      _publishToController();

      for (var controller in expansionTileControllers) {
        try {
          controller.expand();
        } catch (e) {
          // ignore: avoid_print
          print('Error expanding tile: $e');
        }
      }
    } else if (widget.asyncListCallback != null) {
      _filterAsyncSeachableList(value);
    } else {
      setState(() {
        filtredListResult = widget.filter?.call(value) ?? [];
      });
      _publishToController();
    }
  }

  void _filterWithSearchStrategy(String value) {
    if (widget.isExpansionList) {
      setState(() {
        widget.expansionListData =
            widget.filterExpansionData?.call(value) ?? {};
      });
      _publishToController();

      for (var controller in expansionTileControllers) {
        try {
          controller.expand();
        } catch (e) {
          // ignore: avoid_print
          print('Error expanding tile: $e');
        }
      }
    } else if (widget.asyncListCallback != null) {
      _filterAsyncSeachableList(value);
    } else {
      setState(() {
        final fitered = widget.initialList
            .where(
              (item) =>
                  widget.searchableFields
                      ?.call(item)
                      .any((item) => item.toString().contains(value)) ==
                  true,
            )
            .toList();
        filtredListResult = fitered;
      });

      _publishToController();
    }
  }

  void _filterAsyncSeachableList(String value) {
    _publishToController();

    _debouncer!.run(() async {
      if (mounted) setState(() {});
      _activeOperation?.cancel();
      log('Filtering list with value: $value');

      await _asyncFilter(value);
      _publishToController();

      if (mounted) setState(() {});

      _publishToController();
    });
  }

  void _filterFromController(String query) {
    filterList(query);
    widget.searchTextController?.value = TextEditingValue(
      text: query,
      selection: TextSelection.collapsed(offset: query.length),
    );
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

  /// Builds and returns a SearchTextField widget with all necessary parameters
  Widget _buildSearchTextField() {
    return SearchTextField(
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
      validator: widget.fieldValidator,
      formFieldKey: widget.formFieldKey,
    );
  }

  Future<void> _asyncFilter(String value) async {
    if (widget.searchableFields != null) {
      final fitered = widget.initialList
          .where(
            (item) =>
                widget.searchableFields
                    ?.call(item)
                    .any((item) => item.toString().contains(value)) ==
                true,
          )
          .toList();
      filtredAsyncListResult = fitered;
    }

    if (isAsyncCallBackRunning) {
      // Wait for the initial list before filtering
      return;
    }

    final operation = CancelableOperation.fromFuture(
      widget.asyncListFilter!(value, asyncListResult),
    );
    _activeOperation = operation;

    try {
      final result = await operation.valueOrCancellation();
      if (result != null && !operation.isCanceled) {
        filtredAsyncListResult = result;
      }
    } catch (e) {
      if (!operation.isCanceled) {
        asyncError = true;
      }
    } finally {
      // Make sure to not interrupt another operation
      if (_activeOperation == operation) {
        _activeOperation = null;
      }
    }
  }

  Future<void> _asyncInitialList() async {
    isAsyncCallBackRunning = true;
    // First get the initial list
    try {
      final initialData = await widget.asyncListCallback!();
      if (initialData != null) {
        asyncListResult = initialData;
      } else {
        asyncError = true;
      }
    } catch (e) {
      asyncError = true;
      return;
    }
    isAsyncCallBackRunning = false;
    // Then check if a query was typed during the initial list loading to filter if needed
    if ((widget.searchTextController?.text ?? "") != "") {
      await _asyncFilter(widget.searchTextController!.text);
    } else {
      filtredAsyncListResult.clear();
      filtredAsyncListResult.addAll(asyncListResult);
    }
  }

  void _publishAfterFrame() {
    WidgetsBinding.instance.addPostFrameCallback((_) => _publishToController());
  }

  void _publishToController() {
    final controller = widget.controller;
    if (controller == null || !mounted) return;

    final isAsync = widget.asyncListCallback != null;

    final List<T> list;
    if (widget.isExpansionList) {
      list = widget.expansionListData.values.expand((e) => e).toList();
    } else if (isAsync) {
      list = filtredAsyncListResult;
    } else {
      list = filtredListResult;
    }

    final SearchableListStatus status;
    if (isAsync && asyncError) {
      status = SearchableListStatus.error;
    } else if (isAsync &&
        (_activeOperation != null || isAsyncCallBackRunning)) {
      status = SearchableListStatus.loading;
    } else if (list.isEmpty) {
      status = SearchableListStatus.empty;
    } else {
      status = SearchableListStatus.data;
    }

    controller.update(
      SearchableListValue<T>(
        query: searchText,
        results: List<T>.unmodifiable(list),
        status: status,
        scrollController: scrollController,
      ),
    );
  }
}
