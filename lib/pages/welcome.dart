import 'package:flutter/material.dart';
import 'package:memo_lens/pages/gallery.dart';

class WelcomePage extends StatefulWidget {
  final Function(String) onLogin;

  const WelcomePage({super.key, required this.onLogin});

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  final TextEditingController _nameController = TextEditingController();

  void _handleLogin() {
    String name = _nameController.text.trim();
    widget.onLogin(name);
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Stack(
        children: [
          Positioned(
            top: 50.0,
            child: Image.network(
              'https://images.unsplash.com/photo-1460467820054-c87ab43e9b59?q=80&w=1067&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
              width: 300,
              height: 200,
              fit: BoxFit.cover,
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: 300,
                child: TextField(
                  controller: _nameController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Enter your name',
                  ),
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _handleLogin,
                child: const Text("Enter"),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
