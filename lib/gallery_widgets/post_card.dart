import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Item {
  String image;
  String text;
  bool favorite;
  String date;

  Item({
    required this.image,
    required this.text,
    this.favorite = false,
    String? date,
  }) : date = date ?? DateFormat('dd/MM/yyyy').format(DateTime.now());
}

class PostCard extends StatefulWidget {
  final Item item;

  const PostCard({
    super.key,
    required this.item,
  });

  @override
  PostCardState createState() => PostCardState();
}

class PostCardState extends State<PostCard> {
  void _toggleFavorite() {
    setState(() {
      widget.item.favorite = !widget.item.favorite;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: Center(
        child: SizedBox(
          width: 300,
          height: 390,
          child: Card(
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                children: [
                  Image.network(
                    widget.item.image,
                    width: 250,
                    height: 250,
                    fit: BoxFit.cover,
                  ),
                  const SizedBox(height: 10),
                  Text(
                    widget.item.text,
                    style: const TextStyle(
                        fontSize: 18, fontStyle: FontStyle.italic),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        width: 40,
                        child: MaterialButton(
                          onPressed: _toggleFavorite,
                          textColor: Colors.red,
                          child: Icon(
                            widget.item.favorite
                                ? Icons.favorite
                                : Icons.favorite_border,
                          ),
                        ),
                      ),
                      Text(widget.item.date),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
