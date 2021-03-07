import 'dart:io';

import 'package:ChatUI/libs.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthScreen extends StatefulWidget {
  static const String Route = "/auth";
  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  String appname = "Authentication";

  int sceen = 0;

  List<Widget> authentications;
  @override
  void initState() {
    setState(() {
      authentications = [
        AuthLogin(
          function: setAuthorization,
        ),
        AuthRegistration(
          function: setAuthorization,
        ),
      ];
    });
    super.initState();
  }

  setAuthorization(int val) {
    if (val < 2 && val > -1) {
      setState(() {
        sceen = val;
      });
    }
  }

  bool loggedIn = false;
  @override
  Widget build(BuildContext context) {
    StaticDataStore.userState = BlocProvider.of<UserState>(context);
    // StaticDataStore.userState.getLoggedInUser().then((user) {
    //   if (user != null) {

    //     Navigator.of(context)
    //         .pushNamedAndRemoveUntil(HomeScreen.Route, (route) => false);
    //   }
    // });
    
    // StaticDataStore
    return Scaffold(
      appBar: AppBar(
        actions: [],
        elevation: 0,
        centerTitle: true,
      ),
      body: authentications[sceen],
      // body: AuthRegistration(),
    );
  }
}
