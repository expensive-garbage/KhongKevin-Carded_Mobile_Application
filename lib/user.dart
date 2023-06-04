
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

  User.fromDocument(DocumentSnapshot doc) {
    this.refId = doc.id;
    this.email = doc['email'] ?? '';
    this.card = doc['card'] ?? '';
    this.wallet = List<String>.from(doc['wallet'] ?? []);
  }


  Future<void> addCardToWallet(String cardId) async {
    wallet.add(cardId);

    DocumentReference userRef = database.collection("users").doc(refId);
    await userRef.update({
      "Wallet": wallet
    });

    print("Card $cardId added to wallet");
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

  Future<List<User_Card>> fetchWalletUsers() async {
    List<User_Card> walletUsers = [];

    for (var cardId in wallet) {
      DocumentSnapshot docSnapshot = await database.collection('cards').doc(cardId).get();
      User_Card userCard = User_Card.fromDocument(docSnapshot);

      walletUsers.add(userCard);
    }

    return walletUsers;
  }



  @override
  String toString(){
    return("$refId, $email, $card, $wallet");
  }
}