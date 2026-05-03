import 'package:flutter/material.dart';
import 'package:searchable_listview/searchable_listview.dart';

class ExampleExpansion extends StatelessWidget {
  const ExampleExpansion({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SearchableList.expansion(
        expansionListData: const {},
        expansionTitleBuilder: (context) {
          return const Text('Example Expansion');
        },
        filterExpansionData: filterFunction,
        expansionListBuilder: (_, __) {
          return const Text('Example Expansion Item');
        },
      ),
    );
  }

  Map<dynamic, List<dynamic>> filterFunction(String filter) {
    return {};
  }
}
