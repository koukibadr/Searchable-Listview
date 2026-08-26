import 'package:example/data/actor.dart';
import 'package:example/data/actors_data.dart';
import 'package:material_ui/material_ui.dart';
import 'package:searchable_listview/searchable_listview.dart';

class SliverSearchableListview extends StatelessWidget {
  const SliverSearchableListview({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SearchableList<Actor>.sliver(
      filter: (query) => actors
          .where((actor) => '${actor.name} ${actor.lastName}'
              .toLowerCase()
              .contains(query.toLowerCase()))
          .toList(),
      initialList: actors,
      itemBuilder: (item) => ListTile(
        title: Text('${item.name} ${item.lastName}'),
      ),
    );
  }
}
