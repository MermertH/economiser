import './authentication.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthenticationPage extends StatefulWidget {
  @override
  State<AuthenticationPage> createState() => _AuthenticationPageState();
}

class _AuthenticationPageState extends State<AuthenticationPage> {
  final _auth = FirebaseAuth.instance;
  bool _isLoading = false;

  void _submitAuthForm(
    String email,
    String password,
    bool isLogin,
    BuildContext context,
  ) async {
    try {
      setState(() {
        _isLoading = true;
      });
      if (isLogin) {
        await _auth.signInWithEmailAndPassword(
            email: email, password: password);
      } else {
        await _auth.createUserWithEmailAndPassword(
            email: email, password: password);
      }
    } on FirebaseAuthException catch (err) {
      var message = 'An error occured, please check your credentials!';
      if (err.message != null) {
        message = err.message;
      }
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(message),
          backgroundColor: Theme.of(context).errorColor,
        ),
      );
      setState(() {
        _isLoading = false;
      });
    } catch (err) {
      print(err);
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return AuthenticationForm(_submitAuthForm,_isLoading);
  }
}
