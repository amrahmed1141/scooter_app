// that class talk with firebase and give instructions
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:scooter_app/data/model/user_model.dart';

class FirebaseAuthDataSource {
  final FirebaseAuth auth;
  final FirebaseFirestore db;

  FirebaseAuthDataSource(this.auth, this.db);

  Future<UserModel> signIn(String email, String password) async {
    final UserCredential userCredential =
        await auth.signInWithEmailAndPassword(email: email, password: password);

    final User firebaseUser = userCredential.user!;

    final DocumentSnapshot<Map<String, dynamic>> userDoc =
        await db.collection('users').doc(firebaseUser.uid).get();

    if (userDoc.exists) {
      return UserModel.fromMap(userDoc.data()!);
    }
    return UserModel(
      id: firebaseUser.uid,
      name: firebaseUser.displayName ?? '',
      email: firebaseUser.email ?? email,
    );
  }

  Future<UserModel> signUp(String name, String email, String password) async {
    final UserCredential userCredential = await auth
        .createUserWithEmailAndPassword(email: email, password: password);

    final User firebaseUser = userCredential.user!;

    await firebaseUser.updateDisplayName(name);
    final UserModel userModel =
        UserModel(id: firebaseUser.uid, name: name, email: email);
    await db.collection('users').doc(firebaseUser.uid).set(userModel.toMap());
    return userModel;
  }

  Future<void> signOut() => auth.signOut();

  UserModel? currentUser() {
    final User? firebaseUser = auth.currentUser;
    if (firebaseUser == null) return null;

    return UserModel(
      id: firebaseUser.uid,
      name: firebaseUser.displayName ?? '',
      email: firebaseUser.email ?? '',
    );
  }
}
