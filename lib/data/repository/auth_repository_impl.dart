import 'package:scooter_app/data/datasources/firebase_auth_datasource.dart';
import 'package:scooter_app/data/model/user_model.dart';
import 'package:scooter_app/domain/repository/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final FirebaseAuthDataSource ds;

  AuthRepositoryImpl(this.ds);

  @override
  UserModel? get currentUser => ds.currentUser();

  @override
  Future<UserModel> signIn({required String email, required String password}) =>
      ds.signIn(email, password);

  @override
  Future<UserModel> signOut() async {
    await ds.signOut();
    return ds.currentUser()!;
  }
  @override
  Future<UserModel> signUp(
          {required String name,
          required String email,
          required String password}) =>
      ds.signUp(name, email, password);
      
     
      
    
}
