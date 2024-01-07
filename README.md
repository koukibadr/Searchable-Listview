# Searchable ListView

<p  align="center">
<img  src="https://github.com/koukibadr/Searchable-Listview/blob/main/example/searchable_listview_logo.gif?raw=true"  width="300"/>
<br>
<b>An easy way to filter lists</b>
</p>

## Features

- **Filter list view easily**
- **Filter async list**
- **Filter expansion list**
- **Sort list items**
- **Support async callback in rendering list**
- **Support pagination**
- **Pull to refresh list**
- **Sliver scroll animation effect**
- Customizable sort widget
- Customizable loading when async callback is loading
- Customizable error widget
- Display custom widget when list is empty
- Customize search text field
- Change keyboard input type and keyboard submit button
- Add focus on search text field
- Add on item pressed callback
- Customize search text style
- Clear icon button in search to easily clear text
- Customizable scroll direction
- Searchable list with seperator builder
- Customizable text field position
- Customizable text style in search field
- Customize autocomplete options
- Customizable secondary widget alongside search
- Close automatically keyboard when scrolling on listview

## Getting Started

In order to add searchable listview package to your project add this line to your `pubspec.yaml` file

```yaml
dependencies:
	searchable_listview:  2.10.0
```

## Attributes

````dart

  /// Initial list of all elements that will be displayed.
  ///to filter the [initialList] you need provide [filter] callback
  late List<T> initialList;

  /// Callback to filter the list based on the given search value.
  /// Invoked on changing the text field search if ```searchType == SEARCH_TYPE.onEdit```
  /// or invoked when submiting the text field if ```searchType == SEARCH_TYPE.onSubmit```.
  /// You should return a list of filtered elements.
  List<T> Function(String query)? filter;

  ///Async callback that return list to be displayed with future builder
  ///to filter the [asyncListCallback] result you need provide [asyncListFilter]
  Future<List<T>?> Function()? asyncListCallback;

  ///Callback invoked when filtring the searchable list
  ///used when providing [asyncListCallback]
  ///can't be null when [asyncListCallback] isn't null
  late List<T> Function(String, List<T>)? asyncListFilter;

  ///Loading widget displayed when [asyncListCallback] is loading
  ///if nothing is provided in [loadingWidget] searchable list will display a [CircularProgressIndicator]
  Widget? loadingWidget;

  ///error widget displayed when [asyncListCallback] result is null
  ///if nothing is provided in [errorWidget] searchable list will display a [Icon]
  Widget? errorWidget;

  /// Builder function that generates the ListView items
  /// based on the given index.
  /// first parameter is the rendered list
  /// second parameter is the item index in the actual list (filtered index)
  /// third parameter is the list item that will be rendered
  late Widget Function(List<T> displayedList, int itemIndex, T item)? builder;

  /// Builder function that generates the Expansion listView items
  /// based on the given index.
  /// Used only for expansion list constructor
  late Widget Function(int)? expansionListBuilder;

  /// The widget to be displayed when the filter returns an empty list.
  /// Defaults to `const SizedBox.shrink()`.
  final Widget emptyWidget;

  /// Text editing controller applied on the search field.
  /// Defaults to null.
  late TextEditingController? searchTextController;

  /// The keyboard action key
  /// Defaults to [TextInputAction.done].
  final TextInputAction keyboardAction;

  /// The text field input decoration
  /// Defaults to null.
  final InputDecoration? inputDecoration;

  /// The style for the input text field
  /// Defaults to null.
  final TextStyle? style;

  /// The keyboard text input type
  /// Defaults to [TextInputType.text]
  final TextInputType textInputType;

  /// Callback function invoked when submiting the search text field
  final Function(String?)? onSubmitSearch;

  /// The search type on submiting text field or when changing the text field value
  ///```dart
  ///SEARCH_TYPE.onEdit,
  ///SEARCH_TYPE.onSubmit
  ///```
  /// Defaults to [SearchMode.onEdit].
  final SearchMode searchMode;

  /// Indicate whether the text field input should be obscured or not.
  /// Defaults to `false`.
  final bool obscureText;

  /// Indicate if the search text field is enabled or not.
  /// Defaults to `true`.
  final bool searchFieldEnabled;

  /// The focus node applied on the search text field
  final FocusNode? focusNode;

  /// Function invoked when pressing on item
  /// Defaults to null
  final void Function(T)? onItemSelected;

  /// Indicate whether the clear icon will be displayed or not
  /// by default it's true, to display the clear icon the inputDecoration should not contains suffix icon
  /// otherwise the initial suffix icon will be displayed
  final bool displayClearIcon;

  /// The color applied on the suffix icon (if `displayClearIcon = true`).
  /// Defaults to [Colors.grey].
  final Color defaultSuffixIconColor;

  ///An async callback invoked when dragging down the list
  ///if onRefresh is nullable the drag to refresh is not applied
  late Future<void> Function()? onRefresh;

  ///Builder callback required  when using [seperated] constructor
  ///return the Widget that will seperate all the elements inside the list
  late Widget Function(BuildContext context, int index)? seperatorBuilder;

  ///The scroll direction of the list
  ///by default [Axis.vertical]
  Axis scrollDirection = Axis.vertical;

  ///The position of the text field (bottom or top)
  ///by default the textfield is displayed on top
  SearchTextPosition searchTextPosition = SearchTextPosition.top;

  ///Callback function invoked each time the listview
  ///reached the bottom
  ///used to create pagination in listview
  Future<dynamic> Function()? onPaginate;

  ///space between the search textfield and the list
  ///by default the padding is set to 20
  final double spaceBetweenSearchAndList;

  ///cusor color used in the search textfield
  final Color? cursorColor;

  ///max lines attribute used in the search textfield
  final int? maxLines;

  ///max length attribute used in the search field
  final int? maxLength;

  ///the text alignement of the search field
  ///by default the alignement is start
  final TextAlign textAlign;

  ///List of strings  to display in an auto complete field
  ///by default list is empty so a simple text field is displayed
  final List<String> autoCompleteHints;

  ///indicate whether the search textfield have it's focus on by default or not
  ///by default [autoFocusOnSearch = true]
  final bool autoFocusOnSearch;

  ///secondary widget will be displayed alongside the search field
  ///by default it's null
  final Widget? secondaryWidget;

  ///Map of data used to build  searchable expansion list
  ///required when using [expansion] constructor
  late Map<dynamic, List<T>> expansionListData;

  ///callback used when filtering the expansion list
  ///required when using [expansion] constructor
  late Map<dynamic, List<T>> Function(String)? filterExpansionData;

  ///the expansion list title widget builder
  ///required when using [expansion] constructor
  late Widget Function(dynamic) expansionTitleBuilder;

  ///physics attributes used in listview widget
  late ScrollPhysics? physics;

  ///shrinkWrap used in listview widget, not used in sliver searchable list
  ///by default `shrinkWrap = false`
  late bool shrinkWrap;

  ///item extent of the listview
  late double? itemExtent;

  ///listview item padding
  late EdgeInsetsGeometry? listViewPadding;

  ///list items reverse attributes
  ///by default `reverse = false`
  ///not available for sliver listview constructor
  late bool reverse;

  ///Predicate callback invoked when sorting list items
  ///required when `displaySortWidget` is True
  late int Function(T a, T b)? sortPredicate;

  ///Indicate if the sort widget will be displayed or not
  /// Defaults to false
  late bool displaySortWidget;

  ///Widget displayed when sorting list
  /// available only if `displaySortWidget` is True
  late Widget? sortWidget;

  ///Scroll controller passed to listview widget
  ///by default listview uses scrollcontroller with a listener for pagination if `onPaginate = true`
  ///or `closeKeyboardWhenScrolling = true` to close keyboard when scrolling
  ScrollController? scrollController;

  ///indicates whether the keyboard will be closed when scrolling or not
  ///by default `closeKeyboardWhenScrolling = true`
  final bool closeKeyboardWhenScrolling;

