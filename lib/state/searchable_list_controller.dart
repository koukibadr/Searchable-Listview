class SearchableListController<T> {
  String _currentQuery = '';

  void updateQuery(String query) {
    _currentQuery = query;
  }

  void Function(String query)? _filterCallback;

  /// Whether a [SearchableList] is currently attached.
  bool get isAttached => _filterCallback != null;

  /// Filters the attached list with [query].
  /// Does nothing if no list is attached yet.
  void filter(String query) {
    _currentQuery = query;
    _filterCallback?.call(query);
  }

  /// Clears the filter of the attached list.
  /// if the current query is empty, the clear method does not trigger excessive rebuilds.
  void clear() {
    if (_filterCallback == null) return;
    if (_currentQuery.isNotEmpty) {
      _currentQuery = '';
      _filterCallback?.call('');
    }
  }

  /// Internal: called by the list's state. Not for app code.
  void attach(void Function(String query) callback) {
    _filterCallback = callback;
  }

  /// Internal: called by the list's state. Not for app code.
  void detach(void Function(String query) callback) {
    if (_filterCallback == callback) _filterCallback = null;
  }
}
