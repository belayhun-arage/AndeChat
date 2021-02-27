import 'dart:convert';

import 'package:ChatUI/home/datas/datas.dart';
import 'package:ChatUI/ideas/models/models.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

class IdeaDataProvider {
  final host = 'http://192.168.43.202:3000';
  var url = "http://192.168.43.202:3000/idea/ideas";
  Client client = new Client();

  static const String HOST = StaticDataStore.HOST;

  Future<Idea> createIdea(Idea idea) async {
    print("i am here");
    final response = await http.post(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        'id': idea.id,
        'title': idea.title,
        'description': idea.description,
      }),
    );
    print("this is response body" + response.body);
    if (response.statusCode == 200) {
      var body = jsonDecode(response.body) as Map<String, dynamic>;
      //   if (body["success"] as bool) {
      print("mariyamye");
      return Idea.fromJson(jsonDecode(response.body));
      //return Idea.fromJson(body["idea"]);
    } else {
      print("it worked");
      throw Exception('Failed to create idea.');
    }
  }

  Future<List<Idea>> getIdeas() async {
    // print("hhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhh$headers\n");
    var response = await http.get(
      "$HOST/api/ideas/",
    );
    print("The Response In The Idea Page : ${response.body}");
    // if (response == null) {
    //   print("hello");
    //   return null;
    // }
    if (response.statusCode == 200) {
      // var body = jsonDecode(response.body) as Map<String, dynamic>;
      //if (body["success"] as bool) {
      final ideas = jsonDecode(response.body) as List;
      print("i am just asking");
      // print(ideas.map((idea) => Idea.fromJson(idea)));

      return ideas.map((idea) => Idea.fromJson(idea)).toList();
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
