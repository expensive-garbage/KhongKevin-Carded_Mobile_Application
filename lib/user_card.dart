import 'dart:ui';
import 'package:cloud_firestore/cloud_firestore.dart';

FirebaseFirestore database = FirebaseFirestore.instance;

class User_Card {
  late Image profilePicture;
  Map<String, String> contactPage = {
    'Fname': '',
    'Lname':'',
    'Email':'',
    'Linkedin':'',
    'Website':''
  };
  Map<String, String> bioPage = {
    'Education':'',
    'Experience':'',
    'Current Employment':''
  };
  List<String> skills = [];

  User_Card(String fname, String lname, String email){
    contactPage['Fname'] = fname;
    contactPage['Lname'] = lname;
    contactPage['Email'] = email;
  }

  User_Card.fromDocument(DocumentSnapshot doc) {
    this.contactPage = Map<String, String>.from(doc['contactPage'] ?? {});
    this.bioPage = Map<String, String>.from(doc['bioPage'] ?? {});
    this.skills = List<String>.from(doc['skills'] ?? []);
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