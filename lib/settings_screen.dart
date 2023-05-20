import 'package:flutter/material.dart';

class SettingsScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context){
    return Scaffold(
        appBar: AppBar(title: Text("Login Screen")),
        body: FractionallySizedBox(
            heightFactor: 0.7,
            child: Center(
              child:Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text("Idk what to put here lol"),
                  ElevatedButton(onPressed: () {  },
                      child: Text("I am broke"))],
              )
            )
        )

    );
  }

}
