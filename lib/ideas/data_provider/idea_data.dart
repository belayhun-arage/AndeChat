import 'dart:convert';

import 'package:ChatUI/home/datas/datas.dart';
import 'package:ChatUI/home/handlers/handler.dart';
import 'package:ChatUI/ideas/models/models.dart';
import 'package:ChatUI/messaging/data_provider/data_provider.dart';
import 'package:ChatUI/service/service.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

class IdeaDataProvider {
  final host = 'http://192.168.43.202:3000';
  var url = "http://192.168.43.202:3000/idea/ideas";
  // Client client = new Client();

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

  Future<Idea> createIdea(Idea idea) async {
    print("Before heder ....");
    Map<String, String> headers = await _sessHandler.getHeader();
    print("_______ After Header ________ ");
    print("this is session handler" + "$_sessHandler");
    print("The Real header$headers");
    if (headers == null) {
      headers = {};
    }
    headers["Content-Type"] = "application/json";
    print("${idea.title}, ${idea.description}");
    final response = await client.post(
      "${HOST}api/idea/new/",
      body: jsonEncode(<String, dynamic>{
        'title': idea.title,
        'description': idea.description,
      }),
      headers: headers,
    );
    print("this is response body" + response.body);
    if (response.statusCode == 200) {
      var body = jsonDecode(response.body) as Map<String, dynamic>;
      if (body["success"] as bool) {
        print("mariyamye");
        return Idea.fromJson(body["idea"]);
      }
      return null;
    } else {
      print("it worked");
      throw Exception('Failed to create idea.');
    }

    // print("i am here");
    // final response = await http.post(
    //   url,
    //   headers: <String, String>{
    //     'Content-Type': 'application/json; charset=UTF-8',
    //   },
    //   body: jsonEncode(<String, dynamic>{
    //     'id': idea.id,
    //     'title': idea.title,
    //     'description': idea.description,
    //   }),
    // );
    // print("this is response body" + response.body);
    // if (response.statusCode == 200) {
    //   var body = jsonDecode(response.body) as Map<String, dynamic>;
    //   //   if (body["success"] as bool) {
    //   print("mariyamye");
    //   return Idea.fromJson(jsonDecode(response.body));
    //   //return Idea.fromJson(body["idea"]);
    // } else {
    //   print("it worked");
    //   throw Exception('Failed to create idea.');
    // }
  }

  Future<List<Idea>> getIdeas() async {
    Map<String, String> headers = await _sessHandler.getHeader();
    if (headers == null) {
      headers = {};
    }
    var response = await http.get(
      "$HOST/api/ideas/",
      headers: headers,
    );
    print("The Response In The Idea Page : ${response.body}");
    // if (response == null) {
    //   print("hello");
    //   return null;
    // }
    if (response.statusCode == 200) {
      // var body = jsonDecode(response.body) as Map<String, dynamic>;
      //if (body["success"] as bool) {
      final ideas = jsonDecode(response.body) as Map<String, dynamic>;
      // return ideas as List<Idea>;
      List<Idea> ideass = [];
      int a = 0;
      print(ideas);
      while (a < ideas['ideas'].length) {
        final ide = ideas['ideas'][a];
        print("samiiii  $ide");
        final idea = Idea.fromJson(ide);

        print("mekkdiii $idea ");
        if (idea != null) {
          ideass.add(idea);
        }
        a++;
      }
      print(ideass.length);
      return ideass;
      // returnList ideas.map((idea) => Idea.fromJson(idea)).toList();
      // }
      //  return null;

      // var body = jsonDecode(response.body) as Map<String, dynamic>;
      // print(body);
      // _sessHandler.updateCookie(response);
      // if (!(body['success'] as bool)) {
      //   return null;
      // }
      // return Alie.fromJson(body["user"] as Map<String, dynamic>);
    } else {
      print("i am just expecting");
      throw Exception("failed to load ideas");
    }
  }

  Future<void> deleteIdea(String _id) async {
    print("this is deleting");
    final http.Response response = await http.delete(
      '$host/idea/ideas/$_id',
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );
    print("${response.body} ${response.statusCode}");
    if (response.statusCode != 200) {
      throw Exception('Failed to delete course.');
    }
  }

  Future<void> updateIdea(Idea idea) async {
    final http.Response response = await http.put(
      '$host/idea/ideas/${idea.id}',
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        'id': idea.id,
        'title': idea.title,
        'description': idea.description,
      }),
    );
    print("${response.body} ${response.statusCode}");

    if (response.statusCode != 200) {
      throw Exception('Failed to update idea.');
    }
  }
}
