import 'package:example/data/actor.dart';
import 'package:example/data/actors_data.dart';
import 'package:example/feature_tweaks.dart';
import 'package:example/widgets/actor_item_widget.dart';
import 'package:material_ui/material_ui.dart';
import 'package:searchable_listview/searchable_listview.dart';

class BasicSearchableListview extends StatefulWidget {
  const BasicSearchableListview({Key? key}) : super(key: key);

  @override
  State<BasicSearchableListview> createState() =>
      _BasicSearchableListviewState();
}

class _BasicSearchableListviewState extends State<BasicSearchableListview> {
  List<Actor> filteredActors = [];
  final TextEditingController _searchTextController = TextEditingController();

  @override
  void initState() {
    super.initState();
    filteredActors = actors;
  }

  @override
  void dispose() {
    _searchTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final tweaks = SearchableListTweaksScope.of(context);
    return SearchableList<Actor>(
      searchTextController: _searchTextController,
      textAlignVertical: TextAlignVertical.center,
      searchFieldHeight: 40,
      lazyLoadingEnabled:
          tweaks.value(SearchableListFeature.lazyLoadingEnabled, false),
      showSearchField:
          tweaks.value(SearchableListFeature.showSearchField, true),
      searchFieldEnabled:
          tweaks.value(SearchableListFeature.searchFieldEnabled, true),
      displaySearchIcon:
          tweaks.value(SearchableListFeature.displaySearchIcon, true),
      displayClearIcon:
          tweaks.value(SearchableListFeature.displayClearIcon, true),
      closeKeyboardWhenScrolling:
          tweaks.value(SearchableListFeature.closeKeyboardWhenScrolling, false),
      shrinkWrap: tweaks.value(SearchableListFeature.shrinkWrap, false),
      reverse: tweaks.value(SearchableListFeature.reverse, false),
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
          ),
        ],
      ),
      filter: (query) {
        filteredActors = actors
            .where(
              (element) =>
                  element.name.toLowerCase().contains(query.toLowerCase()) ||
                  element.lastName.toLowerCase().contains(query.toLowerCase()),
            )
            .toList();
        return filteredActors;
      },
      initialList: actors,
    );
  }
}