````

### Migration:

- **If you are using the 1.5.3 version or older and you are using `sliverScrollEffect` parameter, for 1.6.0 version and above this parameter is replaced with a constructor `SearchableList.sliver`**

- **If you are migrating to 2.5.0 version you need to change the `builder` callback as now it provide the element index and not the element object**

- **If you are migrating to 2.8.0 version the `seperated` constructor is no longer available instead use `seperatorBuilder` in both default constructor and `async` constructor**

## Implementation

### Default constructor

```
SearchableList<Object>
```

Used to create simple listview with search field (with other attributes to customize your own listview)

### Async constructor

```
SearchableList<Object>.async
```

Used to render listview from a future callback (it require an async callback that return List of objects)


### Expansion constructor

```
SearchableList<Object>.expansion
```

Used to create expansion listview with search field (with other attributes to customize your own expansion list)

### Sliver effect constructor

```
SearchableList.sliver
```

Used to create a listview with sliver scrolling effect (with other attributes to customize your own listview)

### Simple implementation

```dart
SearchableList<Actor>(
  initialList: actors,
  builder: (Actor user) => UserItem(user: user),
  filter: (value) => actors.where((element) => element.name.toLowerCase().contains(value),).toList(),
  emptyWidget:  const EmptyView(),
  inputDecoration: InputDecoration(
  labelText: "Search Actor",
	fillColor: Colors.white,
	focusedBorder: OutlineInputBorder(
	  borderSide: const BorderSide(
	    color: Colors.blue,
		width: 1.0,
	  ),
	  borderRadius: BorderRadius.circular(10.0),
	),
  ),
),

```

<p align="center">
<img src="https://github.com/koukibadr/Searchable-Listview/blob/main/example/searchable_listview_example.gif?raw=true" width="300"/>
</p>


### Expansion list with search implementation

