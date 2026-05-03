import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:searchable_listview/searchable_listview.dart';

import 'dummies/dummy_list_item.dart';

void main() {
  group("Check widget appearance", () {
    testWidgets('''
        Should display a searchable listview with dummy list items.
        checking default appearance.
      ''', (test) async {
      final intList = List.generate(10, (index) => index);
      var basicSearchableList = SearchableList<int>(
        initialList: intList,
        itemBuilder: (item) => DummyListItem(index: item),
        filter: (query) => intList.where((item) => item.toString().contains(query)).toList(),
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
      var basicSearchableList = SearchableList<int>(
        initialList: intList,
        inputDecoration: InputDecoration(
          labelText: 'Search Items',
          border: OutlineInputBorder(),
        ),
        itemBuilder: (item) => DummyListItem(index: item),
        filter: (query) => intList.where((item) => item.toString().contains(query)).toList(),
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

      // Initial assertions
      // Check that some items and the search field are present
      expect(find.text('Search Items'), findsOneWidget);
      final searchField = find.byType(TextField);
      expect(
        test.widget<TextField>(searchField).decoration!.border is OutlineInputBorder,
        isTrue,
      );
    });

    testWidgets('''
        Should display a searchable listview with an empty initial list
        and show no items initially.
      ''', (test) async {
      final intList = List.generate(10, (index) => index);
      var basicSearchableList = SearchableList<int>(
        initialList: <int>[],
        emptyWidget: const Text('No items found'),
        itemBuilder: (item) => DummyListItem(index: item),
        filter: (query) => intList.where((item) => item.toString().contains(query)).toList(),
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

      // Initial assertions
      // Check that some items and the search field are present
      expect(find.byType(DummyListItem), findsNothing);
      expect(find.byType(TextField), findsOneWidget);
      expect(find.text('No items found'), findsOneWidget);
    });
  });
  group("Check search behavior", () {
    testWidgets('''
        Should display a searchable listview with dummy list items and filter correctly
        when a query is entered in the search field.
      ''', (test) async {
      final intList = List.generate(10, (index) => index);
      var basicSearchableList = SearchableList<int>(
        initialList: intList,
        itemBuilder: (item) => DummyListItem(index: item),
        filter: (query) => intList.where((item) => item.toString().contains(query)).toList(),
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
      // Initial assertions
      // Check that some items and the search field are present
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
        Checking filter when initial list is non-empty but search yields no results.
      ''', (test) async {
      final intList = List.generate(10, (index) => index);
      var basicSearchableList = SearchableList<int>(
        initialList: intList,
        itemBuilder: (item) => DummyListItem(index: item),
        filter: (query) => intList.where((item) => item.toString().contains(query)).toList(),
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
      // Initial assertions
      // Check that some items and the search field are present
      expect(find.text('Item 0'), findsOneWidget);
      expect(find.text('Item 5'), findsOneWidget);
      expect(find.byType(TextField), findsOneWidget);

      final searchField = find.byType(TextField);
      await test.enterText(searchField, '12');
      await test.pumpAndSettle();
      expect(find.byType(DummyListItem), findsNothing);
    });

    testWidgets('''
        Checking filter when initial list is empty and search yields no results.
      ''', (test) async {
      final intList = List.generate(10, (index) => index);
      var basicSearchableList = SearchableList<int>(
        initialList: <int>[],
        itemBuilder: (item) => DummyListItem(index: item),
        filter: (query) => intList.where((item) => item.toString().contains(query)).toList(),
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
      // Initial assertions
      // Check that some items and the search field are present
      expect(find.text('Item 0'), findsNothing);
      expect(find.text('Item 5'), findsNothing);
      expect(find.byType(TextField), findsOneWidget);

      final searchField = find.byType(TextField);
      await test.enterText(searchField, '12');
      await test.pumpAndSettle();
      expect(find.byType(DummyListItem), findsNothing);
    });

    testWidgets('''
        Checking filter with case sensitivity.
      ''', (test) async {
      final stringList = List.generate(10, (index) => 'Item $index');
      var basicSearchableList = SearchableList<String>(
        initialList: stringList,
        itemBuilder: (item) => Text(item),
        filter: (query) => stringList.where((item) => item.toString().contains(query)).toList(),
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
      // Initial assertions
      // Check that some items and the search field are present
      expect(find.text('Item 0'), findsOneWidget);
      expect(find.text('Item 5'), findsOneWidget);

      final searchField = find.byType(TextField);
      await test.enterText(searchField, '12');
      await test.pumpAndSettle();
      expect(find.byType(Text), findsNothing);

      await test.enterText(searchField, 'item 1');
      await test.pumpAndSettle();
      expect(find.byType(Text), findsNothing);

      await test.enterText(searchField, 'Item 1');
      await test.pumpAndSettle();
      expect(find.byType(Text), findsOneWidget);

      await test.enterText(searchField, 'Item');
      await test.pumpAndSettle();
      expect(find.byType(Text), findsNWidgets(10));
    });
  });

  group("Check clear icon functionality", () {
    testWidgets('''
        Should display a searchable listview with clear icon functionality.
      ''', (test) async {
      final intList = List.generate(10, (index) => index);
      var basicSearchableList = SearchableList<int>(
        initialList: intList,
        displayClearIcon: true,
        itemBuilder: (item) => DummyListItem(index: item),
        filter: (query) => intList.where((item) => item.toString().contains(query)).toList(),
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

      final searchField = find.byType(TextField);
      await test.enterText(searchField, '1');
      await test.pumpAndSettle();
      expect(find.byIcon(Icons.clear), findsOneWidget);
    });

    testWidgets('''
        Should clear the search field and reset the list when the clear icon is tapped.
      ''', (test) async {
      final intList = List.generate(10, (index) => index);
      var basicSearchableList = SearchableList<int>(
        initialList: intList,
        displayClearIcon: true,
        itemBuilder: (item) => DummyListItem(index: item),
        filter: (query) => intList.where((item) => item.toString().contains(query)).toList(),
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

      final searchField = find.byType(TextField);
      await test.enterText(searchField, '1');
      await test.pumpAndSettle();
      await test.tap(find.byIcon(Icons.clear));
      await test.pumpAndSettle();

      expect(find.byIcon(Icons.clear), findsNothing);
      expect(find.byType(DummyListItem), findsNWidgets(10));
    });
  });

  group(
    """"
  Verifying form validation and form key behavior
""",
    () {
      testWidgets("", (tester) async {
        final intList = List.generate(3, (index) => index);
        final formKey = GlobalKey<FormState>();
        var basicSearchableList = SearchableList<int>(
          initialList: intList,
          displayClearIcon: true,
          itemBuilder: (item) => DummyListItem(index: item),
          filter: (query) => intList.where((item) => item.toString().contains(query)).toList(),
          fieldValidator: (value) {
            if (value == null || value.isEmpty) {
              return 'Search field cannot be empty';
            }
            return null;
          },
          formFieldKey: formKey,
        );

        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: Column(
                children: [
                  Expanded(child: basicSearchableList),
                  ElevatedButton(
                    onPressed: () {
                      if (formKey.currentState!.validate()) {
                        // If the form is valid, the valid elements will show automatically.
                      } else {
                        ScaffoldMessenger.of(tester.element(find.byType(ElevatedButton))).showSnackBar(
                          const SnackBar(
                            content: Text('Please fix the errors in the search field'),
                            duration: Duration(seconds: 1),
                          ),
                        );
                      }
                    },
                    child: Text('Submit'),
                  ),
                ],
              ),
            ),
          ),
        );

        final submitButton = find.byType(ElevatedButton);

        expect(find.byType(TextField), findsOneWidget);

        // Try submitting empty search query
        await tester.enterText(find.byType(TextField), '');
        await tester.tap(submitButton);
        await tester.pumpAndSettle();

        // Check for validation error message
        expect(find.text('Please fix the errors in the search field'), findsOneWidget);

        await tester.pumpAndSettle(const Duration(seconds: 2));
        // Enter valid search query
        await tester.enterText(find.byType(TextField), '1');
        await tester.tap(submitButton);
        await tester.pumpAndSettle();

        // Check that validation error message is gone and results are shown
        expect(find.text('Please fix the errors in the search field'), findsNothing);
        expect(find.text('Item 1'), findsOneWidget);
      });
    },
  );
}
