import 'package:firebase_auth/firebase_auth.dart';

class UserModel {
  final String id;
  final String name;
  final String email;

  UserModel({required this.id, required this.name, required this.email});

  // move data as map to firebase firestore
  Map<String, dynamic> toMap() => {'id': id, 'name': name, 'email': email};
  
  // convert map to dart code when take from firebase firestore 
  factory UserModel.fromMap(Map<String, dynamic> map) => UserModel(
        id: map['id'] as String,
        name: (map['name'] ?? '') as String,
        email: map['email'] as String,
      );
}
