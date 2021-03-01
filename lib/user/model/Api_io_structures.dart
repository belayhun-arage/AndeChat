/*This dart file contains classes to map the non  
web socket  api end points message resposes data structure  */
import 'dart:convert';

class RegistrationInput {
  final String username;
  final String password;
  final String email;
  final String confirmpassword;

  RegistrationInput(
      {this.username, this.password, this.confirmpassword, this.email});
}

class RegistrationRes {
  final bool success;
  final String message;
  final String username;
  final String email;

  RegistrationRes({this.email, this.username, this.message, this.success});

  static RegistrationRes fromJSON(Map theJson) {
    try {
      return RegistrationRes(
        email: theJson['email'],
        username: theJson['username'],
        message: theJson['message'],
        success: theJson['success'],
      );
    } catch (e, s) {
      print(e);
      return null;
    }
  }

  String toJSON() {
    return jsonEncode(this);
  }
}

class LoginRes {
  final bool success;
  final String message;

  LoginRes({this.success, this.message});

  factory LoginRes.fromJson(Map theJson) {
    try {
      return LoginRes(
        success: theJson["success"] as bool,
        message: theJson["message"],
      );
    } catch (e, a) {
      return null;
    }
  }
}
