import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:memo_lens/pages/online.dart';
import 'package:memo_lens/pages/welcome.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize the available cameras
  final cameras = await availableCameras();
  final firstCamera = cameras.isNotEmpty ? cameras.first : throw Exception('No cameras available');

  runApp(MyApp(camera: firstCamera));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key, required this.camera});

  final CameraDescription camera;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: MyHomePage(title: 'MemoLens', camera: camera),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title, required this.camera});

  final String title;
  final CameraDescription camera;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool _isLoggedIn = false;
  String _name = "";

  @override
  void initState() {
    super.initState();
    _checkLoginStatus();
  }

  Future<void> _checkLoginStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? savedName = prefs.getString('name');
    setState(() {
      _isLoggedIn = savedName != null && savedName.isNotEmpty;
      _name = savedName ?? "";
    });
  }

  void _logIn(String name) {
    setState(() {
      _isLoggedIn = true;
      _name = name;
    });
    _saveNameToPrefs(name);
  }

  Future<void> _saveNameToPrefs(String name) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('name', name);
  }

  void _logOut() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('name');
    setState(() {
      _isLoggedIn = false;
      _name = "";
    });
  }

  @override
  Widget build(BuildContext context) {
    if (!_isLoggedIn) {
      return WelcomePage(title: widget.title, logIn: _logIn);
    }
    return OnlinePage(
      title: widget.title,
      name: _name,
      logOut: _logOut,
      camera: widget.camera,
    );
  }
}
