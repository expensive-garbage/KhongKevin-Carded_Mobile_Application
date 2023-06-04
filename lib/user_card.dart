import 'dart:ui';
import 'package:flutter/foundation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

FirebaseFirestore database = FirebaseFirestore.instance;

class User_Card with ChangeNotifier {
  late Image? profilePicture;
  late Map<String, String> contactPage;
  late Map<String, String> bioPage;
  late List<String> skills;

  User_Card(this.contactPage, this.bioPage, this.skills);

  User_Card.fromDocument(DocumentSnapshot doc) {
    this.contactPage = Map<String, String>.from(doc['contactPage'] ?? {});
    this.bioPage = Map<String, String>.from(doc['bioPage'] ?? {});
    this.skills = List<String>.from(doc['skills'] ?? []);
    notifyListeners();
  }

  static Future<String> addCard(String fname, String lname, String email) async {
    final card = <String, dynamic>{
      "contactPage": {
        "Email": email,
        "Fname": fname,
        "Lname": lname,
        "Linkedin": "",
        "Website": ""
      },
      "bioPage":{
        "Current Employment": "",
        "Education": "",
        "Experience": ""
      }
    };
    DocumentReference docRef = await database.collection("cards").add(card);
    return docRef.id;
  }
}
