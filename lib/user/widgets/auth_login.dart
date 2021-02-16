import 'package:ChatUI/libs.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthLogin extends StatefulWidget {
  final Function function;
  AuthLogin({this.function});
  @override
  _AuthLoginState createState() => _AuthLoginState();
}

class _AuthLoginState extends State<AuthLogin> {
  String email = "";
  String password = "";
  bool loading = false;

  TextEditingController emailController;
  TextEditingController passwordController;
  HttpCallHandler httpHandler;
  SharedPrefHandler handler;
  bool warningMessage = false;
  String message = "";
  @override
  void initState() {
    SharedPrefHandler.getInstance().then((instance) {
      this.handler = instance;
    });
    HttpCallHandler.getInstance().then((value) {
      httpHandler = value;
    });
    emailController = new TextEditingController();
    passwordController = new TextEditingController();
    super.initState();
  }

  BuildContext gcontext;
  @override
  Widget build(BuildContext context) {
    // final prov = BlocProvider.of<UserCubit>(context);
    this.gcontext = context;
    if (emailController == null) {
      this.emailController = new TextEditingController();
    }
    if (passwordController == null) {
      this.passwordController = new TextEditingController();
    }
    return Container(
      height: MediaQuery.of(context).size.height,
      color: Theme.of(context).primaryColor,
      child: Column(
        children: [
          Center(
            child: Container(
              margin: EdgeInsets.all(20),
              child: Text(
                "Sign In",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 30,
                  fontStyle: FontStyle.italic,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          Expanded(
            child: ClipRRect(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(40),
                topRight: Radius.circular(40),
              ),
              child: Container(
                padding: EdgeInsets.all(20),
                color: Theme.of(context).accentColor,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Container(
                          padding: EdgeInsets.all(10.0),
                          child: this.loading
                              ? CircularProgressIndicator()
                              : Text(
                                  message,
                                  style: TextStyle(
                                    color: warningMessage
                                        ? Colors.red
                                        : Colors.green,
                                  ),
                                ),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(9),
                              border: Border.all(
                                color: message == ""
                                    ? Colors.white
                                    : (warningMessage
                                        ? Colors.red
                                        : Colors.green),
                                style: BorderStyle.solid,
                                width: 1.0,
                              )),
                        ),
                        TextField(
                          autocorrect: true,
                          autofocus: true,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            decoration: TextDecoration.none,
                          ),
                          cursorColor: Theme.of(context).primaryColor,
                          decoration: InputDecoration(
                            labelText: "Email",
                            hintText: "samuael@gmail.com",
                            hintStyle: TextStyle(
                              color: Color(0XFFaaaaaa),
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
                            hintText: "",
                            hintStyle: TextStyle(
                              color: Color(0XFFaaaaaa),
                            ),
                          ),
                          controller: passwordController,
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
                            onPressed: () async {
                              if (emailController.text == '' &&
                                  passwordController.text == "") {
                                setState(() {
                                  message = "Fill the Entries!";
                                  warningMessage = true;
                                });
                                return;
                              } else if (emailController.text == "") {
                                setState(() {
                                  message = "Fill the Email Entry First";
                                  warningMessage = true;
                                });
                                return;
                              } else if (passwordController.text == "") {
                                setState(() {
                                  message = "Fill the Password Entry First";
                                  warningMessage = true;
                                });
                                return;
                              }
                              email = emailController.text;
                              password = passwordController.text;
                              this.loading = true;
                              var loginres = await gcontext
                                  .read<UserCubit>()
                                  .loginUser(email, password);

                              if (loginres != null) {
                                if (loginres.success) {
                                  setState(() {
                                    this.loading = false;
                                    message = loginres.message;
                                    warningMessage = false;
                                  });

                                  Navigator.of(context).pushNamedAndRemoveUntil(
                                      HomeScreen.Route, (route) => false);
                                } else {
                                  setState(() {
                                    this.loading = false;
                                    message = loginres.message;
                                    warningMessage = true;
                                  });
                                }
                              } else {
                                setState(() {
                                  this.loading = false;
                                  message = "Error Happened .. ";
                                  warningMessage = true;
                                });
                                return;
                              }
                            },
                            icon: Icon(Icons.login),
                            label: Text("Login"),
                          ),
                        ),
                        FlatButton(
                          onPressed: () {
                            print("thi i s the login classs");
                            widget.function(1);
                          },
                          child: Text(
                            " Sign Up ... ",
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
    );
  }
}
