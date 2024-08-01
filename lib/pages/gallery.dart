import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import '../gallery_widgets/post_card.dart';
import '../gallery_widgets/post_list.dart';

class GalleryPage extends StatefulWidget {
  const GalleryPage({super.key, required this.name, required this.camera});

  final String name;
  final CameraDescription camera;

  @override
  State<GalleryPage> createState() => _GalleryPageState();
}

class _GalleryPageState extends State<GalleryPage> {
  late List<Item> items;
  bool showFavorites = false;

  @override
  void initState() {
    super.initState();
    items = List.generate(
      10,
      (index) => Item(
        image: 'https://picsum.photos/300/300?random=$index',
        text: 'Item n°${index + 1}',
      ),
    );
  }

  void _toggleFilter() {
    setState(() {
      showFavorites = !showFavorites;
    });
  }

  @override
  Widget build(BuildContext context) {
    const darkBlue = Color(0xFF36618e);

    return Stack(
      children: [
        Padding(
          padding: const EdgeInsets.all(10.0),
          child:
    Column(
            children: [
              Text('Hello ${widget.name} !',
                  style: const TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                      color: darkBlue)),
              Expanded(
                child: PostList(
                  items: items,
                  showFavorites: showFavorites,
                  onFilterToggle: _toggleFilter,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
