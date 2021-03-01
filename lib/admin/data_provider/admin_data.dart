import 'dart:developer';
import 'dart:typed_data';
import 'package:ChatUI/libs.dart';
import 'package:http/http.dart';
import 'dart:convert';
import 'dart:async';

/*
  Methods List 

*/
class AdminDataProvider extends Service {
  static Client client;
  static AdminDataProvider _handler;
  static SessionHandler _sessHandler;
  static HttpCallHandler httpCallHandler;
  static const String HOST = StaticDataStore.HOST;

  static Future<AdminDataProvider> getInstance() async {
    if (_handler == null) {
      _handler = new AdminDataProvider();
      if (httpCallHandler == null) {
        httpCallHandler = await HttpCallHandler.getInstance();
        _sessHandler = await HttpCallHandler.sessionHandler;
        client = httpCallHandler.client;
      }
      if (_sessHandler == null) {
        _sessHandler = await HttpCallHandler.sessionHandler;
      }
    }
    return _handler;
  }

  Future<RegistrationRes> Register(RegistrationInput input) async {
    Map<String, String> headers = await _sessHandler.getHeader();
    if (headers == null) {
      headers = {};
    }
    headers["Content-Type"] = "application/json";
    final response = await client.post(
      "${HOST}api/user/new/",
      body: jsonEncode({
        "username": input.username,
        "password": input.password,
        "confirmpassword": input.confirmpassword,
        "email": input.email,
      }),
      headers: headers,
    );
    if (response.statusCode == 200) {
      var body = jsonDecode(response.body) as Map<String, dynamic>;
      if (body == null) {
        return null;
      } else {
        _sessHandler.updateCookie(response);
        return RegistrationRes.fromJSON(body);
      }
    }
    return null;
  }

  Future<AdminLoginRes> AdminLogin(String email, String password) async {
    print("   -----  $email     -----    $password         ");
    var response = await client.post("${HOST}api/admin/login/",
        body: jsonEncode({"email": email, "password": password}),
        headers: {
          "Content-Type": "application/json",
        });

    print(response.body);
    if (response != null && response.statusCode == 200) {
      print(response.body);
      try {
        var body = jsonDecode(response.body) as Map<String, dynamic>;
        // Setting the Cookie header again
        _sessHandler.updateCookie(response);
        final result = AdminLoginRes.fromJson(body);
        return result;
      } catch (e, a) {
        return null;
      }
    }
    return null;
  }

  Future<Admin> getMyProfile() async {
    Map<String, String> headers = await _sessHandler.getHeader();
    if (headers == null) {
      headers = {};
    }
    var response = await client.get(
      "${HOST}api/user/myprofile/",
      headers: headers,
    );
    if (response == null) {
      return null;
    }
    if (response.statusCode == 200) {
      try {
        var body = jsonDecode(response.body) as Map<String, dynamic>;
        print(body);
        _sessHandler.updateCookie(response);
        if (!(body['success'] as bool)) {
          return null;
        }
        return Admin.fromJson(body["user"] as Map<String, dynamic>);
      } catch (e, a) {
        return null;
      }
    }
  }

  Future<Uint8List> getProfileImage(String imageurl) async {
    var response = await client.get("${HOST}$imageurl");
    if (response != null) {
      return response.bodyBytes;
    }
    return null;
  }

  Future<List<Alie>> searchUsers(String username) async {
    Map<String, String> headers = await _sessHandler.getHeader();
    if (headers == null) {
      headers = {};
    }
    var response = await client.get(
      "${HOST}api/user/search/?username=$username",
      headers: headers,
    );
    if (response != null && response.statusCode == 200) {
      try {
        var body = jsonDecode(response.body) as Map<String, dynamic>;
        _sessHandler.updateCookie(response);
        print(body);
        if (body['success'] as bool) {
          List<Map<String, dynamic>> vals = [];
          List<Map<String, dynamic>> newmapListUser = [];
          for (int a = 0; a < body['users'].length; a++) {
            newmapListUser.add(body['users'][a] as Map<String, dynamic>);
          }
          final users = Alie.AllUsers(newmapListUser);
          return users;
        } else {
          print(body['message']);
          return [];
        }
      } catch (e, a) {
        print(e.toString());
        return null;
      }
    }
    return null;
  }

  Future<bool> logout() {}

  Future<List<Idea>> getIdeasMoney() async {
    Map<String, String> headers = await _sessHandler.getHeader();
    if (headers == null) {
      headers = {};
    }
    var response = await client.get(
      "$HOST/api/ideas/",
      headers: headers,
    );
    if (response.statusCode == 200) {
      final ideas = jsonDecode(response.body) as Map<String, dynamic>;
      List<Idea> ideass = [];
      int a = 0;
      print(ideas);
      while (a < ideas['ideas'].length) {
        final ide = ideas['ideas'][a];
        final idea = Idea.fromJson(ide);
        if (idea != null) {
          ideass.add(idea);
        }
        a++;
      }
      print(ideass.length);
      return ideass;
    } else {
      print("i am just expecting");
      throw Exception("failed to load ideas");
    }
  }
}
