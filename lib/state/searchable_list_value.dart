import 'package:flutter/foundation.dart';

enum SearchableListStatus { idle, loading, data, empty, error }

class SearchableListValue<T> {
  SearchableListValue({
    this.query = '',
    List<T>? results,
    this.status = SearchableListStatus.idle,
  }) : results = results ?? <T>[];

  final String query;
  final List<T> results;
  final SearchableListStatus status;

  bool get isLoading => status == SearchableListStatus.loading;
  bool get hasError => status == SearchableListStatus.error;

  SearchableListValue<T> copyWith({
    String? query,
    List<T>? results,
    SearchableListStatus? status,
  }) {
    return SearchableListValue<T>(
      query: query ?? this.query,
      results: results ?? this.results,
      status: status ?? this.status,
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
