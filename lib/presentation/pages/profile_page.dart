import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text('Profile'),
        backgroundColor: Colors.yellow,
      ),
      body: const Center(
        child: Text(
          'Your profile information will appear here.',
          style: TextStyle(color: Colors.white, fontSize: 20),
        ),
      ),
    );
  }
} 