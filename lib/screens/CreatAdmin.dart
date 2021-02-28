import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Part of Enawga',
      theme: ThemeData(
        primarySwatch: Colors.orange,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Create Admin"),
          centerTitle: true,
        ),
        body: Container(
            padding: EdgeInsets.symmetric(vertical: 25),
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.all(0),
                  height: 80,
                  child: Card(
                    child: Expanded(
                      child: Container(
                        padding: EdgeInsets.all(5),
                        child: TextField(
                          decoration: InputDecoration(
                              labelText: "UserName",
                              hintText: "Enter Admin Name"),
                        ),
                      ),
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(0),
                  height: 80,
                  child: Card(
                    child: Expanded(
                      child: Container(
                        padding: EdgeInsets.all(5),
                        child: TextField(
                          decoration: InputDecoration(
                              labelText: "Email", hintText: "Enter the Email"),
                        ),
                      ),
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(0),
                  height: 80,
                  child: Card(
                    child: Expanded(
                      child: Container(
                        padding: EdgeInsets.all(5),
                        child: TextField(
                          decoration: InputDecoration(
                              labelText: "Password",
                              hintText: "Enter the password"),
                        ),
                      ),
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(0),
                  height: 80,
                  child: Card(
                    child: Expanded(
                      child: Container(
                        padding: EdgeInsets.all(5),
                        child: TextField(
                          decoration: InputDecoration(
                              labelText: "Confirm Password",
                              hintText: "confirm the password"),
                        ),
                      ),
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.all(25),
                  child: FlatButton(
                    child: Text(
                      'Create',
                      style: TextStyle(fontSize: 20.0),
                    ),
                    color: Colors.orange,
                    textColor: Colors.black,
                    onPressed: () {},
                  ),
                ),
              ],
            )));
  }
}
