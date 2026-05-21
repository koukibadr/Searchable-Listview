import 'package:example/widgets/async_searchable_listview.dart';
import 'package:example/widgets/basic_searchable_listview.dart';
import 'package:example/widgets/expansion_searchable_listview.dart';
import 'package:example/widgets/sliver_searchable_listview.dart';
import 'package:flutter/material.dart';

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

class ExampleWidget extends StatelessWidget {
  const ExampleWidget({Key? key}) : super(key: key);

  static const List<Tab> _tabs = [
    Tab(text: 'Basic'),
    Tab(text: 'Async'),
    Tab(text: 'Sliver'),
    Tab(text: 'Expansion'),
  ];

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: _tabs.length,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Searchable Listview Examples'),
          bottom: const TabBar(
            isScrollable: true,
            tabs: _tabs,
          ),
        ),
        body: const TabBarView(
          children: [
            BasicSearchableListview(),
            AsyncSearchableListview(),
            SliverSearchableListview(),
            ExpansionSearchableListview(),
          ],
        ),
      ),
    );
  }
}
