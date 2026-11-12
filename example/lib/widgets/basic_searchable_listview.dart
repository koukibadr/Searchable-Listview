import 'package:example/data/actor.dart';
import 'package:example/data/actors_data.dart';
import 'package:example/feature_tweaks.dart';
import 'package:example/widgets/actor_item_widget.dart';
import 'package:material_ui/material_ui.dart';
import 'package:searchable_listview/searchable_listview.dart';
import 'package:searchable_listview/state/searchable_list_value.dart';

class BasicSearchableListview extends StatefulWidget {
  const BasicSearchableListview({Key? key}) : super(key: key);

  @override
  State<BasicSearchableListview> createState() =>
      _BasicSearchableListviewState();
}

class _BasicSearchableListviewState extends State<BasicSearchableListview> {
  List<Actor> filteredActors = [];

  final TextEditingController _searchTextController = TextEditingController();
  final SearchableListController<Actor> controller =
      SearchableListController<Actor>();

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
    return SafeArea(
      child: Column(
        children: [

          ValueListenableBuilder<SearchableListValue<Actor>>(
            valueListenable: controller,
            builder: (context, value, _) {
              if (value.isLoading) return const Text('Searching...');
              return Text(
                '${value.results.length} results for "${value.query}"',
              );
            },
          ),

          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: actors
                  .map(
                    (actor) => Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ActionChip(
                        onPressed: () {
                          controller.filter(actor.name);
                        },
                        label: Text(actor.name),
                      ),
                    ),
                  )
                  .toList(),
            ),
          ),
          Expanded(
            child: SearchableList<Actor>(
              controller: controller,
              searchTextController: _searchTextController,
              textAlignVertical: TextAlignVertical.center,
              searchFieldHeight: 40,
              lazyLoadingEnabled: tweaks.value(
                SearchableListFeature.lazyLoadingEnabled,
                false,
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
              shrinkWrap: tweaks.value(SearchableListFeature.shrinkWrap, false),
              reverse: tweaks.value(SearchableListFeature.reverse, false),
              separatorBuilder: (context, index) {
                return Container(height: 40);
              },
              sortPredicate: (a, b) => a.age.compareTo(b.age),
              itemBuilder: (item) {
                return ActorItem(actor: item);
              },
              emptyWidget: Column(
                children: [
                  Container(color: Colors.red, height: 10, width: 300),
                  const Column(
                    children: [Icon(Icons.error), Text('No Data found')],
                  ),
                ],
              ),
              filter: (query) {
                filteredActors = actors
                    .where(
                      (element) =>
                          element.name.toLowerCase().contains(
                            query.toLowerCase(),
                          ) ||
                          element.lastName.toLowerCase().contains(
                            query.toLowerCase(),
                          ),
                    )
                    .toList();
                return filteredActors;
              },
              initialList: actors,
            ),
          ),

          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () {
                  controller.clear();
                },
                child: const Text('Clear Search'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
