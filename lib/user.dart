
import 'package:carded/user_card.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

FirebaseFirestore database = FirebaseFirestore.instance;

class User{
  late int userId;
  late String email;
  late User_Card card;
  List<User_Card> wallet = [];

  User(String e, String fname, String lname){
    email = e;
    card = User_Card(fname, lname, email);
  }

  static Future<void> addUser(String email, String fname, String lname) async {
    String cardID = await User_Card.addCard(fname, lname, email);
    print("Card added");
    final user = <String, dynamic>{
      "Card": cardID,
      "Email": email,
      "Wallet":[]
    };
    database.collection("users").add(user);
    print("User added");
  }
}