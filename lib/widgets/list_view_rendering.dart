import 'package:flutter/material.dart';

class ListViewRendering<T> extends StatelessWidget {
  final ScrollPhysics? physics;
  final bool shrinkWrap;
  final double? itemExtent;
  final EdgeInsetsGeometry? padding;
  final bool reverse;
  final ScrollController scrollController;
  final Axis scrollDirection;
  final List<T> list;
  final Widget Function(T item)? itemBuilder;
  final bool isLazyLoadingEnabled;

  const ListViewRendering({
    Key? key,
    required this.itemExtent,
    required this.isLazyLoadingEnabled,
    required this.itemBuilder,
    required this.list,
    required this.padding,
    required this.physics,
    required this.reverse,
    required this.scrollController,
    required this.scrollDirection,
    required this.shrinkWrap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (isLazyLoadingEnabled) {
      return ListView(
        physics: physics,
        shrinkWrap: shrinkWrap,
        itemExtent: itemExtent,
        padding: padding,
        reverse: reverse,
        controller: scrollController,
        scrollDirection: scrollDirection,
        children: list.map((item) {
          return itemBuilder!(item);
        }).toList(),
      );
    }
    return ListView.builder(
      physics: physics,
      shrinkWrap: shrinkWrap,
      itemExtent: itemExtent,
      padding: padding,
      reverse: reverse,
      controller: scrollController,
      scrollDirection: scrollDirection,
      itemCount: list.length,
      itemBuilder: (context, index) => itemBuilder!(list[index]),
    );
  }
}