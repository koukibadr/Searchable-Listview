import 'package:flutter/material.dart';

class ListViewRendering<T> extends StatelessWidget {
  final ScrollPhysics? physics;
  final bool shrinkWrap;
  final double? itemExtent;
  final EdgeInsetsGeometry? padding;
  final bool reverse;
  final ScrollController? scrollController;
  final Axis scrollDirection;
  final List<T> list;
  final Widget Function(T item)? itemBuilder;
  final bool isLazyLoadingEnabled;
  final Widget Function(BuildContext context, int index)? seperatorBuilder;
  final bool isListViewSeparated;

  const ListViewRendering({
    Key? key,
    required this.itemExtent,
    required this.isLazyLoadingEnabled,
    required this.itemBuilder,
    required this.list,
    required this.padding,
    required this.physics,
    required this.reverse,
    this.scrollController,
    required this.scrollDirection,
    required this.shrinkWrap,
    this.seperatorBuilder,
    this.isListViewSeparated = false,
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
    if (isListViewSeparated) {
      return ListView.separated(
        controller: scrollController,
        scrollDirection: scrollDirection,
        itemCount: list.length,
        physics: physics,
        shrinkWrap: shrinkWrap,
        padding: padding,
        reverse: reverse,
        itemBuilder: (context, index) => itemBuilder!(list[index]),
        separatorBuilder: seperatorBuilder!,
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
