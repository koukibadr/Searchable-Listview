import 'package:flutter/material.dart';
import 'package:searchable_listview/resources/arrays.dart';
import 'package:searchable_listview/searchable_listview.dart';

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
      home: const Scaffold(
        body: SafeArea(
          child: ExampleApp(),
        ),
      ),
    );
  }
}

class ExampleApp extends StatefulWidget {
  const ExampleApp({Key? key}) : super(key: key);

  @override
  State<ExampleApp> createState() => _ExampleAppState();
}

class _ExampleAppState extends State<ExampleApp> {
  final List<Actor> actors = [
    Actor(age: 47, name: 'Leonardo', lastName: 'DiCaprio'),
    Actor(age: 58, name: 'Johnny', lastName: 'Depp'),
    Actor(age: 78, name: 'Robert', lastName: 'De Niro'),
    Actor(age: 44, name: 'Tom', lastName: 'Hardy'),
    Actor(age: 66, name: 'Denzel', lastName: 'Washington'),
    Actor(age: 49, name: 'Ben', lastName: 'Affleck'),
    Actor(age: 47, name: 'Leonardo', lastName: 'DiCaprio'),
    Actor(age: 58, name: 'Johnny', lastName: 'Depp'),
    Actor(age: 78, name: 'Robert', lastName: 'De Niro'),
    Actor(age: 44, name: 'Tom', lastName: 'Hardy'),
    Actor(age: 66, name: 'Denzel', lastName: 'Washington'),
    Actor(age: 49, name: 'Ben', lastName: 'Affleck'),
  ];

  final Map<String, List<Actor>> mapOfActors = {
    'test 1': [
      Actor(age: 47, name: 'Leonardo', lastName: 'DiCaprio'),
      Actor(age: 66, name: 'Denzel', lastName: 'Washington'),
      Actor(age: 49, name: 'Ben', lastName: 'Affleck'),
    ],
    'test 2': [
      Actor(age: 58, name: 'Johnny', lastName: 'Depp'),
      Actor(age: 78, name: 'Robert', lastName: 'De Niro'),
      Actor(age: 44, name: 'Tom', lastName: 'Hardy'),
    ]
  };

  final TextEditingController searchTextController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Column(
        children: [
          const Text('Searchable list with divider'),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(15),
              child: sliverListViewBuilder(),
            ),
          ),
          Align(
            alignment: Alignment.center,
            child: ElevatedButton(
              onPressed: addActor,
              child: const Text('Add actor'),
            ),
          )
        ],
      ),
    );
  }

  void addActor() {
    actors.add(Actor(
      age: 10,
      lastName: 'Ali',
      name: 'ALi',
    ));
    setState(() {});
  }

  Widget simpleSearchWithSort() {
    return SearchableList<Actor>(
      searchTextPosition: SearchTextPosition.bottom,
      lazyLoadingEnabled: false,
      sortPredicate: (a, b) => a.age.compareTo(b.age),
      itemBuilder: (item) {
        return ActorItem(actor: item);
      },
      filter: (query) {
        return actors
            .where((element) =>
                element.name.toLowerCase().contains(query.toLowerCase()) ||
                element.lastName.toLowerCase().contains(query.toLowerCase()))
            .toList();
      },
      initialList: actors,
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
    );
  }

  Widget renderSimpleSearchableList() {
    return SearchableList<Actor>(
      seperatorBuilder: (context, index) {
        return const Divider();
      },
      textStyle: const TextStyle(fontSize: 25),
      itemBuilder: (item) {
        return ActorItem(actor: item);
      },
      errorWidget: const Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
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
      initialList: actors,
      filter: (p0) {
        return actors.where((element) => element.name.contains(p0)).toList();
      },
      emptyWidget: const EmptyView(),
      onRefresh: () async {},
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
      closeKeyboardWhenScrolling: true,
    );
  }

  Widget sliverListViewBuilder() {
    return SearchableList<Actor>.sliver(
      initialList: actors,
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
      filter: (query) {
        return actors.where((element) => element.name.contains(query)).toList();
      },
      itemBuilder: (Actor actorItem) {
        return ActorItem(actor: actorItem);
      },
      sortWidget: const Icon(Icons.sort),
      sortPredicate: (a, b) {
        return a.age.compareTo(b.age);
      },
    );
  }

  Widget renderAsynchSearchableListview() {
    return SearchableList<Actor>.async(
      itemBuilder: (Actor item) {
        return ActorItem(actor: item);
      },
      asyncListCallback: () async {
        await Future.delayed(const Duration(seconds: 5));
        return actors;
      },
      asyncListFilter: (query, list) {
        return actors
            .where((element) =>
                element.name.contains(query) ||
                element.lastName.contains(query))
            .toList();
      },
      seperatorBuilder: (context, index) {
        return const Divider();
      },
      textStyle: const TextStyle(fontSize: 25),
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
    );
  }

  Widget expansionSearchableList() {
    return SearchableList<Actor>.expansion(
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
      textStyle: const TextStyle(fontSize: 25),
      expansionListBuilder: (int index, Actor _actor) {
        return ActorItem(
          actor: _actor,
        );
      },
      hideEmptyExpansionItems: true,
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
    );
  }
}

class ActorItem extends StatelessWidget {
  final Actor actor;

  const ActorItem({
    Key? key,
    required this.actor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        height: 60,
        decoration: BoxDecoration(
          color: Colors.grey[200],
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          children: [
            const SizedBox(
              width: 10,
            ),
            Icon(
              Icons.star,
              color: Colors.yellow[700],
            ),
            const SizedBox(
              width: 10,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Firstname: ${actor.name}',
                  style: const TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  'Lastname: ${actor.lastName}',
                  style: const TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  'Age: ${actor.age}',
                  style: const TextStyle(
                    color: Colors.black,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class EmptyView extends StatelessWidget {
  const EmptyView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.error,
            color: Colors.red,
          ),
          Text('no actor is found with this name'),
        ],
      ),
    );
  }
}

class Actor {
  int age;
  String name;
  String lastName;

  Actor({
    required this.age,
    required this.name,
    required this.lastName,
  });
}
