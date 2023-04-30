import 'package:carded/card.dart';

class User{
  late int userId;
  late String email;
  late String password;
  late Card card;
  List<Card> wallet = [];

  User(String e, String fname, String lname, String p){
    email = e;
    password = p;
    card = Card(fname, lname, email);
  }
}