import 'package:flutter/foundation.dart';
import 'package:searchable_listview/state/searchable_list_value.dart';

class SearchableListController<T>
    extends ValueNotifier<SearchableListValue<T>> {
  SearchableListController({String initialQuery = ''})
      : super(SearchableListValue<T>(query: initialQuery));

  void Function(String query)? _filterCallback;

  String get query => value.query;
  List<T> get results => value.results;
  SearchableListStatus get status => value.status;

  /// Whether a [SearchableList] is currently attached.
  bool get isAttached => _filterCallback != null;

  /// Filters the attached list with [query].
  /// Does nothing if no list is attached yet.
  void filter(String query) => _filterCallback?.call(query);

  /// Clears the filter. Does nothing if the query is already empty.
  void clear() {
    if (value.query.isEmpty) return;
    filter('');
  }

  /// Internal: called by the list's state. Not for app code.
  void attach(void Function(String query) callback) {
    _filterCallback = callback;
  }

  /// Internal: called by the list's state. Not for app code.
  void detach(void Function(String query) callback) {
    if (_filterCallback == callback) _filterCallback = null;
  }

  /// Internal: called by the list's state to publish a new snapshot.
  void update(SearchableListValue<T> newValue) => value = newValue;
}