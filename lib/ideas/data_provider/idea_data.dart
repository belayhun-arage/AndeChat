import 'dart:convert';

import 'package:ChatUI/home/datas/datas.dart';
import 'package:ChatUI/home/handlers/handler.dart';
import 'package:ChatUI/ideas/models/models.dart';
import 'package:ChatUI/libs.dart';
import 'package:ChatUI/messaging/data_provider/data_provider.dart';
import 'package:ChatUI/service/service.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

//class IdeaDataProvider makes http connection with external api and provides row data to the repository
class IdeaDataProvider {
  static Client client;
  // Header Data Will be listed here ...
  static IdeaDataProvider _handler;
  static SessionHandler _sessHandler;
  static HttpCallHandler httpCallHandler;
  static const String HOST = StaticDataStore.HOST;

  static Future<IdeaDataProvider> getInstance() async {
    if (httpCallHandler == null) {
      httpCallHandler = await HttpCallHandler.getInstance();
      _sessHandler = await HttpCallHandler.sessionHandler;
      client = httpCallHandler.client;
    }
    if (_sessHandler == null) {
      _sessHandler = await HttpCallHandler.sessionHandler;
    }
    if (_handler == null) {
      _handler = new IdeaDataProvider();
    }
    return _handler;
  }

//Crude createIdea posts new idea to the database
  Future<Idea> createIdea(Idea idea) async {
    Map<String, String> headers = await _sessHandler.getHeader();
    if (headers == null) {
      headers = {};
    }
    headers["Content-Type"] = "application/json";
    print("${idea.title}, ${idea.description}");
    var map = new Map<String, dynamic>();
    map['title'] = idea.title;
    map['description'] = idea.description;
    map['image'] = idea.image;

    http.Response response = await http.put(
      "${HOST}api/idea/new/",
      body: jsonEncode(map),
      headers: headers,
    );

    if (response.statusCode == 200) {
      var body = jsonDecode(response.body) as Map<String, dynamic>;
      if (body["success"] as bool) {
        return Idea.fromJson(body["idea"]);
      }
      return null;
    } else {
      throw Exception('Failed to create idea.');
    }
  }

  // getOwner
  Future<Alie> getOwner(String id) async {
    Map<String, String> headers = await _sessHandler.getHeader();
    if (headers == null) {
      headers = {};
    }
    var response = await http.get(
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

  //Crude getIdeas fech all ideas posted by a particular user from the database
  Future<List<Idea>> getIdeas(String userid) async {
    Map<String, String> headers = await _sessHandler.getHeader();
    if (headers == null) {
      headers = {};
    }
    var response = await http.get(
      "$HOST/api/user/ideas/?userid=$userid",
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
          //idea.getOwner(this);
          ideass.add(idea);
        }
        a++;
      }
      print("  some thing ${ideass.length}");
      return ideass;
    } else {
      throw Exception("failed to load ideas");
    }
  }

  //Crude getIdeasMoney load all ideas from the api
  Future<List<Idea>> getIdeasMoney() async {
    Map<String, String> headers = await _sessHandler.getHeader();
    if (headers == null) {
      headers = {};
    }
    var response = await http.get(
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
          idea.getOwner(this);
          ideass.add(idea);
        }
        a++;
      }
      print(ideass.length);
      return ideass;
    } else {
      throw Exception("failed to load ideas");
    }
  }

  //Crude deleteIdea delete a particular idea in the database
  Future<bool> deleteIdea(String ideaid) async {
    Map<String, String> headers = await _sessHandler.getHeader();
    if (headers == null) {
      headers = {};
    }

    final http.Response response = await http.delete(
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

  //Crude updateIdea update the content of a particular idea in the database
  Future<bool> updateIdea(Idea idea) async {
    Map<String, String> headers = await _sessHandler.getHeader();
    if (headers == null) {
      headers = {};
    }
    headers['Content-Type'] = 'application/json';
    final http.Response response = await http.put(
      
      '${HOST}api/idea/',
      headers: headers , 
      body: idea.toJson(),
    );
    print("${response.body} ${response.statusCode}");

    if (response.statusCode == 200) {
      final jsonval = jsonDecode(response.body);
      print(jsonval);
      if (jsonval["success"] as bool) {
        return true;
      } else {
        return false;
      }
    } else {
      return false;
    }
  }
}
