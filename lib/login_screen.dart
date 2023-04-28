import 'package:flutter/material.dart';
import 'username_text_field.dart';
class LoginScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(title: Text("Login Screen")),
      body:Center(
        child: Column(
          children: [
            SizedBox(height: 200),
            UsernameTextField(),

            ElevatedButton(onPressed: () {  },
          child: Text("Login!"))],
        )
      )
    );
  }

}
