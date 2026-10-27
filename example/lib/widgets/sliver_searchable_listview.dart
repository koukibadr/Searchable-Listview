import 'package:example/data/actor.dart';
import 'package:example/data/actors_data.dart';
import 'package:example/feature_tweaks.dart';
import 'package:material_ui/material_ui.dart';
import 'package:searchable_listview/searchable_listview.dart';

class SliverSearchableListview extends StatelessWidget {
  const SliverSearchableListview({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final tweaks = SearchableListTweaksScope.of(context);
    return SearchableList<Actor>.sliver(
      filter: (query) => actors
          .where(
            (actor) => '${actor.name} ${actor.lastName}'
                .toLowerCase()
                .contains(query.toLowerCase()),
          )
          .toList(),
      initialList: actors,
      lazyLoadingEnabled: tweaks.value(
        SearchableListFeature.lazyLoadingEnabled,
        true,
      ),
      showSearchField: tweaks.value(
        SearchableListFeature.showSearchField,
        true,
      ),
      searchFieldEnabled: tweaks.value(
        SearchableListFeature.searchFieldEnabled,
        true,
      ),
      displaySearchIcon: tweaks.value(
        SearchableListFeature.displaySearchIcon,
        true,
      ),
      displayClearIcon: tweaks.value(
        SearchableListFeature.displayClearIcon,
        true,
      ),
      closeKeyboardWhenScrolling: tweaks.value(
        SearchableListFeature.closeKeyboardWhenScrolling,
        false,
      ),
      itemBuilder: (item) => ListTile(
        title: Text('${item.name} ${item.lastName}'),
      ),
    )..sliverScrollEffect =
        tweaks.value(SearchableListFeature.sliverScrollEffect, true);
  }
}
