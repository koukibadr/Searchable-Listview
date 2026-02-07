import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:searchable_listview/searchable_listview.dart';

void main() {
  group('ExpansionSearchableListView Display', () {
    testWidgets('''
        Veryfing expansion searchable listview default display
      ''', (test) async {
      final dataMap = {
        'Fruits': ['Apple', 'Banana', 'Orange'],
        'Vegetables': ['Carrot', 'Broccoli', 'Spinach'],
      };

      final expansionListView = SearchableList<String>.expansion(
        expansionListData: dataMap,
        expansionListBuilder: (expansionGroupIndex, listItem) {
          return ListTile(
            title: Text(listItem),
          );
        },
        expansionTitleBuilder: (header) {
          return Text(header);
        },
        filterExpansionData: (_) {
          return {};
        },
        initiallyExpanded: true,
      );

      await test.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Center(
              child: expansionListView,
            ),
          ),
        ),
      );

      expect(find.text('Fruits'), findsOneWidget);
      expect(find.text('Vegetables'), findsOneWidget);
      expect(find.text('Apple'), findsOneWidget);
      expect(find.text('Carrot'), findsOneWidget);

      final searchField = find.byType(TextField);
      await test.enterText(searchField, '2');
      await test.pumpAndSettle();

      expect(find.text('Apple'), findsNothing);
    });

    testWidgets('''
        Veryfing expansion searchable listview display when not expanded
      ''', (test) async {
      final dataMap = {
        'Fruits': ['Apple', 'Banana', 'Orange'],
        'Vegetables': ['Carrot', 'Broccoli', 'Spinach'],
      };

      final expansionListView = SearchableList<String>.expansion(
        expansionListData: dataMap,
        expansionListBuilder: (expansionGroupIndex, listItem) {
          return ListTile(
            title: Text(listItem),
          );
        },
        expansionTitleBuilder: (header) {
          return Text(header);
        },
        filterExpansionData: (_) {
          return {};
        },
      );

      await test.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Center(
              child: expansionListView,
            ),
          ),
        ),
      );

      expect(find.text('Fruits'), findsOneWidget);
      expect(find.text('Vegetables'), findsOneWidget);
      expect(find.text('Apple'), findsNothing);
      expect(find.text('Carrot'), findsNothing);
    });

    testWidgets('''
        Veryfing expansion searchable listview display and tap to expand
      ''', (test) async {
      final dataMap = {
        'Fruits': ['Apple', 'Banana', 'Orange'],
        'Vegetables': ['Carrot', 'Broccoli', 'Spinach'],
      };

      final expansionListView = SearchableList<String>.expansion(
        expansionListData: dataMap,
        expansionListBuilder: (expansionGroupIndex, listItem) {
          return ListTile(
            title: Text(listItem),
          );
        },
        expansionTitleBuilder: (header) {
          return Text(header);
        },
        filterExpansionData: (_) {
          return {};
        },
      );

      await test.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Center(
              child: expansionListView,
            ),
          ),
        ),
      );

      expect(find.text('Fruits'), findsOneWidget);
      expect(find.text('Vegetables'), findsOneWidget);

      final fruitsHeader = find.text('Fruits');
      await test.tap(fruitsHeader);
      await test.pumpAndSettle();

      expect(find.text('Apple'), findsOneWidget);
    });

    testWidgets('''
        Veryifing empty widget display when search yields no results
      ''', (test) async {
      final dataMap = {
        'Fruits': ['Apple', 'Banana', 'Orange'],
        'Vegetables': ['Carrot', 'Broccoli', 'Spinach'],
      };

      final expansionListView = SearchableList<String>.expansion(
        expansionListData: dataMap,
        expansionListBuilder: (expansionGroupIndex, listItem) {
          return ListTile(
            title: Text(listItem),
          );
        },
        expansionTitleBuilder: (header) {
          return Text(header);
        },
        filterExpansionData: (_) {
          return {};
        },
        emptyWidget: const Text('No items found'),
      );

      await test.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Center(
              child: expansionListView,
            ),
          ),
        ),
      );

      expect(find.text('Fruits'), findsOneWidget);
      expect(find.text('Vegetables'), findsOneWidget);

      final searchField = find.byType(TextField);
      await test.enterText(searchField, '2');
      await test.pumpAndSettle();

      expect(find.text('Apple'), findsNothing);
      expect(find.text('No items found'), findsOneWidget);
    });
  });
}
