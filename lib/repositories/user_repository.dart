import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

class UserRepository {
  FirebaseAuth _firebaseAuth;
  FirebaseFirestore _firestore;

  UserRepository({@required FirebaseFirestore firestore}) {
    this._firebaseAuth = FirebaseAuth.instance;
    this._firestore = firestore;
  }

  User getCurrentUser() => _firebaseAuth.currentUser;

  ///Handles signing in with e-mail & password.
  Future<UserCredential> signIn(String email, String password) async {
    try {
      bool isReviewer = await isUserReviewer(email);
      return isReviewer
          ? await _firebaseAuth.signInWithEmailAndPassword(
              email: email,
              password: password,
            )
          : null;
    } catch (exception) {
      print(exception.toString());
      return null;
    }
  }

  Future<bool> isUserReviewer(String email) async {
    try {
      return await _firestore
          .collection('reviewers')
          .where('email', isEqualTo: email)
          .get()
          .then((snap) => snap.docs.length > 0);
    } catch (exception) {
      print(exception.toString());
      return null;
    }
  }

  ///Handles signing out.
  Future<bool> signOut() async {
    try {
      return await _firebaseAuth.signOut().then((_) => true);
    } catch (exception) {
      print(exception.toString());
      return null;
    }
  }
}
