// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:carded/main.dart';
import 'package:carded/login_screen.dart';

void main() {

  testWidgets('Pressing the Login Page button navigates to the Login Screen', (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());

    await tester.tap(find.text("Login Page"));
    await tester.pumpAndSettle();

    expect(find.text("Login Screen"), findsOneWidget);

  });

  testWidgets('Pressing the Sign Up Page button navigates to the Sign Up Screen', (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());

    await tester.tap(find.text("Sign Up Page"));
    await tester.pumpAndSettle();

    expect(find.text("Sign Up Screen"), findsOneWidget);
  });

  testWidgets('Pressing the Wallet Page button navigates to the Wallet Screen', (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());

    await tester.tap(find.text("Wallet Page"));
    await tester.pumpAndSettle();

    expect(find.text("Show Wallet"), findsOneWidget);
  });
}
