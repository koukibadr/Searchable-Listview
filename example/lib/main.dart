import 'package:example/feature_tweaks.dart';
import 'package:example/widgets/async_searchable_listview.dart';
import 'package:example/widgets/basic_searchable_listview.dart';
import 'package:example/widgets/expansion_searchable_listview.dart';
import 'package:example/widgets/sliver_searchable_listview.dart';
import 'package:material_ui/material_ui.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const ExampleWidget(),
    );
  }
}

class ExampleWidget extends StatefulWidget {
  const ExampleWidget({Key? key}) : super(key: key);

  @override
  State<ExampleWidget> createState() => _ExampleWidgetState();
}

class _ExampleWidgetState extends State<ExampleWidget> {
  final SearchableListTweaks _tweaks = SearchableListTweaks();

  @override
  void dispose() {
    _tweaks.dispose();
    super.dispose();
  }

  static const List<Tab> _tabs = [
    Tab(text: 'Basic'),
    Tab(text: 'Async'),
    Tab(text: 'Sliver'),
    Tab(text: 'Expansion'),
  ];

  @override
  Widget build(BuildContext context) {
    return SearchableListTweaksScope(
      notifier: _tweaks,
      child: DefaultTabController(
        length: _tabs.length,
        child: Builder(
          builder: (context) => Scaffold(
            appBar: AppBar(
              title: const Text('Searchable Listview Examples'),
              bottom: const TabBar(
                isScrollable: true,
                tabs: _tabs,
              ),
            ),
            body: const TabBarView(
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(
                    vertical: 5,
                    horizontal: 10,
                  ),
                  child: BasicSearchableListview(),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                    vertical: 5,
                    horizontal: 10,
                  ),
                  child: AsyncSearchableListview(),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                    vertical: 5,
                    horizontal: 10,
                  ),
                  child: SliverSearchableListview(),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                    vertical: 5,
                    horizontal: 10,
                  ),
                  child: ExpansionSearchableListview(),
                ),
              ],
            ),
            floatingActionButton: FloatingActionButton(
              tooltip: 'Feature tweaks',
              onPressed: () {
                final tabIndex = DefaultTabController.of(context).index;
                showModalBottomSheet<void>(
                  context: context,
                  isScrollControlled: true,
                  builder: (context) => _FeatureTweaksPanel(
                    tweaks: _tweaks,
                    tabIndex: tabIndex,
                    tabName: _tabs[tabIndex].text!,
                  ),
                );
              },
              child: const Icon(Icons.tune),
            ),
          ),
        ),
      ),
    );
  }
}

class _FeatureTweaksPanel extends StatelessWidget {
  const _FeatureTweaksPanel({
    required this.tweaks,
    required this.tabIndex,
    required this.tabName,
  });

  final SearchableListTweaks tweaks;
  final int tabIndex;
  final String tabName;

  @override
  Widget build(BuildContext context) {
    final features = <_FeatureToggle>[
      const _FeatureToggle(
        SearchableListFeature.showSearchField,
        'Show search field',
        true,
      ),
      const _FeatureToggle(
        SearchableListFeature.searchFieldEnabled,
        'Enable search field',
        true,
      ),
      const _FeatureToggle(
        SearchableListFeature.displaySearchIcon,
        'Show search icon',
        true,
      ),
      const _FeatureToggle(
        SearchableListFeature.displayClearIcon,
        'Show clear icon',
        true,
      ),
      _FeatureToggle(
        SearchableListFeature.lazyLoadingEnabled,
        'Enable lazy loading',
        tabIndex != 0,
      ),
      const _FeatureToggle(
        SearchableListFeature.closeKeyboardWhenScrolling,
        'Close keyboard when scrolling',
        false,
      ),
    ];

    if (tabIndex != 2) {
      features.addAll(const [
        _FeatureToggle(SearchableListFeature.shrinkWrap, 'Shrink wrap', false),
        _FeatureToggle(SearchableListFeature.reverse, 'Reverse list', false),
      ]);
    }
    if (tabIndex == 2) {
      features.add(
        const _FeatureToggle(
          SearchableListFeature.sliverScrollEffect,
          'Enable sliver scroll effect',
          true,
        ),
      );
    }
    if (tabIndex == 3) {
      features.addAll(const [
        _FeatureToggle(
          SearchableListFeature.hideEmptyExpansionItems,
          'Hide empty expansion groups',
          true,
        ),
        _FeatureToggle(
          SearchableListFeature.expansionTileEnabled,
          'Enable expansion tiles',
          true,
        ),
        _FeatureToggle(
          SearchableListFeature.initiallyExpanded,
          'Expand groups initially',
          false,
        ),
      ]);
    }

    return AnimatedBuilder(
      animation: tweaks,
      builder: (context, _) => SafeArea(
        child: ConstrainedBox(
          constraints: BoxConstraints(
            maxHeight: MediaQuery.of(context).size.height * 0.75,
          ),
          child: ListView(
            shrinkWrap: true,
            padding: const EdgeInsets.only(bottom: 12),
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 20, 20, 8),
                child: Text(
                  '$tabName list tweaks',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              ),
              for (final feature in features)
                SwitchListTile(
                  title: Text(feature.label),
                  value: tweaks.value(feature.feature, feature.defaultValue),
                  onChanged: (value) => tweaks.setValue(feature.feature, value),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

class _FeatureToggle {
  const _FeatureToggle(this.feature, this.label, this.defaultValue);

  final SearchableListFeature feature;
  final String label;
  final bool defaultValue;
}
