import 'package:flutter/material.dart';

class AuthenticationForm extends StatefulWidget {
  final void Function(
          String email, String password, bool isLogin, BuildContext context)
      submitAuthForm;
  final bool isLoading;
  AuthenticationForm(this.submitAuthForm, this.isLoading);

  @override
  _AuthenticationFormState createState() => _AuthenticationFormState();
}

class _AuthenticationFormState extends State<AuthenticationForm> {
  var _formKey = new GlobalKey<FormState>();
  String _userMail = '';
  String _userPassword = '';
  bool _islogin = true;

  void trySubmit() {
    final isValid = _formKey.currentState.validate();
    FocusScope.of(context).unfocus();
    if (isValid) {
      _formKey.currentState.save();
      print('Current accepted mail is $_userMail');
      print('Current accepted password is $_userPassword');
      widget.submitAuthForm(
        _userMail.trim(),
        _userPassword.trim(),
        _islogin,
        context,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    var maxWidth = MediaQuery.of(context).size.width;
    var maxHeight = MediaQuery.of(context).size.height;
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.grey[850],
        appBar: AppBar(
          title: Text(
            'Economiser',
            style: TextStyle(
              fontSize: maxHeight * 0.0306,
            ),
          ),
          centerTitle: true,
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              backgroundColor: Colors.orange,
              radius: maxHeight * 0.0735,
              child: FittedBox(
                child: Icon(
                  Icons.account_balance,
                  size: maxHeight * 0.0735,
                  color: Colors.grey[850],
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: maxHeight * 0.0122),
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.orange[400],
                    borderRadius: BorderRadius.circular(20)),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: FittedBox(
                    child: Text(
                      'Welcome To Economiser',
                      style: TextStyle(
                        fontSize: maxHeight * 0.0367,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.amber[600],
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(height: maxHeight * 0.0551),
                        TextFormField(
                          key: ValueKey('email'),
                          validator: (value) {
                            if (value.isEmpty || !value.contains('@')) {
                              return 'Please enter a valid email';
                            } else {
                              return null;
                            }
                          },
                          onSaved: (value) {
                            _userMail = value;
                          },
                          decoration: InputDecoration(
                              contentPadding: EdgeInsets.fromLTRB(
                                  maxWidth * 0.0462,
                                  maxHeight * 0.0183,
                                  maxWidth * 0.0462,
                                  maxHeight * 0.0183),
                              hintText: "Email",
                              hintStyle: TextStyle(
                                color: Colors.black,
                              ),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(32.0))),
                        ),
                        SizedBox(height: maxHeight * 0.0306),
                        TextFormField(
                          key: ValueKey('password'),
                          validator: (value) {
                            if (value.length <= 7) {
                              return 'password length must be higher than 7 characters';
                            } else {
                              return null;
                            }
                          },
                          onSaved: (value) {
                            _userPassword = value;
                          },
                          obscureText: true,
                          decoration: InputDecoration(
                              contentPadding: EdgeInsets.fromLTRB(
                                  maxWidth * 0.0462,
                                  maxHeight * 0.0183,
                                  maxWidth * 0.0462,
                                  maxHeight * 0.0183),
                              hintText: "Password",
                              hintStyle: TextStyle(
                                color: Colors.black,
                              ),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(32.0))),
                        ),
                        SizedBox(height: maxHeight * 0.0428),
                        if (widget.isLoading) CircularProgressIndicator(),
                        if (!widget.isLoading)
                          TextButton(
                            onPressed: () {
                              trySubmit();
                            },
                            style: TextButton.styleFrom(
                              primary: Colors.black,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                              backgroundColor: Colors.orange,
                            ),
                            child: FittedBox(
                                child: Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: maxWidth * 0.0694),
                              child: Text(_islogin ? 'Login' : 'SignUp'),
                            )),
                          ),
                        SizedBox(height: maxHeight * 0.0183),
                        if (!widget.isLoading)
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                _islogin = !_islogin;
                              });
                            },
                            child: FittedBox(
                              child: Text(_islogin
                                  ? 'Don\'t have an account? Press here to sign in'
                                  : 'Have an account? Press here to login'),
                            ),
                          ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.amber[900],
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: FittedBox(
                    child: Text(
                      'Please enter your email and password to login or sign up',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: maxHeight * 0.0196,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
