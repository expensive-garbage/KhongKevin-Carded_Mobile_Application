import 'package:carded/email_text_field.dart';
import 'package:flutter/material.dart';
import 'username_text_field.dart';
import 'password_text_field.dart';
import 'package:firebase_database/firebase_database.dart';
class SignUpScreen extends StatelessWidget {
  FirebaseDatabase database = FirebaseDatabase.instance;
  @override
  Widget build(BuildContext context){
    return Scaffold(
        appBar: AppBar(title: Text("Sign Up Screen")),
        body: FractionallySizedBox(
            heightFactor: 0.7,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [

                UsernameTextField(),
                PasswordTextField(),
                EmailTextField(),
                ElevatedButton(onPressed: () {  },
                    child: Text("Sign Up!"))],
            )
        )

    );
  }

}
