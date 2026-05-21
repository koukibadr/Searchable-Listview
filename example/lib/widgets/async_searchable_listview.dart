import 'package:example/data/actor.dart';
import 'package:example/data/actors_data.dart';
import 'package:example/widgets/actor_item_widget.dart';
import 'package:example/widgets/empty_widget.dart';
import 'package:flutter/material.dart';
import 'package:searchable_listview/searchable_listview.dart';

class AsyncSearchableListview extends StatelessWidget {
  const AsyncSearchableListview({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SearchableList<Actor>.async(
      itemBuilder: (Actor item) {
        return ActorItem(actor: item);
      },
      asyncListCallback: () async {
        await Future.delayed(const Duration(seconds: 5));
        return actors;
      },
      asyncListFilter: (query, list) async {
        await Future.delayed(const Duration(seconds: 3));
        var result = actors
            .where((element) =>
                element.name.contains(query) ||
                element.lastName.contains(query))
            .toList();
        return result;
      },
      asyncDebounceTime: 200,
      separatorBuilder: (context, index) {
        return Container(
          height: 30,
        );
      },
      textStyle: const TextStyle(fontSize: 25),
      emptyWidget: const EmptyView(),
      loadingWidget: const Center(
        child: CircularProgressIndicator(),
      ),
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
