import 'package:flutter/widgets.dart';

class DummyListItem extends StatelessWidget {
  final int index;

  const DummyListItem({super.key, required this.index});

  @override
  Widget build(BuildContext context) {
    return Text('Item $index');
  }
}
