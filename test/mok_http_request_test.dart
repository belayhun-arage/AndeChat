// import 'package:http/http.dart' show Client;
// import 'dart:convert';
// import 'package:http/http.dart';
// import 'package:http/testing.dart';
// import 'dart:convert';
// class ApiProvider {
//   Client client = Client();
//   fetchPosts() async {
//     final response = await client.get("https://jsonplaceholder.typicode.com/posts/1");
//     IdeaModel itemModel = IdeaModel.fromJson(json.decode(response.body));
//     return itemModel;
//   }
// }
//
// class IdeaModel{
//   int _userId;
//   int _id;
//   String _title;
//   String _body;
//   IdeaModel.fromJson(Map<String,dynamic> parsedJson){
//     _userId = parsedJson['userId'];
//     _id = parsedJson['id'];
//     _title = parsedJson['title'];
//     _body = parsedJson['body'];
//   }
//
//   String get body => _body;
//
//   String get title => _title;
//
//   int get id => _id;
//
//   int get userId => _userId;
//
// }