import 'dart:developer';
import 'dart:typed_data';
import 'package:ChatUI/libs.dart';
import 'package:http/http.dart';
import 'dart:convert';
import 'dart:async';

class MessagingDataProvider extends Service {
  static Client client;
  // Header Data Will be listed here ...
  static MessagingDataProvider _handler;
  static SessionHandler _sessHandler;
  static HttpCallHandler httpCallHandler;
  static const String HOST = StaticDataStore.HOST;

  static Future<MessagingDataProvider> getInstance() async {
    if (httpCallHandler == null) {
      httpCallHandler = await HttpCallHandler.getInstance();
      _sessHandler = await HttpCallHandler.sessionHandler;
      client = httpCallHandler.client;
    }
    if (_sessHandler == null) {
      _sessHandler = await HttpCallHandler.sessionHandler;
    }
    if (_handler == null) {
      _handler = new MessagingDataProvider();
      return _handler;
    }
    return _handler;
  }

  ///  deleteMessage a method to delete from a list of messages
  Future<bool> deleteMessage(String friendID, int messageNumber) async {
    Map<String, String> headers = await _sessHandler.getHeader();
    if (headers == null) {
      headers = {};
    }
    headers["Context-Type"] = "application/json ";
    var response = await client.delete(
      "${HOST}api/message/?friend_id=$friendID&message_no=$messageNumber",
      headers: headers,
    );
    if (response != null && response.statusCode == 200) {
      try {
        var body = jsonDecode(response.body) as Map<String, dynamic>;
        _sessHandler.updateCookie(response);
        return body["success"] as bool;
      } catch (e, a) {
        return false;
      }
    }
    return false;
  }

  Future<Uint8List> getImage(String imageurl) async {
    var response = await client.get("${HOST}$imageurl");
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
      "${HOST}api/user/friends/",
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
          return messages;
        } else {
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
