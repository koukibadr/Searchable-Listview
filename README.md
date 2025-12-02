# Searchable ListView

<p align="center">
  <img src="https://github.com/koukibadr/Searchable-Listview/blob/main/example/searchable_listview_logo.gif?raw=true" width="320" alt="Searchable ListView" />
</p>

An easy-to-use Flutter widget for adding a searchable, sortable, and paginated list UI. Supports synchronous lists, asynchronous data sources, expansion groups, slivers, pull-to-refresh, and many customization options.

```text
Package: searchable_listview
```

## Features

- Filter lists on edit or submit
- Support for async data sources and async filtering
- Expansion-group lists with searchable group contents
- Optional sort widget and custom sort predicate
- Pagination and `onPaginate` callback
- Pull-to-refresh support
- Sliver-based scrolling effect
- Customizable loading / error / empty widgets
- Customizable search field (decoration, input type, icons, width/height)
- Auto-complete hints and secondary widgets next to the search field

## Installation

Add the package to your `pubspec.yaml`:

```yaml
dependencies:
  searchable_listview: ^2.19.4
```

Then run:

```bash
flutter pub get
```

## Quick Start

Basic synchronous list example:

```dart
SearchableList<Actor>(
  initialList: actors,
  itemBuilder: (actor) => ActorItem(actor: actor),
  filter: (query) => actors
      .where((a) => a.name.toLowerCase().contains(query.toLowerCase()))
      .toList(),
  emptyWidget: const Center(child: Text('No results')),
  inputDecoration: InputDecoration(labelText: 'Search actor'),
)
```

### Async list example

Use the `.async` constructor when data comes from a Future and you need to filter the returned list:

```dart
SearchableList<Actor>.async(
  asyncListCallback: () async => await fetchActors(),
  asyncListFilter: (query, list) =>
      list.where((a) => a.name.contains(query)).toList(),
  itemBuilder: (actor) => ActorItem(actor: actor),
  loadingWidget: const Center(child: CircularProgressIndicator()),
  errorWidget: const Center(child: Icon(Icons.error)),
)
```

### Expansion groups

For grouped/expansion lists use the `.expansion` constructor:

```dart
SearchableList<Actor>.expansion(
  expansionListData: mapOfActors,
  expansionTitleBuilder: (key) => Text(key.toString()),
  filterExpansionData: (query) => {
    for (final entry in mapOfActors.entries)
      entry.key: (mapOfActors[entry.key] ?? [])
          .where((a) => a.name.contains(query))
          .toList()
  },
  expansionListBuilder: (index, actor) => ActorItem(actor: actor),
)
```

### Sliver list

Use `.sliver` to embed a searchable list inside sliver scroll views:

```dart
SearchableList<Actor>.sliver(
  initialList: actors,
  itemBuilder: (actor) => ActorItem(actor: actor),
  filter: (q) => actors.where((a) => a.name.contains(q)).toList(),
)
```

## Common Parameters

- `initialList` — initial synchronous list of items
- `filter` — synchronous filter callback (String -> List<T>)
- `asyncListCallback` — Future that returns a List<T>
- `asyncListFilter` — filter that applies to results from `asyncListCallback`
- `itemBuilder` — builder for list item widgets
- `emptyWidget`, `loadingWidget`, `errorWidget` — custom widgets for states
- `onPaginate` — callback when list reaches the end (for pagination)
- `inputDecoration`, `textStyle`, `textInputType` — search field customization
- `sortWidget`, `sortPredicate` — optional sorting UI and comparator
- `closeKeyboardWhenScrolling` — whether scrolling hides the keyboard

For a complete list of available parameters and detailed API, see the library documentation or the source code in `lib/searchable_listview.dart`.

## Example App

See the `example/` folder for a runnable demo with multiple configurations and screenshots.

<p align="center">
  <img src="https://github.com/koukibadr/Searchable-Listview/blob/main/example/searchable_listview_example.gif?raw=true" width="360" alt="Example" />
</p>

## Contributing

Contributions, issues and feature requests are welcome. Feel free to check the `example/` folder for usage examples and open a pull request.

- Report bugs by opening an issue
- Suggest features by opening an issue
- Submit pull requests for fixes and improvements

Repository: <https://github.com/koukibadr/Searchable-Listview>

## License

This project is licensed under the terms in the `LICENSE` file.

## Authors

<a href="https://github.com/koukibadr/Searchable-Listview/graphs/contributors">
  <img src="https://contrib.rocks/image?repo=koukibadr/Searchable-Listview" />
</a>
