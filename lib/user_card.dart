import 'dart:ui';
import 'package:cloud_firestore/cloud_firestore.dart';

FirebaseFirestore database = FirebaseFirestore.instance;

class Card {
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

  Card(String fname, String lname, String email){
    contactPage['Fname'] = fname;
    contactPage['Lname'] = lname;
    contactPage['Email'] = email;
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