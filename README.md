# Searchable ListView

<p  align="center">
<img  src="https://github.com/koukibadr/Searchable-Listview/blob/main/example/searchable_listview_logo.gif?raw=true"  width="300"/>
<br>
<b>An easy way to filter lists</b>
</p>

## Features

- Filter list view easily
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
	searchable_listview:  1.3.3
```

## Attributes

````dart

///initial list to be displayed which contains all elements
///required
final List<T> initialList;


///Callback filter the list based on the given search value
///invoked on changing the text field search if ```searchType == SEARCH_TYPE.onEdit```
///or invoked when submiting the text field if ```searchType == SEARCH_TYPE.onSubmit```
///return List of dynamic objects
///required
final List Function(String) filter;


///builder function that generate the listview children widget
///based on the given object
///required
final Widget Function(T) builder;


///the widget that will be displayed when the filter return an empty list
///by default it's `const SizedBox.shrink()`
final Widget emptyWidget;


///text editing controller applied on the search field
///by default it's null
final TextEditingController? searchTextController;


///the keyboard action key
///by default `TextInputAction.done`
final TextInputAction keyboardAction;


///the text field input decoration
///by default it's null
final InputDecoration? inputDecoration;

///the style for the input text field
/// by default it's null
final TextStyle? style;

///the keyboard text input type
///by default it's `TextInputType.text`
final TextInputType textInputType;


///callback function invoked when submiting the search text field
final Function(String?)? onSubmitSearch;


///the search type on submiting text field or when changing the text field value
///SEARCH_TYPË.onEdit,
///SEARCH_TYPË.onSubmit
///by default it's onEdit
final SEARCH_TYPE searchType;


///indicate whether the text field input is obscure or not
///by default `obscureText = false`
final bool obscureText;


///indicate if the search text field is enabled or not
///by default `searchFieldEnabled = true`
final bool searchFieldEnabled;


///the focus node applied on the search text field
final FocusNode? focusNode;

///function invoked when pressing on item
///by default it's null
final  void  Function<T>(T)?  onItemSelected;


///indicate whether the clear icon will be displayed or not
///by default it's true, to display the clear icon the inputDecoration should not contains suffix icon
///otherwise the initial suffix icon will be displayed
final bool displayClearIcon;

///the color applied on the suffix icon (if displayClearIcon = true)
///by default the color is grey
final Color defaultSuffixIconColor;
````

## Implementation

```dart
SearchableList<Actor>(
	initialList: actors,
	builder: (dynamic user) => UserItem(user: user),
	filter: (value) => actors.where((element) => element.name.toLowerCase().contains(value),).toList(),
	emptyWidget:  const EmptyView(),
	inputDecoration: InputDecoration(
		labelText:  "Search Actor",
		fillColor: Colors.white,
		focusedBorder: OutlineInputBorder(
			borderSide:  const BorderSide(
				color: Colors.blue,
				width:  1.0,
			),
		borderRadius: BorderRadius.circular(10.0),
	),
),
),

```

<p  align="center">
<img  src="https://github.com/koukibadr/Searchable-Listview/blob/main/example/searchable_listview_example.gif?raw=true"  width="300"/>
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
