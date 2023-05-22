
import 'package:carded/user_card.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

FirebaseFirestore database = FirebaseFirestore.instance;

class User{
  late String refId;
  late String email;
  late String card;
  List<String> wallet = [];

  User(String r, String e, String c, List<dynamic> w){
    refId = r;
    email = e;
    card = c;
    wallet = List<String>.from(w);
  }

  Future<String> get firstName async {
    DocumentSnapshot cardDocument = await database.collection('cards').doc(card).get();
    if (cardDocument.exists) {
      Map<String, dynamic> cardData = cardDocument.data() as Map<String, dynamic>;
      return cardData['contactPage']['Fname'] as String;
    } else {
      throw Exception('Card document does not exist.');
    }
  }

  Future<String> get lastName async {
    DocumentSnapshot cardDocument = await database.collection('cards').doc(card).get();
    if (cardDocument.exists) {
      Map<String, dynamic> cardData = cardDocument.data() as Map<String, dynamic>;
      return cardData['contactPage']['Fname'] as String;
    } else {
      throw Exception('Card document does not exist.');
    }
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

  @override
  String toString(){
    return("${refId}, ${email}, ${card}, ${wallet}");
  }
}