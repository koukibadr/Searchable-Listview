import 'package:example/data/actor.dart';
import 'package:example/data/actors_data.dart';
import 'package:example/widgets/actor_item_widget.dart';
import 'package:flutter/material.dart';
import 'package:searchable_listview/searchable_listview.dart';

class BasicSearchableListview extends StatefulWidget {
  const BasicSearchableListview({Key? key}) : super(key: key);

  @override
  State<BasicSearchableListview> createState() => _BasicSearchableListviewState();
}

class _BasicSearchableListviewState extends State<BasicSearchableListview> {
  List<Actor> filteredActors = [];

  @override
  void initState() {
    super.initState();
    filteredActors = actors;
  }

  @override
  Widget build(BuildContext context) {
    return SearchableList<Actor>(
      textAlignVertical: TextAlignVertical.center,
      searchFieldHeight: 40,
      lazyLoadingEnabled: false,
      separatorBuilder: (context, index) {
        return Container(
          height: 40,
        );
      },
      sortPredicate: (a, b) => a.age.compareTo(b.age),
      itemBuilder: (item) {
        int index = filteredActors.indexOf(item);
        if (index == 0) {
          return Container(
            color: Colors.red,
            height: 10,
            width: 300,
          );
        } else {
          return ActorItem(actor: filteredActors[index - 1]);
        }
      },
      emptyWidget: Column(
        children: [
          Container(
            color: Colors.red,
            height: 10,
            width: 300,
          ),
          const Column(
            children: [Icon(Icons.error), Text('No Data found')],
          )
        ],
      ),
      filter: (query) {
        filteredActors = actors
            .where((element) =>
                element.name.toLowerCase().contains(query.toLowerCase()) ||
                element.lastName.toLowerCase().contains(query.toLowerCase()))
            .toList();
        return filteredActors;
      },
      initialList: actors,
    );
  }
}
