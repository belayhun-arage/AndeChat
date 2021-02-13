import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.orange,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Theme"),
        centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Container(
              height: 130.0,
              child:
                  ListView(scrollDirection: Axis.horizontal, children: <Widget>[
                Container(
                  width: 130.0,
                  child: Card(
                    child: Image.asset("assets/black.jpg"),
                  ),
                ),
                Container(
                  width: 130.0,
                  child: Card(
                    child: Image.asset("assets/black.jpg"),
                  ),
                ),
                Container(
                  width: 130.0,
                  child: Card(
                    child: Image.asset("assets/black.jpg"),
                  ),
                ),
                Container(
                  width: 130.0,
                  child: Card(
                    child: Image.asset("assets/black.jpg"),
                  ),
                ),
                Container(
                  width: 130.0,
                  child: Card(
                    child: Image.asset("assets/black.jpg"),
                  ),
                ),
                Container(
                  width: 130.0,
                  child: Card(
                    child: Image.asset("assets/black.jpg"),
                  ),
                ),
              ])),
          Container(
              padding: EdgeInsets.symmetric(horizontal: 30.0),
              child: Column(children: [
                Row(
                  children: [
                    Text(
                      "Text Color",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 80),
                      child: IconButton(
                        icon: Icon(Icons.check_box_outline_blank),
                        onPressed: () {},
                      ),
                    ),
                  ],
                ),
                Row(children: [
                  Text(
                    "BackGround Color",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Container(
                      padding: EdgeInsets.symmetric(horizontal: 40),
                      child: IconButton(
                        icon: Icon(Icons.check_box_outline_blank),
                        onPressed: () {},
                      )),
                ])
              ]))
        ],
      ),
    );
  }
}
