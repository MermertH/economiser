import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthServices {
  final _auth = FirebaseAuth.instance;

  Future<void> authLogin(String email, String password) async {
    _auth.signInWithEmailAndPassword(email: email, password: password);
  }

  Future<void> authRegister(String email, String password) async {
    UserCredential _userAuth;
    _userAuth = await _auth.createUserWithEmailAndPassword(
        email: email, password: password);
    await FirebaseFirestore.instance
        .collection('users')
        .doc(_userAuth.user.uid)
        .set({
      'email': email,
      'password': password,
    });
  }
}
