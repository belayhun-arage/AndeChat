import 'package:ChatUI/screens/auth_screen.dart';
import 'package:ChatUI/screens/chat_screen.dart';
import 'package:ChatUI/screens/home_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Chat UI',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.deepOrange,
        accentColor: Color(0XFFeeeeee),
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),

      initialRoute: HomeScreen.Route,
      // home: HomeScreen(),
      routes: {
        HomeScreen.Route: (context) {
          return HomeScreen();
        },
        ChatScreen.Route: (context) {
          return ChatScreen();
        },
        AuthScreen.Route: (context) {
          return AuthScreen();
        },
      },
      // home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}
