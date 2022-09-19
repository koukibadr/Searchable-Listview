# Searchable ListView

<p  align="center">
<img  src="https://github.com/koukibadr/Searchable-Listview/blob/main/example/searchable_listview_logo.gif?raw=true"  width="300"/>
<br>
<b>An easy way to filter lists</b>
</p>

## Features

- Filter list view easily
- Filter async list
- Support async callback in rendering list
- Customizable loading when async callback is loading
- Customizable error widget
- Support pagination
- Pull to refresh list
- Sliver scroll animation effect
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

## Getting Started

In order to add searchable listview package to your project add this line to your `pubspec.yaml` file

```yaml
dependencies:
	searchable_listview:  2.1.1
```

## Attributes

````dart

/// Initial list of all elements that will be displayed.
  ///
  ///when [initialList] is null you need to provide [asyncListCallback]
  ///to filter the [initialList] you need provide [filter] callback
  List<T>? initialList;

  /// Callback to filter the list based on the given search value.
  ///
  /// Invoked on changing the text field search if ```searchType == SEARCH_TYPE.onEdit```
  /// or invoked when submiting the text field if ```searchType == SEARCH_TYPE.onSubmit```.
  ///
  /// You should return a list of filtered elements.
  late List<T> Function(String)? filter;

  ///Async callback that return list to be displayed with future builder
  ///
  ///when [asyncListCallback] is null you need to provide [initialList]
  ///to filter the [asyncListCallback] result you need provide [asyncListFilter]
  Future<List<T>?> Function()? asyncListCallback;

  ///Callback invoked when filtring the searchable list
  ///used when providing [asyncListCallback]
  ///
  ///can't be null when [asyncListCallback] isn't null
  late List<T> Function(String, List<T>)? asyncListFilter;

  ///Loading widget displayed when [asyncListCallback] is loading
  ///
  ///if nothing is provided in [loadingWidget] searchable list will display a [CircularProgressIndicator]
  Widget? loadingWidget;

  ///error widget displayed when [asyncListCallback] result is null
  ///
  ///if nothing is provided in [errorWidget] searchable list will display a [Icon]
  Widget? errorWidget;

  /// Builder function that generates the ListView items
  /// based on the given element.
  final Widget Function(T) builder;

  /// The widget to be displayed when the filter returns an empty list.
  ///
  /// Defaults to `const SizedBox.shrink()`.
  final Widget emptyWidget;

  /// Text editing controller applied on the search field.
  ///
  /// Defaults to null.
  late TextEditingController? searchTextController;

  /// The keyboard action key
  ///
  /// Defaults to [TextInputAction.done].
  final TextInputAction keyboardAction;

  /// The text field input decoration
  ///
  /// Defaults to null.
  final InputDecoration? inputDecoration;

  /// The style for the input text field
  ///
  /// Defaults to null.
  final TextStyle? style;

  /// The keyboard text input type
  ///
  /// Defaults to [TextInputType.text]
  final TextInputType textInputType;

  /// Callback function invoked when submiting the search text field
  final Function(String?)? onSubmitSearch;

  /// The search type on submiting text field or when changing the text field value
  ///```dart
  ///SEARCH_TYPE.onEdit,
  ///SEARCH_TYPE.onSubmit
  ///```
  ///
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
  late Widget Function(BuildContext, int)? seperatorBuilder;

  ///The scroll direction of the list
  ///by default [Axis.vertical]
  final Axis scrollDirection;

  ///The position of the text field (bottom or top)
  ///by default the textfield is displayed on top
  final SearchTextPosition searchTextPosition;

  ///Callback function invoked each time the listview
  ///reached the bottom
  ///used to create pagination in listview
  final Future<dynamic> Function()? onPaginate;

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

````

### Migration:

- If you are using the 1.5.3 version or older and you are using `sliverScrollEffect` parameter, for 1.6.0 version and above this parameter is replaced with a constructor `SearchableList.sliver`

## Implementation

### Default constructor

```
SearchableList<Object>
```

Used to create simple listview with search field (with other attributes to customize your own listview)

### Seperator constructor

```
SearchableList.seperated
```

Used to create listview with divider seperation (with other attributes to customize your own listview)

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

### Async callback build implementation

```dart
SearchableList<Actor>(
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

## Contribution

Of course the project is open source, and you can contribute to it [repository link](https://github.com/koukibadr/Searchable-Listview)

- If you **found a bug**, open an issue.
- If you **have a feature request**, open an issue.
- If you **want to contribute**, submit a pull request.

## Contributors

<a href="https://github.com/koukibadr/Searchable-Listview/graphs/contributors">
  <img src="https://contrib.rocks/image?repo=koukibadr/Searchable-Listview" />
</a>
