import 'package:flutter/material.dart';
import 'post_card.dart';

class PostList extends StatefulWidget {
  final List<Item> items;
  final void Function() onAddItem;
  final bool showFavorites;
  final void Function() onFilterToggle;

  const PostList({
    super.key,
    required this.items,
    required this.onAddItem,
    required this.showFavorites,
    required this.onFilterToggle,
  });

  @override
  PostListState createState() => PostListState();
}

class PostListState extends State<PostList> {
  @override
  Widget build(BuildContext context) {
    List<Item> itemsShown = widget.showFavorites
        ? widget.items.where((item) => item.favorite).toList()
        : widget.items;

    return Stack(
      children: [
        Expanded(
          child: ListView.builder(
            itemCount: itemsShown.length,
            itemBuilder: (context, index) {
              return PostCard(item: itemsShown[index]);
            },
          ),
        ),
        Positioned(
          bottom: 0,
          left: 30.0,
          child: FloatingActionButton(
            onPressed: widget.onFilterToggle,
            tooltip: 'Filter Favorites',
            child: Icon(widget.showFavorites
                ? Icons.filter_alt_off
                : Icons.filter_alt),
          ),
        ),
      ],
    );
  }
}
