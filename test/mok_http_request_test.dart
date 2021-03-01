import 'package:http/http.dart' show Client;
import 'dart:convert';
import 'package:http/http.dart';
import 'package:http/testing.dart';
import 'dart:convert';
class ApiProvider {
  Client client = Client();
  fetchPosts() async {
    final response = await client.get("https://idea");
    IdeaModel itemModel = IdeaModel.fromJson(json.decode(response.body));
    return itemModel;
  }
}

class IdeaModel{
  int ideaId;
  int id;
  String title;
  String description;
  IdeaModel.fromJson(Map<String,dynamic> parsedJson){
    ideaId = parsedJson['ideaId'];
    id = parsedJson['id'];
    title = parsedJson['title'];
    description = parsedJson['description'];
  }

  // String get body => _body;

  // String get title => title;

  // int get id => id;

  int get userId => ideaId;

}