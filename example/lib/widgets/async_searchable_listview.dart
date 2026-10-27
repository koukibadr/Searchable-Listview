import 'package:example/data/actor.dart';
import 'package:example/data/actors_data.dart';
import 'package:example/feature_tweaks.dart';
import 'package:example/widgets/actor_item_widget.dart';
import 'package:example/widgets/empty_widget.dart';
import 'package:material_ui/material_ui.dart';
import 'package:searchable_listview/searchable_listview.dart';

class AsyncSearchableListview extends StatefulWidget {
  const AsyncSearchableListview({Key? key}) : super(key: key);

  @override
  State<AsyncSearchableListview> createState() =>
      _AsyncSearchableListviewState();
}

class _AsyncSearchableListviewState extends State<AsyncSearchableListview> {
  final TextEditingController _searchTextController = TextEditingController();

  @override
  void dispose() {
    _searchTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final tweaks = SearchableListTweaksScope.of(context);
    return SearchableList<Actor>.async(
      searchTextController: _searchTextController,
      itemBuilder: (Actor item) {
        return ActorItem(actor: item);
      },
      asyncListCallback: () async {
        await Future.delayed(const Duration(seconds: 5));
        return actors;
      },
      asyncListFilter: (query, list) async {
        await Future.delayed(const Duration(seconds: 3));
        var result = list
            .where(
              (element) =>
                  element.name.contains(query) ||
                  element.lastName.contains(query),
            )
            .toList();
        return result;
      },
      asyncDebounceTime: 200,
      lazyLoadingEnabled:
          tweaks.value(SearchableListFeature.lazyLoadingEnabled, true),
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
