import 'package:flutter/material.dart';
import 'package:memo_lens/pages/newpage.dart';
import '../gallery_widgets/post_list.dart';
import '../gallery_widgets/post_card.dart';

class GalleryPage extends StatefulWidget {
  final String name;

  const GalleryPage({super.key, required this.name});

  @override
  State<GalleryPage> createState() => _GalleryPageState();
}

class _GalleryPageState extends State<GalleryPage> {
  late List<Item> items;
  bool showFavorites = false;
  int _selectedIndex = 0;

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

  void _addItem() {
    setState(() {
      items = [
        Item(
          image: 'https://picsum.photos/300/300?random=${items.length + 1}',
          text: 'Item n°${items.length + 1}',
        ),
        ...items,
      ];
    });
  }

  void _toggleFilter() {
    setState(() {
      showFavorites = !showFavorites;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        title: const Text('Gallery Page', style: TextStyle(color: Colors.white)),
      ),
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                Text('Hello ${widget.name} !',
                    style: const TextStyle(
                        fontSize: 26,
                        fontWeight: FontWeight.bold,
                        color: Colors.blueGrey)),
                Expanded(
                  child: PostList(
                    items: items,
                    onAddItem: _addItem,
                    showFavorites: showFavorites,
                    onFilterToggle: _toggleFilter,
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            bottom: 15,
            right: 30.0,
            child: FloatingActionButton(
              onPressed: _addItem,
              tooltip: 'Add Item',
              child: const Icon(Icons.photo_camera),
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.photo),
            label: 'Gallery',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add_reaction_rounded),
            label: 'New Page',
          ),
        ],
      ),
    );
  }
}
