// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:carded/main.dart';
import 'package:carded/login_screen.dart';

void main() {

  testWidgets('Pressing the Login Page button navigates to the Login Screen', (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());

    await tester.tap(find.text("Login Page"));
    await tester.pumpAndSettle();

    expect(find.text("Google Sign in"), findsOneWidget);
  });

  // // TODO not working?
  // testWidgets('Pressing the Sign Up Page button navigates to the Sign Up Screen', (WidgetTester tester) async {
  //   WidgetsFlutterBinding.ensureInitialized();
  //   await Firebase.initializeApp();
  //   await tester.pumpWidget(const MyApp());
  //
  //   await tester.tap(find.text("Sign Up Page"));
  //   await tester.pumpAndSettle();
  //
  //   expect(find.text("Sign up with email"), findsNothing);
  // });

  testWidgets('Pressing the Settings Page button navigates to the Settings Screen', (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());

    await tester.tap(find.text("Settings"));
    await tester.pumpAndSettle();

    expect(find.text("I am broke"), findsOneWidget);
  });

  testWidgets('Pressing the wallet display button navigates to the wallet Screen', (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());

    await tester.tap(find.text("wallet display"));
    await tester.pumpAndSettle();

    expect(find.text("Show Wallet"), findsOneWidget);
  });

}
