import 'package:flutter/foundation.dart';
import 'package:material_ui/material_ui.dart';

enum SearchableListStatus { idle, loading, data, empty, error }

class SearchableListValue<T> {
  SearchableListValue({
    this.query = '',
    List<T>? results,
    this.status = SearchableListStatus.idle,
    this.scrollController,
  }) : results = results ?? <T>[];

  final String query;
  final List<T> results;
  final SearchableListStatus status;
  final ScrollController? scrollController;

  bool get isLoading => status == SearchableListStatus.loading;
  bool get hasError => status == SearchableListStatus.error;
  double get scrollPosition => scrollController?.offset ?? 0.0;

  SearchableListValue<T> copyWith({
    String? query,
    List<T>? results,
    SearchableListStatus? status,
    ScrollController? scrollController,
  }) {
    return SearchableListValue<T>(
      query: query ?? this.query,
      results: results ?? this.results,
      status: status ?? this.status,
      scrollController: scrollController ?? this.scrollController,
    );
  }

  @override
  bool operator ==(Object other) =>
      other is SearchableListValue<T> &&
      other.query == query &&
      other.status == status &&
      listEquals(other.results, results);

  @override
  int get hashCode => Object.hash(query, status, Object.hashAll(results));
}
