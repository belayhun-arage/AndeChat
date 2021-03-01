import 'package:flutter/material.dart';
///This class handle the code that create other Admins
class AddAdminFragment extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
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
                          labelText: "UserName", hintText: "Enter Admin Name"),
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
                  'Add',
                  style: TextStyle(fontSize: 20.0),
                ),
                color: Colors.deepOrange,
                textColor: Colors.black,
                onPressed: () {},
              ),
            ),
          ],
        ),
      ),
    );
  }
}
