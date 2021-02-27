import 'package:ChatUI/libs.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthRegistration extends StatefulWidget {
  final Function(int val) function;

  AuthRegistration({this.function});
  @override
  _AuthRegistrationState createState() => _AuthRegistrationState();
}

class _AuthRegistrationState extends State<AuthRegistration> {
  bool loading = false;
  @override
  void initState() {
    // TODO: implement initState

    usernameController = new TextEditingController();
    passwordController = new TextEditingController();
    confirmController = new TextEditingController();
    emailController = new TextEditingController();
    HttpCallHandler.getInstance().then((value) {
      httpHandler = value;
    });
    super.initState();
  }

  TextEditingController usernameController;
  TextEditingController passwordController;
  TextEditingController confirmController;
  TextEditingController emailController;
  bool warningMessage = false;
  HttpCallHandler httpHandler;
  String message = "";
  @override
  Widget build(BuildContext context) {
    final userprov = BlocProvider.of<UserState>(context);
    return GestureDetector(
      onTap: () => Focus.of(context).dispose(),
      child: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          color: Theme.of(context).primaryColor,
        ),
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.symmetric(
                vertical: 10,
              ),
              child: Text(
                " Register ",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 30,
                  fontStyle: FontStyle.italic,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            Expanded(
              child: ClipRRect(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(60),
                  topRight: Radius.circular(60),
                ),
                child: Card(
                  margin: EdgeInsets.all(0),
                  elevation: 5,
                  color: Colors.white,
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 40, vertical: 20),
                    // margin: EdgeInsets.all(10),
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      color: Theme.of(context).accentColor,
                    ),
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          loading
                              ? CircularProgressIndicator(
                                  backgroundColor:
                                      Theme.of(context).primaryColor,
                                )
                              : Text(
                                  "$message",
                                  style: TextStyle(
                                    color: warningMessage
                                        ? Colors.red
                                        : Colors.green,
                                    fontWeight: FontWeight.bold,
                                    fontStyle: FontStyle.italic,
                                  ),
                                ),
                          TextField(
                            autocorrect: true,
                            autofocus: true,
                            cursorColor: Theme.of(context).primaryColor,
                            decoration: InputDecoration(
                              labelText: "Username",
                              hintText: "samuael .. (required)",
                              hintStyle: TextStyle(
                                color: Theme.of(context).accentColor,
                              ),
                            ),
                            controller: usernameController,
                          ),
                          TextField(
                            autocorrect: true,
                            autofocus: true,
                            cursorColor: Theme.of(context).primaryColor,
                            decoration: InputDecoration(
                              labelText: "Email",
                              hintText: "samuael@gmail.com (required )",
                              hintStyle: TextStyle(
                                color: Theme.of(context).accentColor,
                              ),
                            ),
                            controller: emailController,
                          ),
                          TextField(
                            autocorrect: true,
                            autofocus: true,
                            cursorColor: Theme.of(context).primaryColor,
                            obscureText: true,
                            decoration: InputDecoration(
                              labelText: "Password",
                              hintText: "***********",
                              hintStyle: TextStyle(
                                color: Theme.of(context).accentColor,
                              ),
                            ),
                            controller: passwordController,
                          ),
                          TextField(
                            autocorrect: true,
                            autofocus: true,
                            cursorColor: Theme.of(context).primaryColor,
                            obscureText: true,
                            decoration: InputDecoration(
                              labelText: "Confirm Password",
                              hintText: "",
                              hintStyle: TextStyle(
                                color: Theme.of(context).accentColor,
                              ),
                            ),
                            controller: confirmController,
                          ),
                          Container(
                            margin: EdgeInsets.all(10),
                            child: FlatButton.icon(
                              textColor: Colors.white,
                              padding: EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 10),
                              minWidth: MediaQuery.of(context).size.width * 0.8,
                              splashColor: Color(0xFFffffff),
                              color: Theme.of(context).primaryColor,
                              onPressed: () {
                                if (usernameController.text == "" &&
                                    passwordController.text == '' &&
                                    emailController.text == "" &&
                                    confirmController.text == '') {
                                  this.setState(() {
                                    this.loading = false;
                                    this.message = "Please Fill Entries ";
                                    warningMessage = true;
                                  });
                                  return;
                                } else if (usernameController.text == "") {
                                  this.setState(() {
                                    this.message =
                                        "Please Fill the Username Entry";
                                    warningMessage = true;
                                  });
                                  return;
                                } else if (emailController.text == "") {
                                  this.setState(() {
                                    this.message =
                                        "Please Fill the Email Entry";
                                    warningMessage = true;
                                  });
                                  return;
                                } else if (passwordController.text == '') {
                                  this.setState(() {
                                    this.message =
                                        "Please Fill the Password Entry";
                                    warningMessage = true;
                                  });
                                  return;
                                } else if (confirmController.text == '') {
                                  this.setState(() {
                                    this.message =
                                        "Please Fill the Confirm Password Entry";
                                    warningMessage = true;
                                  });
                                  return;
                                }
                                if (passwordController.text !=
                                    confirmController.text) {
                                  this.setState(() {
                                    this.message = "Re Type the password ";
                                    passwordController.text = "";
                                    confirmController.text = "";
                                    warningMessage = true;
                                  });
                                  return;
                                }
                                RegistrationInput input = RegistrationInput(
                                  email: emailController.text,
                                  password: passwordController.text,
                                  confirmpassword: confirmController.text,
                                  username: usernameController.text,
                                );
                                this.loading = true;
                                //      totalContext
                                // .read<TabIndex>()
                                // .add(TabChangeEvent.groups);
                                userprov.register(input).then((value) {
                                  if (value == null) {
                                    setState(() {
                                      this.loading = false;
                                      message =
                                          "Registration Was Not Succesful Try again";
                                      warningMessage = true;
                                    });
                                    Navigator.of(context)
                                        .pushNamedAndRemoveUntil(
                                            HomeScreen.Route, (route) => false);
                                  } else if (!value.success) {
                                    setState(() {
                                      this.loading = false;
                                      this.message = value.message;
                                      warningMessage = true;
                                    });
                                    Navigator.of(context)
                                        .pushNamedAndRemoveUntil(
                                            HomeScreen.Route, (route) => false);
                                  } else {
                                    setState(() {
                                      this.loading = false;
                                      this.message = value.message;
                                      this.warningMessage = false;
                                    });
                                  }
                                });
                              },
                              icon: Icon(Icons.app_registration),
                              label: Text("Register"),
                            ),
                          ),
                          FlatButton(
                            onPressed: () {
                              widget.function(0);
                            },
                            child: Text(
                              " Sign In ... ",
                              style: TextStyle(
                                color: Theme.of(context).primaryColor,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
