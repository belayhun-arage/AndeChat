import 'package:flutter/material.dart';

class ProfileScreen extends StatefulWidget {
  ProfileScreen({Key key}) : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
       child: Column(
         children : [
           Container(
             child : Image.asset("assets/image/greg.jpeg") , 
           ) , 
           Text("This is username "),
           Text("This is samuaeladenw@gmail.com"),
           Text("This is username "),
           
         ]
       ),
    );
  }
}