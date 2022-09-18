import 'package:economiser/AuthScreen/controller/auth_controller.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class UserInputFormArea extends StatelessWidget {
  const UserInputFormArea({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var authProvider = Provider.of<AuthController>(context, listen: true);
    var maxWidth = MediaQuery.of(context).size.width;
    var maxHeight = MediaQuery.of(context).size.height;
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: maxWidth * 0.0347, vertical: maxHeight * 0.0183),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            colors: [
              Colors.amber[700],
              Colors.amber[500],
            ],
          ),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(
            vertical: maxHeight * 0.0183,
            horizontal: maxWidth * 0.0347,
          ), //15
          child: Form(
            key: authProvider.formKey,
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
                    authProvider.setUserMail = value;
                  },
                  decoration: InputDecoration(
                      contentPadding: EdgeInsets.fromLTRB(
                          maxWidth * 0.0462,
                          maxHeight * 0.0183,
                          maxWidth * 0.0462,
                          maxHeight * 0.0183),
                      hintText: "Email",
                      hintStyle: GoogleFonts.abel(
                        fontWeight: FontWeight.bold,
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
                    authProvider.setUserPassword = value;
                  },
                  obscureText: true,
                  decoration: InputDecoration(
                      contentPadding: EdgeInsets.fromLTRB(
                          maxWidth * 0.0462,
                          maxHeight * 0.0183,
                          maxWidth * 0.0462,
                          maxHeight * 0.0183),
                      hintText: "Password",
                      hintStyle: GoogleFonts.abel(
                        fontWeight: FontWeight.bold,
                      ),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(32.0))),
                ),
                SizedBox(height: maxHeight * 0.0428),
                if (authProvider.getIsLoading) CircularProgressIndicator(),
                if (!authProvider.getIsLoading)
                  Material(
                    color: Colors.amber[700],
                    borderRadius: BorderRadius.circular(20),
                    clipBehavior: Clip.hardEdge,
                    child: InkWell(
                      onTap: () {
                        authProvider.trySubmit(context);
                      },
                      child: Ink(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          gradient: LinearGradient(
                            begin: Alignment.topRight,
                            end: Alignment.bottomLeft,
                            colors: [
                              Colors.amber[800],
                              Colors.amber[700],
                            ],
                          ),
                        ),
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                              vertical: 4, horizontal: maxWidth * 0.0694),
                          child: Text(
                            authProvider.getIsLogin ? 'Login' : 'SignUp',
                            style: GoogleFonts.abel(
                              fontSize: maxHeight * 0.0196,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                SizedBox(height: maxHeight * 0.0183),
                if (!authProvider.getIsLoading)
                  GestureDetector(
                    onTap: () {
                      authProvider.setIsLogin = !authProvider.getIsLogin;
                    },
                    child: FittedBox(
                      child: Text(
                        authProvider.getIsLogin
                            ? 'Don\'t have an account? Press here to sign in'
                            : 'Have an account? Press here to login',
                        style: GoogleFonts.abel(
                          fontSize: maxHeight * 0.0196,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
