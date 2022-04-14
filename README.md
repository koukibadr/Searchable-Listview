# Searchable ListView

<p  align="center">
<img  src="https://github.com/koukibadr/Searchable-Listview/blob/main/example/searchable_listview_logo.gif?raw=true"  width="300"/>
<br>
<b>An easy way to filter lists</b>
</p>

## Features

- Filter list view easily
- Pull to refresh list
- Display custom widget when list is empty
- Customize search text field
- Change keyboard input type and keyboard submit button
- Add focus on search text field
- Add on item pressed callback
- Customize search text style
- Clear icon button in search to easily clear text

## Getting Started

In order to add motion toast to your project add this line to your `pubspec.yaml` file

```yaml
dependencies:
	searchable_listview:  1.4.0
```

## Attributes

```dart

/// Initial list of all elements that will be displayed.
  late List<T> initialList;

  /// Callback to filter the list based on the given search value.
  ///
  /// Invoked on changing the text field search if ```searchType == SEARCH_TYPE.onEdit```
  /// or invoked when submiting the text field if ```searchType == SEARCH_TYPE.onSubmit```.
  ///
  /// You should return a list of filtered elements.
  final List<T> Function(String) filter;

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
  ///SEARCH_TYPE.onEdit,
  ///SEARCH_TYPE.onSubmit
  /// Defaults to [SEARCH_TYPE.onEdit].
  final SEARCH_TYPE searchType;

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
  final void Function<T>(T)? onItemSelected;

  /// Indicate whether the clear icon will be displayed or not
  /// by default it's true, to display the clear icon the inputDecoration should not contains suffix icon
  /// otherwise the initial suffix icon will be displayed
  final bool displayClearIcon;

  /// The color applied on the suffix icon (if `displayClearIcon = true`).
  /// Defaults to [Colors.grey].
  final Color defaultSuffixIconColor;

  ///An async callback invoked when dragging down the list
  ///if onRefresh is nullable the drag to refresh is not applied
  final Future<void> Function()? onRefresh;


  /// The color applied on the suffix icon (if `displayClearIcon = true`).
  /// Defaults to [Colors.grey].
  final Color sliverScrollEffect;
```

## Implementation

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

## Contribution

Of course the project is open source, and you can contribute to it [repository link](https://github.com/koukibadr/Searchable-Listview)

- If you **found a bug**, open an issue.
- If you **have a feature request**, open an issue.
- If you **want to contribute**, submit a pull request.

## Contributors

<a href="https://github.com/koukibadr/Searchable-Listview/graphs/contributors">
  <img src="https://contrib.rocks/image?repo=koukibadr/Searchable-Listview" />
</a>
