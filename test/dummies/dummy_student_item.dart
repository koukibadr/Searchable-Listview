import 'package:flutter/material.dart';

import '../mock/student.dart';

class DummyStudentItem extends StatelessWidget {
  final Student item;

  const DummyStudentItem({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return Material(
      child: ListTile(title: Text(item.name), subtitle: Text(item.address)),
    );
  }
}
