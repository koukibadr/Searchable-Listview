import 'package:example/data/actor.dart';
import 'package:example/data/actors_data.dart';
import 'package:example/widgets/actor_item_widget.dart';
import 'package:material_ui/material_ui.dart';
import 'package:searchable_listview/resources/arrays.dart';
import 'package:searchable_listview/searchable_listview.dart';

class AttributeSearchableListview extends StatelessWidget {
  const AttributeSearchableListview({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          Expanded(
            child: SearchableList<Actor>(
              itemBuilder: (item) {
                return ActorItem(actor: item);
              },
              initialList: actors,
              searchableFields: (p0) => [p0.name],
              searchStrategy: SearchStrategy.endsWith,
            ),
          ),
        ],
      ),
    );
  }
}
