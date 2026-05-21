import 'package:example/data/actor.dart';
import 'package:example/data/actors_data.dart';
import 'package:example/widgets/actor_item_widget.dart';
import 'package:example/widgets/empty_widget.dart';
import 'package:flutter/material.dart';
import 'package:searchable_listview/searchable_listview.dart';

class ExpansionSearchableListview extends StatelessWidget {
  const ExpansionSearchableListview({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SearchableList<Actor>.expansion(
      expansionListData: mapOfActors,
      expansionTitleBuilder: (p0) {
        return Container(
          color: Colors.grey[300],
          width: MediaQuery.of(context).size.width * 0.8,
          height: 30,
          child: Center(
            child: Text(p0.toString()),
          ),
        );
      },
      filterExpansionData: (p0) {
        final filteredMap = {
          for (final entry in mapOfActors.entries)
            entry.key: (mapOfActors[entry.key] ?? [])
                .where((element) => element.name.contains(p0))
                .toList()
        };
        return filteredMap;
      },
      textStyle: const TextStyle(fontSize: 25),
      expansionListBuilder: (int index, Actor _actor) {
        return ActorItem(
          actor: _actor,
        );
      },
      hideEmptyExpansionItems: true,
      emptyWidget: const EmptyView(),
      inputDecoration: InputDecoration(
        labelText: 'Search Actor',
        fillColor: Colors.white,
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(
            color: Colors.blue,
            width: 1.0,
          ),
          borderRadius: BorderRadius.circular(10.0),
        ),
      ),
    );
  }
}
