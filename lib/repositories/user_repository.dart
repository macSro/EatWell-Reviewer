import 'package:firebase_auth/firebase_auth.dart';

class UserRepository {
  FirebaseAuth _firebaseAuth;

  UserRepository() {
    _firebaseAuth = FirebaseAuth.instance;
  }

  User getCurrentUser() => _firebaseAuth.currentUser;

  ///Handles signing in with e-mail & password.
  Future<UserCredential> signIn(String email, String password) async {
    try {
      return await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
    } catch (exception) {
      print(exception.toString());
      return null;
    }
  }

  ///Handles signing out.
  Future<bool> signOut() async {
    try {
      return await _firebaseAuth.signOut().then((_)  => true);
    } catch (exception) {
      print(exception.toString());
      return null;
    }
  }
}
