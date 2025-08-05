import 'package:flutter/material.dart';

class RentsPage extends StatelessWidget {
  const RentsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text('Rents'),
        backgroundColor: Colors.yellow,
      ),
      body: const Center(
        child: Text(
          'Your scooter rents will appear here.',
          style: TextStyle(color: Colors.white, fontSize: 20),
        ),
      ),
    );
  }
} 