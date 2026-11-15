import 'package:example/data/actor.dart';
import 'package:example/data/actors_data.dart';
import 'package:example/widgets/actor_item_widget.dart';
import 'package:material_ui/material_ui.dart';
import 'package:searchable_listview/resources/arrays.dart';
import 'package:searchable_listview/searchable_listview.dart';

class AttributeSearchableListview extends StatefulWidget {
  const AttributeSearchableListview({Key? key}) : super(key: key);

  @override
  State<AttributeSearchableListview> createState() =>
      _AttributeSearchableListviewState();
}

class _AttributeSearchableListviewState
    extends State<AttributeSearchableListview> {
  final SearchableListController<Actor> _controller =
      SearchableListController<Actor>();
  SearchStrategy _searchStrategy = SearchStrategy.endsWith;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          Align(
            alignment: Alignment.centerRight,
            child: SizedBox(
              height: 40,
              child: DropdownButton<SearchStrategy>(
                value: _searchStrategy,
                items: const [
                  DropdownMenuItem(
                    value: SearchStrategy.contain,
                    child: Text('contain'),
                  ),
                  DropdownMenuItem(
                    value: SearchStrategy.endsWith,
                    child: Text('endsWith'),
                  ),
                  DropdownMenuItem(
                    value: SearchStrategy.startsWith,
                    child: Text('startWith'),
                  ),
                ],
                onChanged: (strategy) {
                  if (strategy == null) return;
                  setState(() => _searchStrategy = strategy);
                  _controller.updateSearchStrategy(strategy);
                },
              ),
            ),
          ),
          Expanded(
            child: SearchableList<Actor>(
              controller: _controller,
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
