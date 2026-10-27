import 'package:flutter/material.dart';

enum SearchableListFeature {
  showSearchField,
  searchFieldEnabled,
  displaySearchIcon,
  displayClearIcon,
  lazyLoadingEnabled,
  closeKeyboardWhenScrolling,
  shrinkWrap,
  reverse,
  sliverScrollEffect,
  hideEmptyExpansionItems,
  expansionTileEnabled,
  initiallyExpanded,
}

class SearchableListTweaks extends ChangeNotifier {
  final Map<SearchableListFeature, bool> _overrides = {};

  bool value(SearchableListFeature feature, bool defaultValue) {
    return _overrides[feature] ?? defaultValue;
  }

  void setValue(SearchableListFeature feature, bool value) {
    if (_overrides[feature] == value) {
      return;
    }
    _overrides[feature] = value;
    notifyListeners();
  }
}

class SearchableListTweaksScope
    extends InheritedNotifier<SearchableListTweaks> {
  const SearchableListTweaksScope({
    Key? key,
    required SearchableListTweaks notifier,
    required Widget child,
  }) : super(key: key, notifier: notifier, child: child);

  static SearchableListTweaks of(BuildContext context) {
    final scope =
        context.dependOnInheritedWidgetOfExactType<SearchableListTweaksScope>();
    assert(
      scope != null,
      'SearchableListTweaksScope is missing from the tree.',
    );
    return scope!.notifier!;
  }
}
