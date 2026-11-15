import 'package:material_ui/material_ui.dart';
import 'package:searchable_listview/resources/arrays.dart';
import 'package:searchable_listview/searchable_listview.dart';

class BigSearchableListview extends StatefulWidget {
  const BigSearchableListview({Key? key}) : super(key: key);

  @override
  State<BigSearchableListview> createState() =>
      _BigSearchableListviewState();
}

class _BigSearchableListviewState
    extends State<BigSearchableListview> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          Expanded(
            child: SearchableList<String>(
              itemBuilder: (item) {
                return Text(item);
              },
              initialList: List.generate(11, (t) => "Item ${t.toString()}"),
              searchableFields: (p0) => [p0],
              searchStrategy: SearchStrategy.endsWith,
            ),
          ),
        ],
      ),
    );
  }
}
