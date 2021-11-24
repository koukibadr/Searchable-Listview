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
      home: Scaffold(body: SafeArea(child: ExampleApp())),
    );
  }
}

class ExampleApp extends StatelessWidget {
  List<User> users = [
    User(age: 24, name: 'Badr'),
    User(age: 27, name: 'Ali Mohamed'),
    User(age: 29, name: 'Fathi'),
    User(age: 50, name: 'Mohamed'),
  ];

  TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Column(
        children: [
          Expanded(
            child: SearchableList<User>(
              initialList: users,
              builder: (user) {
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
              },
              filter: (text) {
                var searchResult = users
                    .where((element) => element.name.contains(text))
                    .toList();
                return searchResult;
              },
            ),
          )
        ],
      ),
    );
  }
}

class User {
  int age;
  String name;

  User({required this.age, required this.name});
}
