import 'package:carded/user_card.dart';

class User {
  late int userId;
  late String email;
  late String password;
  late UserCard card;
  List<UserCard> wallet = [];

  User(String e, String fname, String lname, String p) {
    email = e;
    password = p;
    card = UserCard(fname, lname, email);
  }
}
