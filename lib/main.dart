import 'package:flutter/material.dart';
import 'username_text_field.dart';
import 'login_screen.dart';
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
          ElevatedButton( child: Text("Login Page"), onPressed:(){
            Navigator.push(
                context, MaterialPageRoute(
                builder: (context) => LoginScreen()));
          }),
          SizedBox(height: 50),
          NavigationButton(),
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

