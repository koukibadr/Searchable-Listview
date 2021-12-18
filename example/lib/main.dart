import 'package:flutter/material.dart';
import 'package:searchable_listview/searchable_listview.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        body: SafeArea(
          child: ExampleApp(),
        ),
      ),
    );
  }
}

class ExampleApp extends StatelessWidget {
  final List<User> users = [
    User(
      age: 24,
      name: 'Badr',
    ),
    User(
      age: 27,
      name: 'Ali Mohamed',
    ),
    User(
      age: 29,
      name: 'Fathi',
    ),
    User(
      age: 50,
      name: 'Mohamed',
    ),
  ];

  ExampleApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Column(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(15),
              child: SearchableList<User>(
                initialList: users,
                keyboardAction: TextInputAction.search,
                builder: (dynamic user) => UserItem(user: user),
                filter: _filterUserList,
                emptyWidget: const EmptyView(),
                inputDecoration: InputDecoration(
                  labelText: "Search",
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
            ),
          )
        ],
      ),
    );
  }

  _filterUserList(search) {
    return users
        .where(
          (element) => element.name.toLowerCase().contains(search),
        )
        .toList();
  }
}

class UserItem extends StatelessWidget {
  final User user;

  const UserItem({
    Key? key,
    required this.user,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.red,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Text(
          user.name,
          style: const TextStyle(
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}

class EmptyView extends StatelessWidget {
  const EmptyView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: const [
        Icon(
          Icons.error,
          color: Colors.red,
        ),
        Text('No such user found'),
      ],
    );
  }
}

class User {
  int age;
  String name;

  User({
    required this.age,
    required this.name,
  });
}
