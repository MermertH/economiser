import 'package:economiser/AuthScreen/services/auth_services.dart';
import 'package:economiser/MainPage/main_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthController with ChangeNotifier {
  var formKey = new GlobalKey<FormState>();
  final _authServices = AuthServices();
  String _userMail = '';
  String _userPassword = '';
  bool _isLogin = true;
  bool _isLoading = false;

  String get getUserMail => _userMail;
  String get getUserPassword => _userPassword;
  bool get getIsLogin => _isLogin;
  bool get getIsLoading => _isLoading;

  set setUserMail(String mail) {
    _userMail = mail;
    notifyListeners();
  }

  set setUserPassword(String password) {
    _userPassword = password;
    notifyListeners();
  }

  set setIsLogin(bool condition) {
    _isLogin = condition;
    notifyListeners();
  }

  set setIsLoading(bool condition) {
    _isLoading = condition;
    notifyListeners();
  }

  Future<bool> submitAuthForm(
    BuildContext context,
  ) async {
    try {
      setIsLoading = true;
      if (_isLogin) {
        await _authServices.authLogin(_userMail, _userPassword);
        return true;
      } else {
        await _authServices.authRegister(_userMail, _userPassword);
        return true;
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
      setIsLoading = false;
      return false;
    } catch (err) {
      print(err);
      setIsLoading = false;
      return false;
    }
  }

  Future<void> trySubmit(BuildContext context) async {
    final isValid = formKey.currentState.validate();
    FocusScope.of(context).unfocus();
    if (isValid) {
      formKey.currentState.save();
      print('Current accepted mail is $_userMail');
      print('Current accepted password is $_userPassword');
      await submitAuthForm(context)
          .then((value) => value ? submitSuccessful(context) : null);
    }
    notifyListeners();
  }

  void submitSuccessful(BuildContext context) {
    Navigator.of(context).pushReplacement(MaterialPageRoute(
      builder: (context) => MainPage(),
    ));
  }
}
