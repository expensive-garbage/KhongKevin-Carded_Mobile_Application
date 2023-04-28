import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Carded',
      theme: ThemeData(

        primarySwatch: Colors.orange,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: CardedHomePage(),
    );
  }
}


class CardedHomePage extends StatelessWidget{
  const CardedHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("Carded")),
        body: Column(children: <Widget>[
          SizedBox(height: 200),
          TextInputWidget(),
          SizedBox(height: 50),
          (NavigationButton()),
          SizedBox(height: 50),

          NavigationButton()]),);

  }

}

class NavigationButton extends StatelessWidget {
  @override
  Widget build(BuildContext context){
    return Center(child: Text("Nav Button"));
  }
}

class LoginWidget extends StatefulWidget {

  @override
  _TextInputWidgetState createState() => _TextInputWidgetState();
}

class _TextInputWidgetState extends State<LoginWidget> {
  @override
  Widget build(BuildContext context) {
    return TextField(decoration: InputDecoration(prefixIcon: Icon(Icons.account_circle), labelText: "Login Username:"),);

  }
}
