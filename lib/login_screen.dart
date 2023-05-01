import 'package:carded/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
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
              DocumentReference doc = database.collection("users").where("Email", isEqualTo: value!.email) as DocumentReference<Object?>;
              print(doc.id);
            });
          },
          color: Colors.deepOrange,
          height: 50,
          minWidth: 100,
          child: const Text(
            'Google Sign in',
            style: TextStyle(
              color: Colors.black
            ),
          ),
        ),
      ),
    );
  }

}
