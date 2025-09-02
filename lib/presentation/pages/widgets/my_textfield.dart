import 'package:flutter/material.dart';

class MyTextfield extends StatelessWidget {
  final controller;
  final String hintText;
  final bool obscureText;
  final IconData prefixIcon;
  const MyTextfield({super.key, this.controller, required this.hintText, required this.obscureText, required this.prefixIcon});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      obscureText: obscureText,
      style: const TextStyle(color: Colors.white),
      decoration: InputDecoration(
        fillColor: Colors.grey.shade900,
        filled: true,
        hintStyle: const TextStyle(color: Colors.grey),
        prefixIcon:Icon(
         prefixIcon,
          color: Colors.grey,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: const BorderSide(color: Colors.white),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: const BorderSide(color: Colors.grey),
        ),
        labelText: hintText,
        labelStyle: const TextStyle(color: Colors.white),
      ),
    );
  }
}
