import 'package:flutter/widgets.dart';

class DummyListItem extends StatelessWidget {
  final int index;

  const DummyListItem({Key? key, required this.index}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text('Item $index');
  }
}
