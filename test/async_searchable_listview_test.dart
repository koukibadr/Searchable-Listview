import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:searchable_listview/searchable_listview.dart';

import 'dummies/dummy_list_item.dart';

void main() {
  group('''
      Checking default async searchable listview display
    ''', () {
    testWidgets('''
        Should display a searchable listview with dummy list items.
        checking default appearance.
      ''', (test) async {
      final intList = List.generate(10, (index) => index);
      var basicSearchableList = SearchableList<int>.async(
        asyncListCallback: () async => intList,
        itemBuilder: (item) => DummyListItem(index: item),
        asyncListFilter: (query, _) =>
            intList.where((item) => item.toString().contains(query)).toList(),
      );

      await test.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Center(
              child: basicSearchableList,
            ),
          ),
        ),
      );
      await test.pumpAndSettle();

      // Initial assertions
      // Check that some items and the search field are present
      expect(find.byType(DummyListItem), findsNWidgets(10));
      expect(find.byType(TextField), findsOneWidget);
      expect(find.byIcon(Icons.search), findsOneWidget);

      final searchField = find.byType(TextField);
      await test.enterText(searchField, '1');
      await test.pumpAndSettle();

      expect(find.byIcon(Icons.clear), findsOneWidget);
    });

    testWidgets('''
        Checking search field customization.
      ''', (test) async {
      final intList = List.generate(10, (index) => index);
      var basicSearchableList = SearchableList<int>.async(
        asyncListCallback: () async => intList,
        itemBuilder: (item) => DummyListItem(index: item),
        inputDecoration: InputDecoration(
          labelText: 'Search Items',
          border: OutlineInputBorder(),
        ),
        asyncListFilter: (query, _) =>
            intList.where((item) => item.toString().contains(query)).toList(),
      );

      await test.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Center(
              child: basicSearchableList,
            ),
          ),
        ),
      );
      await test.pumpAndSettle();

      // Initial assertions
      // Check that some items and the search field are present
      expect(find.text('Search Items'), findsOneWidget);
      final searchField = find.byType(TextField);
      expect(
        test.widget<TextField>(searchField).decoration!.border
            is OutlineInputBorder,
        isTrue,
      );
    });
  });

  group('''
    Async Searchable Listview Tests
  ''', () {
    testWidgets('''
        Should display a searchable listview with async data source.
      ''', (test) async {
      final intList = List.generate(10, (index) => index);
      var basicSearchableList = SearchableList<int>.async(
        asyncListCallback: () async => intList,
        itemBuilder: (item) => DummyListItem(index: item),
        asyncListFilter: (query, _) =>
            intList.where((item) => item.toString().contains(query)).toList(),
      );

      await test.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Center(
              child: basicSearchableList,
            ),
          ),
        ),
      );
      await test.pumpAndSettle();
      expect(find.text('Item 0'), findsOneWidget);
      expect(find.text('Item 5'), findsOneWidget);
      expect(find.byType(TextField), findsOneWidget);

      final searchField = find.byType(TextField);
      await test.enterText(searchField, '1');
      await test.pumpAndSettle();

      expect(find.text('Item 1'), findsOneWidget);
    });

    testWidgets('''
        Checking filter when search yields no results.
      ''', (test) async {
      final intList = List.generate(10, (index) => index);
      var basicSearchableList = SearchableList<int>.async(
        asyncListCallback: () async => intList,
        itemBuilder: (item) => DummyListItem(index: item),
        asyncListFilter: (query, _) =>
            intList.where((item) => item.toString().contains(query)).toList(),
      );

      await test.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Center(
              child: basicSearchableList,
            ),
          ),
        ),
      );
      await test.pumpAndSettle();

      final searchField = find.byType(TextField);
      await test.enterText(searchField, '12');
      await test.pumpAndSettle();
      expect(find.byType(DummyListItem), findsNothing);
    });

    testWidgets('''
        Checking filter with empty list.
      ''', (test) async {
      var basicSearchableList = SearchableList<int>.async(
        asyncListCallback: () async => [],
        itemBuilder: (item) => DummyListItem(index: item),
        asyncListFilter: (query, _) => [],
      );

      await test.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Center(
              child: basicSearchableList,
            ),
          ),
        ),
      );
      await test.pumpAndSettle();
      expect(find.byType(DummyListItem), findsNothing);

      final searchField = find.byType(TextField);
      await test.enterText(searchField, '1');
      await test.pumpAndSettle();
      expect(find.byType(DummyListItem), findsNothing);
    });

    testWidgets('''
        Checking custom empty widget when no results found.
      ''', (test) async {
      final intList = List.generate(10, (index) => index);
      var basicSearchableList = SearchableList<int>.async(
        asyncListCallback: () async => intList,
        itemBuilder: (item) => DummyListItem(index: item),
        emptyWidget: const Text('No items found'),
        asyncListFilter: (query, _) =>
            intList.where((item) => item.toString().contains(query)).toList(),
      );

      await test.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Center(
              child: basicSearchableList,
            ),
          ),
        ),
      );
      await test.pumpAndSettle();
      expect(find.byType(DummyListItem), findsNWidgets(10));

      final searchField = find.byType(TextField);
      await test.enterText(searchField, '99');
      await test.pumpAndSettle();
      expect(find.byType(DummyListItem), findsNothing);
      expect(find.text('No items found'), findsOneWidget);
    });
  });
}
