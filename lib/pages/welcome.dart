import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class WelcomePage extends StatefulWidget {
  const WelcomePage({super.key, required this.title, required this.logIn});

  final String title;
  final Function(String) logIn;

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  String _name = "";
  TextEditingController nameController = TextEditingController();

  void _handleLogin() async {
    String name = nameController.text;
    if (name.isNotEmpty) {
      SharedPreferences local = await SharedPreferences.getInstance();
      await local.setString('name', name);
      widget.logIn(name);
    }
  }

  @override
  void dispose() {
    nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const darkBlue = Color(0xFF36618e);

    return Scaffold(
        appBar: AppBar(
            backgroundColor: Theme.of(context).colorScheme.primary,
            centerTitle: true,
            title: Text(
              widget.title,
              style: const TextStyle(color: Colors.white),
            )),
        body: Center(
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                  padding: const EdgeInsets.symmetric(vertical: 70),
                  child: Image.network(
                    'https://images.unsplash.com/photo-1460467820054-c87ab43e9b59?q=80&w=1367&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
                    height: 200,
                    width: 400,
                    fit: BoxFit.cover,
                  )),
              SizedBox(
                width: 300,
                child: TextField(
                  controller: nameController,
                  onSubmitted: (String value) {
                    _name = value;
                  },
                  decoration: const InputDecoration(
                    labelText: 'Enter your name',
                    labelStyle: TextStyle(color: darkBlue),
                    fillColor: darkBlue,
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.red, width: 2),
                        borderRadius: BorderRadius.all(Radius.circular(10))),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              FilledButton(
                onPressed: _handleLogin,
                style: ButtonStyle(
                    backgroundColor: WidgetStateProperty.all(darkBlue)),
                child:
                    const Text("Log in", style: TextStyle(color: Colors.white)),
              ),
            ],
          ),
        ));
  }
}
