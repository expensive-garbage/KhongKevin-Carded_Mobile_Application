import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'user_card.dart';

class GuestSignInScreen extends StatefulWidget {
  @override
  _GuestSignInScreenState createState() => _GuestSignInScreenState();
}
class _GuestSignInScreenState extends State<GuestSignInScreen> {
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  void dispose() {
    firstNameController.dispose();
    lastNameController.dispose();
    emailController.dispose();
    super.dispose();
  }

  Future<User?> signInGuest() async {
    String firstName = firstNameController.text.trim();
    String lastName = lastNameController.text.trim();
    String email = emailController.text.trim();

    try {
      UserCredential userCredential = await _auth.signInAnonymously();
      User? user = userCredential.user;
      if (user != null) {
        String cardId = await User_Card.addCard(firstName, lastName, email);
        print('Guest signed in:');
        print('First Name: $firstName');
        print('Last Name: $lastName');
        print('Email: $email');
        await _addUser(user.uid, email, cardId);
        showSnackBar(context, 'Success');
        Navigator.pop(context);  // navigate back to home screen
        return user; // Return the signed-in user
      }
    } catch (e) {
      print(e);
      showSnackBar(context, 'Fail');
    }
    return null;
  }

  Future<void> _addUser(String uid, String email, String cardId) {
    return database.collection('users').doc(uid).set({
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
  @override
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
