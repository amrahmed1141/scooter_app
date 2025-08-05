import 'package:flutter/material.dart';

class MySearchBar extends StatefulWidget {
  const MySearchBar({super.key});

  @override
  State<MySearchBar> createState() => _MySearchBarState();
}

class _MySearchBarState extends State<MySearchBar> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      child: TextField( 
        style: const TextStyle(color: Colors.white),
        decoration: InputDecoration(
          focusColor: Colors.yellow.shade300, // Lighter yellow for focus effect
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: BorderSide(
                color: Colors.yellow.shade200), // Lighter yellow border
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: BorderSide(
                color: Colors.grey.shade600), // Optional: Adjust enabled border
          ),
          border: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.circular(30),
          ),
          filled: true,
          fillColor: const Color(0xFF2E2E2E),
          prefixIcon: const Icon(Icons.search, color: Colors.white),
          hintText: 'Search for scooters',
          hintStyle: const TextStyle(color: Colors.white70),
        ),
      ),
    );
  }
}
