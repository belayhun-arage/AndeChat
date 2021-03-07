import 'package:ChatUI/admin/bloc/admin_state_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// AddAdminFragment This class handle the code that create other Admins
class AddAdminFragment extends StatefulWidget {
  @override
  AddAdminFragmentState createState() {
    return AddAdminFragmentState();
  }
}

class AddAdminFragmentState extends State<AddAdminFragment> {
  TextEditingController usernamec = TextEditingController();
  TextEditingController passc = TextEditingController();
  TextEditingController confirmc = TextEditingController();
  TextEditingController emailc = TextEditingController();

  bool loading = false;
  String message = "message";
  Color messageColor = Colors.green;
  @override
  Widget build(BuildContext context) {
    AdminState adminState = BlocProvider.of<AdminState>(context);
    return new Scaffold(
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 25),
        child: ListView(
          children: [
            Center(
              child: loading
                  ? CircularProgressIndicator(
                      backgroundColor: Theme.of(context).primaryColor,
                    )
                  : SizedBox(),
            ),
            Container(
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(40),
                border: Border.all(
                  color: messageColor,
                ),
              ),
              child: Center(
                child: Text(
                  message,
                  style: TextStyle(
                    color: messageColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 17,
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
                      controller: usernamec,
                      decoration: InputDecoration(
                          labelText: "Username", hintText: "Enter Admin Name"),
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
                      controller: emailc,
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
                      controller: passc,
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
                      controller: confirmc,
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
                  ' Register ',
                  style: TextStyle(fontSize: 20.0),
                ),
                color: Colors.deepOrange,
                textColor: Colors.black,
                onPressed: () {
                  setState(() {
                    loading = true;
                    message = "loading... ";
                  });
                  final admin = adminState.adminRegister(
                      usernamec.text, emailc.text, passc.text, confirmc.text);

                  setState(() {
                    if (admin != null) {
                      loading = false;
                      message = "admin Created succesfuly ";
                      messageColor = Color(0x0000FF00);
                    } else {
                      loading = true;
                      message = " Unable to Create An Admin ";
                      messageColor = Color(0x00FF0000);
                    }
                  });
                  print("${admin.toString()}");
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
