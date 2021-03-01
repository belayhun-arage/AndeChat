import 'package:ChatUI/libs.dart';

class AdminLoginRes {
  final bool success;
  final String message;
  final Admin admin;

  /// AdminLoginRes is a class used to map a response of the server
  /// which contains relevant informations related to  the logging process.
  AdminLoginRes({this.success, this.message, this.admin});

  factory AdminLoginRes.fromJson(Map<String, dynamic> theJson) {
    try {
      return AdminLoginRes(
          success: theJson["success"] as bool,
          message: theJson["message"],
          admin: Admin.fromJson(theJson["admin"] as Map<String, dynamic>));
    } catch (e, a) {
      print("${e.toString()}, ${a.toString()}");
      return null;
    }
  }
}
