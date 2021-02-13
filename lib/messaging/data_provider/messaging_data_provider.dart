import 'dart:developer';
import 'dart:typed_data';
import 'package:ChatUI/libs.dart';
import 'package:http/http.dart';
import 'dart:convert';
import 'dart:async';

class MessagingDataProvider extends Service {
  Client client = new Client();

  // Header Data Will be listed here ...

  static MessagingDataProvider _handler;
  static SessionHandler _sessHandler;

  static const String host =   StaticDataStore.HOST;

  static Future<MessagingDataProvider> getInstance() async {
    if (_sessHandler == null) {
      var pref = await SharedPrefHandler.getInstance();
      _sessHandler = await SessionHandler(pref);
    }
    if (_handler == null) {
      _handler = new MessagingDataProvider();
      return _handler;
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
      "${host}api/user/new/",
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

  Future<LoginRes> Login(String email, String password) async {
    var response = await client.post("${host}api/user/login/",
        body: jsonEncode({"email": email, "password": password}),
        headers: {
          "Content-Type": "application/json",
        });
    if (response != null && response.statusCode == 200) {
      try {
        var body = jsonDecode(response.body) as Map<String, dynamic>;
        _sessHandler.updateCookie(response);
        return LoginRes.fromJson(body);
      } catch (e, a) {
        print(e.toString());
        return null;
      }
    }
    return null;
  }

  Future<Alie> getMyProfile() async {
    Map<String, String> headers = await _sessHandler.getHeader();
    if (headers == null) {
      headers = {};
    }
    var response = await client.get(
      "${host}api/user/myprofile/",
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
        return Alie.fromJson(body["user"] as Map<String, dynamic>);
      } catch (e, a) {
        return null;
      }
    }
  }

  Future<Uint8List> getProfileImage(String imageurl) async {
    var response = await client.get("${host}$imageurl");
    if (response != null) {
      return response.bodyBytes;
    }
    return null;
  }

  Future<Map<String, dynamic>> getMyFriends() async {
    Map<String, String> headers = await _sessHandler.getHeader();
    if (headers == null) {
      headers = {};
    }
    var response = await client.get(
      "${host}api/user/friends/",
      headers: headers,
    );
    if (response != null && response.statusCode == 200) {
      try {
        var body = jsonDecode(response.body) as Map<String, dynamic>;
        _sessHandler.updateCookie(response);
        return body;
      } catch (e, a) {
        return null;
      }
    }
    return null;
  }

  /// getOutChats returning the messages between the user and the alie
  /// whose id is used in the argument
  /// returning future of List of messages  if success
  /// else it returns null
  Future<List<EEMessage>> getOurChats(String id) async {
    Map<String, String> headers = await _sessHandler.getHeader();
    if (headers == null) {
      headers = {};
    }
    var response = await client.get(
      "${host}api/user/friend/messages/?friend_id=$id&last_message_number=0",
      headers: headers,
    );
    if (response != null && response.statusCode == 200) {
      try {
        var body = jsonDecode(response.body) as Map<String, dynamic>;
        _sessHandler.updateCookie(response);
        print("\n\n\n\n$body \n\n");
        if (body['success'] as bool) {
          List<Map<String, dynamic>> vals = [];
          for (var val in body['messages']) {
            try {
              var newVal = val as Map<String, dynamic>;
              vals.add(newVal);
            } catch (e, a) {
              print("Error Reading the List of messages ... ");
            }
          }
          final messages = EEMessage.allMessagesFromJson(vals);
          print("The Length of Mssages Found For ID $id is ${messages.length}");
          return messages;
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

  Future<List<Alie>> searchUsers(String username) async {
    Map<String, String> headers = await _sessHandler.getHeader();
    if (headers == null) {
      headers = {};
    }
    var response = await client.get(
      "${host}api/user/search/?username=$username",
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
}
