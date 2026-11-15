import 'package:searchable_listview/resources/arrays.dart';

extension StringExtension on String {
  bool search(SearchStrategy strategy, String query) {
    switch (strategy) {
      case SearchStrategy.contain:
        return toLowerCase().contains(query.toLowerCase());
      case SearchStrategy.endsWith:
        return toLowerCase().endsWith(query.toLowerCase());
      case SearchStrategy.startsWith:
        return toLowerCase().startsWith(query.toLowerCase());
      default:
        return false;
    }
  }
}
