// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:ChatUI/admin/widgets/add_admin_fragment.dart';
import 'package:ChatUI/user/widgets/auth_login.dart';
import 'package:ChatUI/user/widgets/auth_registration.dart';
//import 'package:ChatUI/admin/widgets/admin_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:ChatUI/main.dart';

void main() {
  testWidgets('testing User login Email', (WidgetTester tester) async {
    //find Widgets
    final addEmail = find.byKey(ValueKey("addEmail"));
// final addPassword = find.byKey(ValueKey("addPassword"));
    final addLogin = find.byKey(ValueKey('addLogin'));

    //Execute Widgets
    await tester.pumpWidget(MaterialApp(home: Scaffold(body: AuthLogin())));
    await tester.enterText(addEmail, "Adding User Email");
    await tester.tap(addLogin);
    await tester.pump();

    expect(find.text("Adding User Email"), findsOneWidget);
  });

  testWidgets('testing User login Password', (WidgetTester tester) async {
    //find Widgets
    // final addEmail = find.byKey(ValueKey("addEmail"));
    final addPassword = find.byKey(ValueKey("addPassword"));
    final addLogin = find.byKey(ValueKey('addLogin'));

    //Execute Widgets
    await tester.pumpWidget(MaterialApp(home: Scaffold(body: AuthLogin())));
    await tester.enterText(addPassword, "Adding User Password");
    await tester.tap(addLogin);
    await tester.pump();

    expect(find.text("Adding User Password"), findsOneWidget);
  });

  testWidgets('testing User registration Password',
      (WidgetTester tester) async {
    //find Widgets
    // final addEmail = find.byKey(ValueKey("addEmail"));
    final addPassword = find.byKey(ValueKey("addPassword"));
    final addLogin = find.byKey(ValueKey('addLogin'));

    //Execute Widgets
    await tester.pumpWidget(MaterialApp(home: Scaffold(body: AuthLogin())));
    await tester.enterText(addPassword, "Adding User Password");
    await tester.tap(addLogin);
    await tester.pump();

    expect(find.text("Adding User Password"),
        findsOneWidget); //Says Nothing Widget
  });

  testWidgets('testing User Registration Password',
      (WidgetTester tester) async {
    //find Widgets
    // final addEmail = find.byKey(ValueKey("addEmail"));
    final addUserRegName = find.byKey(ValueKey("addUserRegName"));
//    final addUserRegEmail = find.byKey(ValueKey("addUserRegEmail"));
    final addSignIn = find.byKey(ValueKey('eaddSignIn'));

//    final addUserRegister = find.byKey(ValueKey('addUserRegister'));

    //Execute Widgets
    await tester.pumpWidget(MaterialApp(
        home: Scaffold(body: Container(child: AuthRegistration()))));
    await tester.enterText(addUserRegName, "Adding User Username");
    await tester.tap(addSignIn);
    await tester.pump();

    expect(find.text("Adding User Username"), findsOneWidget);
  });
}

/*
testWidgets('testing User login page', (WidgetTester tester) async {
    //find Widgets
    final addEmail = find.byKey(ValueKey("addEmail"));
// final addPassword = find.byKey(ValueKey("addPassword"));
    final addLogin = find.byKey(ValueKey('addLogin'));

    //Execute Widgets
    await tester.pumpWidget(MaterialApp(home: Scaffold(body: AuthLogin())));
    await tester.enterText(addEmail, "Adding User Email");
    await tester.tap(addLogin);
    await tester.pump();

    expect(find.text("Adding User Email"), findsOneWidget);
  });


*/
