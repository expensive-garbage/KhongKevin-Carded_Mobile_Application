import 'package:carded/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'user_card.dart';
import 'wallet_display_screen.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'user.dart' as thisUser;

class GuestSignInScreen extends StatefulWidget {
  @override
  _GuestSignInScreenState createState() => _GuestSignInScreenState();
}

class _GuestSignInScreenState extends State<GuestSignInScreen> {
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  final auth.FirebaseAuth _auth = auth.FirebaseAuth.instance;

  void dispose() {
    firstNameController.dispose();
    lastNameController.dispose();
    emailController.dispose();
    super.dispose();
  }

  void signInGuest() async {
    String firstName = firstNameController.text.trim();
    String lastName = lastNameController.text.trim();
    String email = emailController.text.trim();

    try {
      auth.UserCredential userCredential = await _auth.signInAnonymously();
      auth.User? firebaseUser = userCredential.user;
      if (firebaseUser != null) {
        String cardId = await User_Card.addCard(firstName, lastName, email);
        print('Guest signed in:');
        print('First Name: $firstName');
        print('Last Name: $lastName');
        print('Email: $email');
        await _addUser(email, cardId);
        showSnackBar(context, 'Success');

        DocumentSnapshot docSnapshot = await FirebaseFirestore.instance.collection('users').doc(firebaseUser.uid).get();

        User loggedIn = User(
            docSnapshot.id,
            docSnapshot['Email'],
            docSnapshot['Card'],
            docSnapshot['Wallet']);


        // TODO WHY NO WORK
        //await Future.delayed(Duration(seconds: 3));
        //page not building right?
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => WalletDisplayScreen(loggedin: loggedIn)),
        );
      }
    } catch (e) {
      print(e);
      showSnackBar(context, 'Fail');
    }
  }

  Future<void> _addUser(String email, String cardId) {
    return FirebaseFirestore.instance.collection('users').add({
      'Email': email,
      'Card': cardId,
      'Wallet': [],
    });
  }

  void showSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
      ),
    );
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Guest Sign In'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextFormField(
              controller: firstNameController,
              decoration: InputDecoration(
                labelText: 'First Name',
              ),
            ),
            SizedBox(height: 16.0),
            TextFormField(
              controller: lastNameController,
              decoration: InputDecoration(
                labelText: 'Last Name',
              ),
            ),
            SizedBox(height: 16.0),
            TextFormField(
              controller: emailController,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                labelText: 'Email',
              ),
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: signInGuest,
              child: Text('Sign In'),
            ),
          ],
        ),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: GuestSignInScreen(),
  ));
}