```dart
SearchableList<Actor>.expansion(
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
      style: const TextStyle(fontSize: 25),
      builder: (Actor actor) => ActorItem(actor: actor),
      emptyWidget: const EmptyView(),
      inputDecoration: InputDecoration(
        labelText: "Search Actor",
        fillColor: Colors.white,
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(
            color: Colors.blue,
            width: 1.0,
          ),
          borderRadius: BorderRadius.circular(10.0),
        ),
      ),
    )
```

<p align="center">
<img src="https://github.com/koukibadr/Searchable-Listview/blob/main/example/Screenshot_1681660275.png?raw=true" width="300"/>
</p>

### Async callback build implementation

```dart
SearchableList<Actor>.async(
                onPaginate: () async {
                  await Future.delayed(const Duration(milliseconds: 1000));
                  setState(() {
                    actors.addAll([
                      Actor(age: 22, name: 'Fathi', lastName: 'Hadawi'),
                      Actor(age: 22, name: 'Hichem', lastName: 'Rostom'),
                      Actor(age: 22, name: 'Kamel', lastName: 'Twati'),
                    ]);
                  });
                },
                builder: (Actor actor) => ActorItem(actor: actor),
                loadingWidget: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    CircularProgressIndicator(),
                    SizedBox(
                      height: 20,
                    ),
                    Text('Loading actors...')
                  ],
                ),
                errorWidget: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Icon(
                      Icons.error,
                      color: Colors.red,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text('Error while fetching actors')
                  ],
                ),
                asyncListCallback: () async {
                  await Future.delayed(
                    const Duration(
                      milliseconds: 10000,
                    ),
                  );
                  return actors;
                },
                asyncListFilter: (q, list) {
                  return list
                      .where((element) => element.name.contains(q))
                      .toList();
                },
                emptyWidget: const EmptyView(),
                onRefresh: () async {},
                onItemSelected: (Actor item) {},
                inputDecoration: InputDecoration(
                  labelText: "Search Actor",
                  fillColor: Colors.white,
                  focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(
                      color: Colors.blue,
                      width: 1.0,
                    ),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
              )

```

<p align="center">
<img src="https://github.com/koukibadr/Searchable-Listview/blob/main/example/searchable_listview_example.gif?raw=true" width="300"/>
</p>

### Sliver scroll example

```dart
SearchableList<Actor>.sliver(
  initialList: actors,
  builder: (Actor user) => UserItem(user: user),
  filter: (value) => actors.where((element) => element.name.toLowerCase().contains(value),).toList(),
  emptyWidget:  const EmptyView(),
  inputDecoration: InputDecoration(
    labelText: "Search Actor",
	fillColor: Colors.white,
	focusedBorder: OutlineInputBorder(
	  borderSide: const BorderSide(
	    color: Colors.blue,
		width: 1.0,
	  ),
	  borderRadius: BorderRadius.circular(10.0),
	),
  ),
),

```

### Searchable list with sort widget

```Dart
SearchableList<Actor>(
    displaySortWidget: true,
    sortPredicate: (a, b) => a.age.compareTo(b.age),
    builder: (list, index, item) {
      return ActorItem(actor: item);
    },
    initialList: actors,
    filter: (p0) {
      return actors.where((element) => element.name.contains(p0)).toList();
    },
    inputDecoration: InputDecoration(
      labelText: "Search Actor",
      fillColor: Colors.white,
      focusedBorder: OutlineInputBorder(
        borderSide: const BorderSide(
          color: Colors.blue,
          width: 1.0,
        ),
        borderRadius: BorderRadius.circular(10.0),
      ),
    ),
)
```

<p align="center">
<img src="https://github.com/koukibadr/Searchable-Listview/blob/main/example/Screenshot_1700337103.png?raw=true" width="300">
</p>


### Searchable list with auto closing keyboard when scrolling

```Dart
SearchableList<Actor>(
    displaySortWidget: true,
    sortPredicate: (a, b) => a.age.compareTo(b.age),
    builder: (list, index, item) {
      return ActorItem(actor: item);
    },
    initialList: actors,
    filter: (p0) {
      return actors.where((element) => element.name.contains(p0)).toList();
    },
    inputDecoration: InputDecoration(
      labelText: "Search Actor",
      fillColor: Colors.white,
      focusedBorder: OutlineInputBorder(
        borderSide: const BorderSide(
          color: Colors.blue,
          width: 1.0,
        ),
        borderRadius: BorderRadius.circular(10.0),
      ),
    ),
    closeKeyboardWhenScrolling: true
)
```


## Contribution

Of course the project is open source, and you can contribute to it [repository link](https://github.com/koukibadr/Searchable-Listview)

- If you **found a bug**, open an issue.
- If you **have a feature request**, open an issue.
- If you **want to contribute**, submit a pull request.

## Contributors

<a href="https://github.com/koukibadr/Searchable-Listview/graphs/contributors">
  <img src="https://contrib.rocks/image?repo=koukibadr/Searchable-Listview" />
</a>
