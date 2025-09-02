import 'package:scooter_app/data/model/user_model.dart';

/// contract the function that i need in auth

abstract class AuthRepository {
  Future<UserModel> signIn({required String email, required String password});

  Future<UserModel> signUp(
      {required String name, required String email, required String password});

  Future<UserModel> signOut();

  UserModel? get currentUser;
}
