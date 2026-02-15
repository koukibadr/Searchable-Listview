import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:searchable_listview/searchable_listview.dart';
import 'package:searchable_listview/resources/arrays.dart';

import 'dummies/dummy_list_item.dart';

void main() {
  group("Sliver SearchableList Tests", () {
    testWidgets('''
        Should display a sliver searchable listview with dummy list items.
        Checking default appearance with sliver constructor.
      ''', (test) async {
      final intList = List.generate(10, (index) => index);
      var sliverSearchableList = SearchableList<int>.sliver(
        initialList: intList,
        itemBuilder: (item) => DummyListItem(index: item),
        filter: (query) =>
            intList.where((item) => item.toString().contains(query)).toList(),
      );

      await test.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: sliverSearchableList,
          ),
        ),
      );

      // Initial assertions
      // Check that items and the search field are present
      expect(find.byType(DummyListItem), findsNWidgets(10));
      expect(find.byType(TextField), findsOneWidget);
      expect(find.byIcon(Icons.search), findsOneWidget);
    });

    testWidgets('''
        Should display a sliver searchable listview and filter correctly
        when a query is entered in the search field.
      ''', (test) async {
      final intList = List.generate(10, (index) => index);
      var sliverSearchableList = SearchableList<int>.sliver(
        initialList: intList,
        itemBuilder: (item) => DummyListItem(index: item),
        filter: (query) =>
            intList.where((item) => item.toString().contains(query)).toList(),
      );

      await test.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: sliverSearchableList,
          ),
        ),
      );

      // Initial assertions
      expect(find.text('Item 0'), findsOneWidget);
      expect(find.text('Item 5'), findsOneWidget);
      expect(find.byType(TextField), findsOneWidget);

      final searchField = find.byType(TextField);
      await test.enterText(searchField, '1');
      await test.pumpAndSettle();

      // Check that only the filtered item is present
      expect(find.text('Item 1'), findsOneWidget);
      expect(find.text('Item 0'), findsNothing);
      expect(find.byType(DummyListItem), findsOneWidget);

      await test.enterText(searchField, '5');
      await test.pumpAndSettle();

      expect(find.text('Item 5'), findsOneWidget);
      expect(find.text('Item 1'), findsNothing);
      expect(find.byType(DummyListItem), findsOneWidget);
    });

    testWidgets('''
        Should display sliver searchable listview with an empty initial list
        and show empty widget.
      ''', (test) async {
      final intList = List.generate(10, (index) => index);
      var sliverSearchableList = SearchableList<int>.sliver(
        initialList: <int>[],
        emptyWidget: const Text('No items found'),
        itemBuilder: (item) => DummyListItem(index: item),
        filter: (query) =>
            intList.where((item) => item.toString().contains(query)).toList(),
      );

      await test.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: sliverSearchableList,
          ),
        ),
      );

      // Initial assertions
      expect(find.byType(DummyListItem), findsNothing);
      expect(find.byType(TextField), findsOneWidget);
      expect(find.text('No items found'), findsOneWidget);
    });

    testWidgets('''
        Should display clear icon when text is entered in sliver searchable list.
      ''', (test) async {
      final intList = List.generate(10, (index) => index);
      var sliverSearchableList = SearchableList<int>.sliver(
        initialList: intList,
        displayClearIcon: true,
        itemBuilder: (item) => DummyListItem(index: item),
        filter: (query) =>
            intList.where((item) => item.toString().contains(query)).toList(),
      );

      await test.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: sliverSearchableList,
          ),
        ),
      );

      final searchField = find.byType(TextField);
      await test.enterText(searchField, '1');
      await test.pumpAndSettle();
      expect(find.byIcon(Icons.clear), findsOneWidget);
    });

    testWidgets('''
        Should clear the search field and reset the list when clear icon is tapped
        in sliver searchable list.
      ''', (test) async {
      final intList = List.generate(10, (index) => index);
      var sliverSearchableList = SearchableList<int>.sliver(
        initialList: intList,
        displayClearIcon: true,
        itemBuilder: (item) => DummyListItem(index: item),
        filter: (query) =>
            intList.where((item) => item.toString().contains(query)).toList(),
      );

      await test.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: sliverSearchableList,
          ),
        ),
      );

      final searchField = find.byType(TextField);
      await test.enterText(searchField, '1');
      await test.pumpAndSettle();
      await test.tap(find.byIcon(Icons.clear));
      await test.pumpAndSettle();

      expect(find.byIcon(Icons.clear), findsNothing);
      expect(find.byType(DummyListItem), findsNWidgets(10));
    });

    testWidgets('''
        Should display sliver searchable listview with custom input decoration.
      ''', (test) async {
      final intList = List.generate(10, (index) => index);
      var sliverSearchableList = SearchableList<int>.sliver(
        initialList: intList,
        inputDecoration: InputDecoration(
          labelText: 'Search Items',
          border: OutlineInputBorder(),
        ),
        itemBuilder: (item) => DummyListItem(index: item),
        filter: (query) =>
            intList.where((item) => item.toString().contains(query)).toList(),
      );

      await test.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: sliverSearchableList,
          ),
        ),
      );

      // Check custom input decoration
      expect(find.text('Search Items'), findsOneWidget);
      final searchField = find.byType(TextField);
      expect(
        test.widget<TextField>(searchField).decoration!.border
            is OutlineInputBorder,
        isTrue,
      );
    });

    testWidgets('''
        Should display sliver searchable listview with horizontal scroll direction.
      ''', (test) async {
      final intList = List.generate(10, (index) => index);
      var sliverSearchableList = SearchableList<int>.sliver(
        initialList: intList,
        scrollDirection: Axis.horizontal,
        itemBuilder: (item) => DummyListItem(index: item),
        filter: (query) =>
            intList.where((item) => item.toString().contains(query)).toList(),
      );

      await test.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: sliverSearchableList,
          ),
        ),
      );

      // Verify the widget is rendered
      expect(find.byType(DummyListItem), findsNWidgets(10));
      expect(find.byType(TextField), findsOneWidget);
      expect(find.byType(CustomScrollView), findsOneWidget);
    });

    testWidgets('''
        Should display sliver searchable listview with search field at bottom position.
      ''', (test) async {
      final intList = List.generate(10, (index) => index);
      var sliverSearchableList = SearchableList<int>.sliver(
        initialList: intList,
        searchTextPosition: SearchTextPosition.bottom,
        itemBuilder: (item) => DummyListItem(index: item),
        filter: (query) =>
            intList.where((item) => item.toString().contains(query)).toList(),
      );

      await test.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: sliverSearchableList,
          ),
        ),
      );

      // Verify the widget is rendered with search field
      expect(find.byType(DummyListItem), findsNWidgets(10));
      expect(find.byType(TextField), findsOneWidget);
      expect(find.byType(CustomScrollView), findsOneWidget);
    });

    testWidgets('''
        Should hide search field when showSearchField is false in sliver list.
      ''', (test) async {
      final intList = List.generate(10, (index) => index);
      var sliverSearchableList = SearchableList<int>.sliver(
        initialList: intList,
        showSearchField: false,
        itemBuilder: (item) => DummyListItem(index: item),
        filter: (query) =>
            intList.where((item) => item.toString().contains(query)).toList(),
      );

      await test.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: sliverSearchableList,
          ),
        ),
      );

      // Verify search field is not displayed
      expect(find.byType(TextField), findsNothing);
      expect(find.byType(DummyListItem), findsNWidgets(10));
    });

    testWidgets('''
        Should filter when initial list is non-empty but search yields no results
        in sliver list.
      ''', (test) async {
      final intList = List.generate(10, (index) => index);
      var sliverSearchableList = SearchableList<int>.sliver(
        initialList: intList,
        itemBuilder: (item) => DummyListItem(index: item),
        filter: (query) =>
            intList.where((item) => item.toString().contains(query)).toList(),
      );

      await test.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: sliverSearchableList,
          ),
        ),
      );

      // Initial assertions
      expect(find.text('Item 0'), findsOneWidget);
      expect(find.text('Item 5'), findsOneWidget);
      expect(find.byType(TextField), findsOneWidget);

      final searchField = find.byType(TextField);
      await test.enterText(searchField, '12');
      await test.pumpAndSettle();
      expect(find.byType(DummyListItem), findsNothing);
    });
  });
}
