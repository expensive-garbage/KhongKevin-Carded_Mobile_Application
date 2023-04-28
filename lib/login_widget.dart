import 'package:flutter/material.dart';


class LoginWidget extends StatefulWidget {

  @override
  _TextInputWidgetState createState() => _TextInputWidgetState();
}

class _TextInputWidgetState extends State<LoginWidget> {
  final controller = TextEditingController();
  String text = "";
  @override
  void dispose(){
    super.dispose();
    controller.dispose();
  }

  void changeText(text){
    setState(() {
      this.text = text;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(children:<Widget>[
    TextField(
    controller: this.controller,
      decoration: InputDecoration(
          prefixIcon: Icon(Icons.account_circle),
          labelText: "Login Username:"),
      onChanged: (text)=> this.changeText(text),
    ),
      Text(text)
    ]);

  }
}
