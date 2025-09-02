import 'package:flutter/material.dart';

class AdminUpload extends StatefulWidget {
  const AdminUpload({super.key});

  @override
  State<AdminUpload> createState() => _AdminUploadState();
}

class _AdminUploadState extends State<AdminUpload> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Admin Upload'),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(12),
            child: Column(
              children: [],
            ),
          ),
        ));
  }
}
