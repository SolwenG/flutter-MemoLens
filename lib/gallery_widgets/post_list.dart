import 'package:flutter/material.dart';
import 'post_card.dart';

class PostList extends StatefulWidget {
  final List<Item> items;
  final bool showFavorites;
  final void Function() onFilterToggle;

  const PostList({
    super.key,
    required this.items,
    required this.showFavorites,
    required this.onFilterToggle,
  });

  @override
  PostListState createState() => PostListState();
}

class PostListState extends State<PostList> {
  bool smallScreen = true;

  @override
  Widget build(BuildContext context) {
    List<Item> itemsShown = widget.showFavorites
        ? widget.items.where((item) => item.favorite).toList()
        : widget.items;

    return LayoutBuilder(
      builder: (context, constraints) {
        smallScreen = constraints.maxWidth < 750;

        return Padding(
            padding: const EdgeInsets.all(5.0),
            child: Stack(children: [
              ListView.builder(
                scrollDirection: smallScreen ? Axis.vertical : Axis.horizontal,
                itemCount: itemsShown.length,
                itemBuilder: (context, index) {
                  return PostCard(item: itemsShown[index]);
                },
              ),
              Positioned(
                bottom: 0,
                right: 20.0,
                child: FloatingActionButton(
                  onPressed: widget.onFilterToggle,
                  tooltip: 'Filter Favorites',
                  backgroundColor: Colors.red,
                  foregroundColor: Colors.white,
                  child: Icon(widget.showFavorites
                      ? Icons.filter_alt_off
                      : Icons.filter_alt),
                ),
              ),
            ]));
      },
    );
  }
}
