import 'dart:ffi';
import 'dart:ui';

class UserCard {
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

  UserCard(String fname, String lname, String email){
    contactPage['Fname'] = fname;
    contactPage['Lname'] = lname;
    contactPage['Email'] = email;
  }
}