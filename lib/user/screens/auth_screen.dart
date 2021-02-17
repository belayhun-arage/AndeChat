import 'package:ChatUI/libs.dart';
import 'package:flutter/material.dart';

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
        function :setAuthorization ,  
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
