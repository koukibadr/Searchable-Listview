import 'package:flutter_test/flutter_test.dart';
import 'package:material_ui/material_ui.dart';
import 'package:searchable_listview/searchable_listview.dart';

void main() {
  group("Checking searchable controller filter", () {
    testWidgets(
      '''
        Check basic controller search
      ''',
      (test) async {
        SearchableListController<String> controller =
            SearchableListController<String>();

        final intList = List.generate(
          11,
          (index) => "Item ${index.toString()}",
        );

        var basicAttributeList = SearchableList<String>(
          initialList: intList,
          itemBuilder: (item) => Text(item),
          filter: (query) =>
              intList.where((item) => item.contains(query)).toList(),
          controller: controller,
        );

        // The list uses a contains-based filter, so the initial render should show
        // the full list until the controller query narrows it.
        await test.pumpWidget(
          MaterialApp(
            home: Scaffold(body: Center(child: basicAttributeList)),
          ),
        );

        // Initial state: all items and the default search UI should be rendered.
        expect(find.byType(Text), findsNWidgets(11));
        expect(find.byType(TextField), findsOneWidget);
        expect(find.byIcon(Icons.search), findsOneWidget);

        controller.filter("Item");
        await test.pumpAndSettle();
        // The broad query still matches every item in the generated list.
        expect(find.byType(Text), findsNWidgets(11));

        controller.filter("10");
        await test.pumpAndSettle();
        // A single exact match should leave only the matching item in the list.
        expect(find.byType(Text), findsNWidgets(1));

        controller.filter("Item 0");
        await test.pumpAndSettle();
        // A focused query should also reduce the list to the exact matching item.
        expect(find.byType(Text), findsNWidgets(1));
      },
    );

    testWidgets(
      '''
        Check basic controller search with clear action
      ''',
      (test) async {
        SearchableListController<String> controller =
            SearchableListController<String>();

        final intList = List.generate(
          11,
          (index) => "Item ${index.toString()}",
        );

        var basicAttributeList = SearchableList<String>(
          initialList: intList,
          itemBuilder: (item) => Text(item),
          filter: (query) =>
              intList.where((item) => item.contains(query)).toList(),
          controller: controller,
        );

        // The widget keeps the full list when the query is cleared, so this test
        // validates the reset behavior after a filter is applied.
        await test.pumpWidget(
          MaterialApp(
            home: Scaffold(body: Center(child: basicAttributeList)),
          ),
        );

        // Initial state: the full dataset and search field should be displayed.
        expect(find.byType(Text), findsNWidgets(intList.length));
        expect(find.byType(TextField), findsOneWidget);
        expect(find.byIcon(Icons.search), findsOneWidget);

        controller.filter("Item");
        await test.pumpAndSettle();
        // A broad query still matches the list, so the full set should remain visible.
        expect(find.byType(Text), findsNWidgets(intList.length));

        controller.clear();
        await test.pumpAndSettle();
        // Clearing the controller should restore the unfiltered dataset.
        expect(find.byType(Text), findsNWidgets(intList.length));

        controller.filter("Item 20");
        await test.pumpAndSettle();
        // An unmatched query should leave the list empty.
        expect(find.byType(Text), findsNothing);
      },
    );

    testWidgets(
      '''
        Check basic controller search with value check
      ''',
      (test) async {
        SearchableListController<String> controller =
            SearchableListController<String>();

        final intList = List.generate(
          11,
          (index) => "Item ${index.toString()}",
        );

        var basicAttributeList = SearchableList<String>(
          initialList: intList,
          itemBuilder: (item) => Text(item),
          filter: (query) =>
              intList.where((item) => item.contains(query)).toList(),
          controller: controller,
        );

        // This test verifies that the controller keeps the latest query even when the
        // filter result becomes empty, which is the key behavior under repeated updates.
        await test.pumpWidget(
          MaterialApp(
            home: Scaffold(body: Center(child: basicAttributeList)),
          ),
        );

        // Initial state: the complete list and search field should be rendered.
        expect(find.byType(Text), findsNWidgets(intList.length));
        expect(find.byType(TextField), findsOneWidget);
        expect(find.byIcon(Icons.search), findsOneWidget);

        controller.filter("Item 1");
        controller.filter("Item 15");
        await test.pumpAndSettle();
        // Reapplying the filter with a non-matching query should clear the list but
        // retain the most recent search value.
        expect(find.byType(Text), findsNothing);
        expect(controller.value.query, equals("Item 15"));

        controller.clear();
        await test.pumpAndSettle();
        // Clearing the query should restore the full dataset.
        expect(find.byType(Text), findsNWidgets(intList.length));
      },
    );
  });
}
