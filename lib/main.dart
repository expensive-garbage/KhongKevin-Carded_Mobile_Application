import 'package:carded/QRScanner.dart';
import 'package:carded/settings_screen.dart';
import 'package:carded/sign_up_screen.dart';
import 'package:carded/wallet_display_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'QRGenerator.dart';
import 'login_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'user.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
    ChangeNotifierProvider(
      create: (context) => UserProvider(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Carded',
      theme: ThemeData(

        primarySwatch: Colors.orange,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: const CardedHomePage(),
    );
  }
}
class CardedHomePage extends StatelessWidget {
  const CardedHomePage({super.key});

  Future<User?> getCurrentUser(BuildContext context) async {
    final firebaseUser = auth.FirebaseAuth.instance.currentUser;
    if (firebaseUser != null) {
      final docSnapshot = await FirebaseFirestore.instance
          .collection('users')
          .doc(firebaseUser.uid)
          .get();
      if (docSnapshot.exists) {
        User user = User.fromDocument(docSnapshot);
        Provider.of<UserProvider>(context, listen: false).setUser(user);
        return user;
      }
    }
    // Return test user if no logged in user or user does not exist in Firestore
    return User("defaultID", "defaultEmail", "defaultCard", []);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<User?>(
      future: getCurrentUser(context),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator();
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else {
          final user = snapshot.data;
          return Scaffold(
              appBar: AppBar(title: const Text("Carded")),
              body: FractionallySizedBox(
                  heightFactor: 0.7,
                  child:
                  Center(
                      child:
                      SingleChildScrollView(
                          child: Column(
                              mainAxisAlignment: MainAxisAlignment.center, crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                SizedBox(width: 200.0, child: ElevatedButton(
                                  child: Text("Login Page"),
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(builder: (context) => LoginScreen()),
                                    );
                                  },
                                ),
                                ),

                                SizedBox(height: 50),
                          SizedBox(
                            width: 200.0, // set the desired width here
                            child: ElevatedButton(
                              child: Text("Sign Up Page"),
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => SignUpScreen()),
                                );
                              },
                            ),
                          ),
                          SizedBox(height: 50),
                          SizedBox(
                            width: 200.0, // set the desired width here
                            child: ElevatedButton(
                              child: Text("Settings"),
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => SettingsScreen()),
                                );
                              },
                            ),
                          ),
                          SizedBox(height: 50),

                                //This is a test, hard coded wallet in here in case the sign in / login authorization does not work :D
                                SizedBox(
                                  width: 200.0, // set the desired width here
                                  child: ElevatedButton(
                                    child: Text("wallet display"),
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(builder: (context) => WalletDisplayScreen(loggedin: user ?? User("defaultID", "defaultEmail", "defaultCard", []))),
                                      );
                                    },
                                  ),
                                ),
                              ]
                          )
                      )
                  )
              )
          );
        }
      },
    );
  }
}


