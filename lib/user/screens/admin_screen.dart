import 'package:ChatUI/libs.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AdminScreen extends StatefulWidget {
  //static const String Route = "/admin";
  @override
  _AdminScreenState createState() => _AdminScreenState();
}

class _AdminScreenState extends State<AdminScreen> {
  String appname = "AdminPage";

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

  @override
  Widget build(BuildContext context) {
    StaticDataStore.onlineFriends = BlocProvider.of<OnlineFriends>(context);
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
