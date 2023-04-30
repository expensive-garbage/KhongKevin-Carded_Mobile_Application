import 'dart:ffi';
import 'dart:ui';

class Card {
  late Int userId;
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
}