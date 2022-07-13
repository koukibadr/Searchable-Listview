import 'package:flutter/material.dart';

class ListItem<T> extends StatelessWidget {
  final Function(T)? onItemSelected;
  final Widget Function(T) builder;
  final T item;

  const ListItem({
    Key? key,
    required this.builder,
    required this.item,
    required this.onItemSelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return onItemSelected == null
        ? builder(item)
        : InkWell(
            onTap: () {
              onItemSelected!.call(
                item,
              );
            },
            child: builder(item),
          );
  }
}
