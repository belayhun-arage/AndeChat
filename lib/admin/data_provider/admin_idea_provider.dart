import 'dart:developer';
import 'dart:typed_data';
import 'package:ChatUI/libs.dart';
import 'package:http/http.dart';
import 'dart:convert';
import 'dart:async';

/*
  Methods List 

*/
class AdminIdeaProvider extends Service {
  static Client client;
  static AdminIdeaProvider _handler;
  static SessionHandler _sessHandler;
  static HttpCallHandler httpCallHandler;
  static const String HOST = StaticDataStore.HOST;

  static Future<AdminIdeaProvider> getInstance() async {
    if (_handler == null) {
      _handler = new AdminIdeaProvider();
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

  Future<bool> deleteIdeaByID(String ideaid) async {
    Map<String, String> headers = await _sessHandler.getHeader();
    if (headers == null) {
      headers = {};
    }
    headers["Content-Type"] = "application/json";
    final response = await client.delete(
      "${HOST}api/user/?user_id=$ideaid",
      headers: headers,
    );
    print(response.body);
    if (response.statusCode == 200) {
      var body = jsonDecode(response.body) as Map<String, dynamic>;
      if (body == null) {
        return false;
      } else {
        _sessHandler.updateCookie(response);
        print(body);
        if (body["success"] as bool) {
          print(" Resulting Succesful Deletiong .... ");
          return true;
        }
        return false;
      }
    }
    return false;
  }

  

  
  Future<List<Idea>> searchIdeas(String title ) async {
    Map<String, String> headers = await _sessHandler.getHeader();
    if (headers == null) {
      headers = {};
    }
    var response = await client.get(
      "${HOST}api/idea/search/?title=$title",
      headers: headers,
    );
    if (response != null && response.statusCode == 200) {
      try {
        var body = jsonDecode(response.body) as Map<String, dynamic>;
        _sessHandler.updateCookie(response);
        print(body);
        if (body['success'] as bool) {
          // List<Map<String, dynamic>> vals = [];
          List<Map<String, dynamic>> newmapListUser = [];
          for (int a = 0; a < body['ideas'].length; a++) {
            newmapListUser.add(body['ideas'][a] as Map<String, dynamic>);
          }
          final ideas  = Idea.AllIdeas(newmapListUser);
          return ideas;
        } else {
          print(body['message']);
          return [];
        }
      } catch (e, a) {
        print(e.toString());
        return [];
      }
    }
    return [];
  }

  Future<List<Idea>> loadSampleIdeas() async {
     Map<String, String> headers = await _sessHandler.getHeader();
    if (headers == null) {
      headers = {};
    }
    var response = await client.get(
      "$HOST/api/ideas/?offset=0&limit=10",
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
          idea.getOwner(this);
          ideass.add(idea);
        }
        a++;
      }
      print(ideass.length);
      return ideass;
    } else {
      return null ;
    }
  }


  Future<Alie> getOwner(String id) async {
    Map<String, String> headers = await _sessHandler.getHeader();
    if (headers == null) {
      headers = {};
    }
    var response = await client.get(
      "$HOST/api/user/?userid=$id",
      headers: headers,
    );
    print(" Response : ${response.body}");
    if (response.statusCode == 200) {
      final zjson = jsonDecode(response.body) as Map<String, dynamic>;
      if (zjson["success"] as bool) {
        return Alie.fromJson(zjson["user"] as Map<String, dynamic>);
      } else {
        return Alie(username: "UNKNOWN", email: "UNKNOWN", id: "");
      }
    } else {
      return null;
    }
  }

  Future<bool >  deleteIdea(String ideaid ) async {
    Map<String, String> headers = await _sessHandler.getHeader();
    if (headers == null) {
      headers = {};
    }
    final response = await client.delete(
      '${HOST}api/idea/?idea_id=$ideaid',
      headers: headers,
    );
    if (response.statusCode == 200) {
      final jdon = jsonDecode(response.body);
      print(jdon);
      if (jdon["success"] as bool) {
        return true;
      }
      return false;
    } else {
      return false;
    }
  }

}
