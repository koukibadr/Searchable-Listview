class SearchableListController<T> {
  void Function(String query)? _filterCallback;

  /// Whether a [SearchableList] is currently attached.
  bool get isAttached => _filterCallback != null;

  /// Filters the attached list with [query].
  /// Does nothing if no list is attached yet.
  void filter(String query) => _filterCallback?.call(query);

  /// Internal: called by the list's state. Not for app code.
  void attach(void Function(String query) callback) {
    _filterCallback = callback;
  }

  /// Internal: called by the list's state. Not for app code.
  void detach(void Function(String query) callback) {
    if (_filterCallback == callback) _filterCallback = null;
  }
}
