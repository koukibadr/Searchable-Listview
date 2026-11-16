import 'package:flutter_test/flutter_test.dart';
import 'package:material_ui/material_ui.dart';
import 'package:searchable_listview/resources/arrays.dart';
import 'package:searchable_listview/searchable_listview.dart';

import 'dummies/dummy_student_item.dart';
import 'mock/student_class.dart';

void main() {
  group("Verifying all the search strategies", () {
    testWidgets(
      '''
        Check basic attribute search
      ''',
      (test) async {
        final intList = List.generate(
          11,
          (index) => "Item ${index.toString()}",
        );
        var basicAttributeList = SearchableList<String>(
          initialList: intList,
          itemBuilder: (item) => Text(item),
          searchableFields: (p0) => [p0],
        );

        // Empty search strategy will use the "startWith" algorithm
        await test.pumpWidget(
          MaterialApp(
            home: Scaffold(body: Center(child: basicAttributeList)),
          ),
        );

        // Initial assertions

        // Check that some items and the search field are present
        expect(find.byType(Text), findsNWidgets(11));
        expect(find.byType(TextField), findsOneWidget);
        expect(find.byIcon(Icons.search), findsOneWidget);

        final searchField = find.byType(TextField);
        await test.enterText(searchField, '1');
        await test.pumpAndSettle();

        // there's no item starting with "1" since the strategy is set to startWith
        expect(find.byType(Text), findsNothing);

        await test.enterText(searchField, 'Item');
        await test.pumpAndSettle();

        // All the items start with "Item"
        expect(find.byType(Text), findsNWidgets(11));

        await test.enterText(searchField, 'Item 1');
        await test.pumpAndSettle();

        // Only "Item 1" and "Item 10" start with "Item 1"
        expect(find.byType(Text), findsNWidgets(2));
      },
    );

    testWidgets(
      '''
        Testing contain search strategy
      ''',
      (test) async {
        final intList = List.generate(
          11,
          (index) => "Item ${index.toString()}",
        );
        var basicAttributeList = SearchableList<String>(
          initialList: intList,
          itemBuilder: (item) => Text(item),
          searchableFields: (p0) => [p0],
          searchStrategy: SearchStrategy.contain,
        );

        await test.pumpWidget(
          MaterialApp(
            home: Scaffold(body: Center(child: basicAttributeList)),
          ),
        );

        // Initial assertions

        // Check that some items and the search field are present
        expect(find.byType(Text), findsNWidgets(11));
        expect(find.byType(TextField), findsOneWidget);
        expect(find.byIcon(Icons.search), findsOneWidget);

        final searchField = find.byType(TextField);
        await test.enterText(searchField, '88');
        await test.pumpAndSettle();

        // There's no item contains "88"
        expect(find.byType(Text), findsNothing);

        await test.enterText(searchField, 'Item');
        await test.pumpAndSettle();

        // All the items contains "Item"
        expect(find.byType(Text), findsNWidgets(11));

        await test.enterText(searchField, '1');
        await test.pumpAndSettle();

        // Only "Item 1" and "Item 10" contains the character "1"
        expect(find.byType(Text), findsNWidgets(2));
      },
    );

    testWidgets(
      '''
        Testing the endsWith strategy
      ''',
      (test) async {
        final intList = List.generate(
          11,
          (index) => "Item ${index.toString()}",
        );
        var basicAttributeList = SearchableList<String>(
          initialList: intList,
          itemBuilder: (item) => Text(item),
          searchableFields: (p0) => [p0],
          searchStrategy: SearchStrategy.endsWith,
        );

        await test.pumpWidget(
          MaterialApp(
            home: Scaffold(body: Center(child: basicAttributeList)),
          ),
        );

        // Initial assertions

        // Check that some items and the search field are present
        expect(find.byType(Text), findsNWidgets(11));
        expect(find.byType(TextField), findsOneWidget);
        expect(find.byIcon(Icons.search), findsOneWidget);

        final searchField = find.byType(TextField);
        await test.enterText(searchField, 'Item');
        await test.pumpAndSettle();

        // There's no item ends with "Item"
        expect(find.byType(Text), findsNothing);

        await test.enterText(searchField, '0');
        await test.pumpAndSettle();

        // Only the items "Item 0" and "Item 10" ends with a 0
        expect(find.byType(Text), findsNWidgets(2));

        await test.enterText(searchField, '3');
        await test.pumpAndSettle();

        // Only "Item 3" ends with the character "3"
        expect(find.byType(Text), findsNWidgets(1));
      },
    );
  });

  group("Checking custom model with attribute searching", () {
    testWidgets(
      '''
        Basic custom model attribute searching, filtering with name and lastname
      ''',
      (test) async {
        var basicStudentList = SearchableList<Student>(
          initialList: students,
          itemBuilder: (item) => DummyStudentItem(item: item),
          searchableFields: (p0) => [p0.name, p0.lastname],
        );

        // Empty search strategy will use the "startWith" algorithm
        await test.pumpWidget(
          MaterialApp(
            home: Scaffold(body: Center(child: basicStudentList)),
          ),
        );

        // Initial assertions

        // Check that some items and the search field are present
        expect(find.byType(TextField), findsOneWidget);
        expect(find.byIcon(Icons.search), findsOneWidget);

        final searchField = find.byType(TextField);
        await test.enterText(searchField, 'Badr');
        await test.pumpAndSettle();

        // there's no item starting with "1" since the strategy is set to startWith
        expect(find.byType(DummyStudentItem), findsNothing);

        await test.enterText(searchField, 'Tor');
        await test.pumpAndSettle();

        // All the items start with "Torvik"
        expect(find.byType(DummyStudentItem), findsNWidgets(1));

        await test.enterText(searchField, 'Wil');
        await test.pumpAndSettle();

        // Only "Item 1" and "Item 10" start with "Item 1"
        expect(find.byType(DummyStudentItem), findsNWidgets(1));
      },
    );

    testWidgets(
      ''' 
        Custom model filtering with custom search strategy
      ''',
      (test) async {
        var basicStudentList = SearchableList<Student>(
          initialList: students,
          itemBuilder: (item) => DummyStudentItem(item: item),
          searchableFields: (p0) => [p0.name, p0.lastname],
          searchStrategy: SearchStrategy.contain,
        );

        // Contain search matches text anywhere in the selected fields.
        await test.pumpWidget(
          MaterialApp(
            home: Scaffold(body: Center(child: basicStudentList)),
          ),
        );

        // Initial assertions

        // Check that some items and the search field are present
        expect(find.byType(TextField), findsOneWidget);
        expect(find.byIcon(Icons.search), findsOneWidget);

        final searchField = find.byType(TextField);
        await test.enterText(searchField, 'Badr');
        await test.pumpAndSettle();

        // No student's name or lastname contains "Badr".
        expect(find.byType(DummyStudentItem), findsNothing);

        await test.enterText(searchField, 'Tor');
        await test.pumpAndSettle();

        // Two students have "Tor" in their name or lastname.
        expect(find.byType(DummyStudentItem), findsNWidgets(2));

        await test.enterText(searchField, 'ON');
        await test.pumpAndSettle();

        // No students have "ON" in their name or lastname.
        expect(find.byType(DummyStudentItem), findsNWidgets(0));

        await test.enterText(searchField, 'K');
        await test.pumpAndSettle();

        // Two students have "K" in their name or lastname.
        expect(find.byType(DummyStudentItem), findsNWidgets(2));
      },
    );
  });
}
