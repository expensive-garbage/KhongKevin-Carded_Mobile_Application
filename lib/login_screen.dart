import 'package:flutter/material.dart';
import 'username_text_field.dart';
import 'password_text_field.dart';
import 'package:google_sign_in/google_sign_in.dart';
class LoginScreen extends StatelessWidget {
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
      ),
      body: Center(
        child: MaterialButton(
          onPressed: () {
            _googleSignIn.signIn().then((value) {
              String username = value!.displayName!;
              String profilePicture = value!.photoUrl!;
            });
          },
          color: Colors.deepOrange,
          height: 50,
          minWidth: 100,
          child: const Text(
            'Google Sign in',
            style: TextStyle(
              color: Colors.white
            ),
          ),
        ),
      ),
    );
  }

}
