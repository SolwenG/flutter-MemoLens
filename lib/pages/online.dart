import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'gallery.dart';
import 'archive.dart';
import 'camera.dart';

class OnlinePage extends StatefulWidget {
  const OnlinePage({
    super.key,
    required this.title,
    required this.name,
    required this.logOut,
    required this.camera,
  });

  final String title;
  final String name;
  final Function() logOut;
  final CameraDescription camera;

  @override
  State<OnlinePage> createState() => _OnlinePageState();
}

class _OnlinePageState extends State<OnlinePage> {
  int _selectedIndex = 0;
  bool smallScreen = true;

  void _selectIndex(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  late final List<Widget> _pages = [
    GalleryPage(name: widget.name, camera: widget.camera),
    CameraPage(camera: widget.camera),
    const ArchivePage(),
  ];

  @override
  Widget build(BuildContext context) {
    const darkBlue = Color(0xFF36618e);

    return LayoutBuilder(
      builder: (context, constraints) {
        smallScreen = constraints.maxWidth < 950;

        return Scaffold(
          appBar: AppBar(
            backgroundColor: Theme.of(context).colorScheme.primary,
            centerTitle: true,
            title: Padding(
                padding: const EdgeInsets.all(30.0),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        widget.title,
                        style: const TextStyle(color: Colors.white),
                      ),
                      IconButton(
                        icon: const Icon(Icons.logout),
                        color: Colors.white,
                        onPressed: widget.logOut,
                        tooltip: 'Log Out',
                      )
                    ])),
          ),
          body: smallScreen
              ? _pages[_selectedIndex]
              : Row(
                  children: [
                    SizedBox(
                        width: 180,
                        child: NavigationRail(
                          extended: true,
                          backgroundColor: Theme.of(context).hoverColor,
                          destinations: const [
                            NavigationRailDestination(
                              icon: Icon(Icons.photo_album),
                              label: Text("Gallery"),
                            ),
                            NavigationRailDestination(
                              icon: Icon(Icons.photo_camera),
                              label: Text("Camera"),
                            ),
                            NavigationRailDestination(
                              icon: Icon(Icons.delete),
                              label: Text("Archive"),
                            ),
                          ],
                          selectedIndex: _selectedIndex,
                          onDestinationSelected: _selectIndex,
                          selectedLabelTextStyle: const TextStyle(
                              fontWeight: FontWeight.bold, color: Colors.red),
                          unselectedLabelTextStyle: const TextStyle(
                              fontWeight: FontWeight.bold, color: darkBlue),
                          selectedIconTheme:
                              const IconThemeData(color: Colors.red),
                          unselectedIconTheme:
                              const IconThemeData(color: darkBlue),
                        )),
                    Expanded(child: _pages[_selectedIndex]),
                  ],
                ),
          bottomNavigationBar: smallScreen
              ? BottomNavigationBar(
                  items: const [
                    BottomNavigationBarItem(
                      icon: Icon(Icons.photo_album),
                      label: "Gallery",
                    ),
                    BottomNavigationBarItem(
                      icon: Icon(Icons.photo_camera),
                      label: "Camera",
                    ),
                    BottomNavigationBarItem(
                      icon: Icon(Icons.delete),
                      label: "Archive",
                    ),
                  ],
                  currentIndex: _selectedIndex,
                  onTap: _selectIndex,
                  selectedItemColor: Colors.red,
                  unselectedItemColor: darkBlue,
                )
              : null,
        );
      },
    );
  }
}
