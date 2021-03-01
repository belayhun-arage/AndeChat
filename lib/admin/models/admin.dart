import 'dart:convert';

class Admin {
  String id;
  String username;
  String email;
  String password;
  String createdBy;

  Admin({this.id, this.username, this.email, this.password, this.createdBy});

  factory Admin.fromJson(Map<String, dynamic> theJson) {
    try {
      return Admin(
          id: theJson["id"]as String ,
          username: theJson["username"] as String ,
          password: theJson["password"]as String ,
          email: theJson["email"]as String ,
          createdBy: theJson["created_by"]as String ) ;
    } catch (e, a) {
      print(e.toString());
      return null;
    }
  }
  String toJson() {
    return jsonEncode({
      "id": this.id,
      "username": this.username,
      "password": this.password,
      "email": this.email,
      "created_by": this.createdBy,
    });
  }
}
