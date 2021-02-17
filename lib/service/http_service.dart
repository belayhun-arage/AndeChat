import 'dart:developer';
import 'dart:typed_data';
import 'package:http/http.dart';
import 'package:ChatUI/libs.dart';

import 'dart:convert';
import 'dart:async';

// This HTTP CALL Handler class is to be called by all the 
// data_provider classes of each features 
class HttpCallHandler extends Service {
  Client client = new Client();

  // Header Data Will be listed here ...
  static HttpCallHandler _handler;
  static SessionHandler _sessHandler;
  static const String HOST = StaticDataStore.HOST;
  // static const String HOST = "http://10.0.3.2:8080/";

  static Future<SessionHandler> get sessionHandler async {
    if (_handler == null) {
      await HttpCallHandler.getInstance();
      return _sessHandler;
    }
    return _sessHandler; 
  }

  static Future<HttpCallHandler> getInstance() async {
    if (_sessHandler == null) {
      var pref = await SharedPrefHandler.getInstance();
      _sessHandler = await SessionHandler(pref);
    }
    if (_handler == null) {
      _handler = new HttpCallHandler();
      return _handler;
    }
    return _handler;
  }
  
  Future<Uint8List> getProfileImage(String imageurl) async {
    var response = await client.get("${HOST}$imageurl");
    if (response != null) {
      return response.bodyBytes;
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
      "${HOST}api/user/friend/messages/?friend_id=$id&last_message_number=0",
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
}
