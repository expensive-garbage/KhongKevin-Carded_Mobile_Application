
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:carded/main.dart';
import 'package:carded/login_screen.dart';

void main() {

  testWidgets('Pressing the Show Wallet Button shows wallets', (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());
    await tester.tap(find.text("wallet display"));
    await tester.pumpAndSettle();

    await tester.tap(find.text("Show Wallet"));
    await tester.pumpAndSettle();

    expect(find.text("Hide Wallet"), findsOneWidget);
  });

  testWidgets('Pressing the Hide Wallet Button goes back to the previous page', (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());
    await tester.tap(find.text("wallet display"));
    await tester.pumpAndSettle();

    await tester.tap(find.text("Show Wallet"));
    await tester.pumpAndSettle();

    await tester.tap(find.text("Hide Wallet"));
    await tester.pumpAndSettle();

    expect(find.text("Show Wallet"), findsOneWidget);
  });

  testWidgets('Pressing the Scan QR Code Button goes to the Scan QR Code Page', (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());
    await tester.tap(find.text("wallet display"));
    await tester.pumpAndSettle();

    await tester.tap(find.text("Scan QR Code"));
    await tester.pumpAndSettle();

    expect(find.text("Open Scanner"), findsOneWidget);
  });

  // // TODO figure this out
  // testWidgets('Pressing the Display Your QR Code Button goes to the correct page', (WidgetTester tester) async {
  //   await tester.pumpWidget(const MyApp());
  //   await tester.tap(find.text("wallet display"));
  //   await tester.pumpAndSettle();
  //
  //   await tester.tap(find.text("Display Your QR Code"));
  //   await tester.pumpAndSettle();
  //
  //   expect(find.text("QR Code"), findsNothing);
  // });

}