import 'dart:convert';

import 'package:ChatUI/libs.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

//entity idea
class Idea extends Equatable {
  final String id, title, description, image, ownerid;
  //final FileImage image;
  Alie owner;

  void getOwner(dynamic repo) async {
    if( repo is IdeaDataProvider || repo is AdminIdeaProvider ){
      this.owner = await repo.getOwner(this.ownerid);
    }
  }

  Idea({this.id, this.title, this.description, this.image, this.ownerid});
  @override
  List<Object> get props => [id, title, description];

  // @override
  // List<Object> get ideas => [title, description];

  //Idea.fromJson return the idea entity from encoded json form of an idea
  factory Idea.fromJson(Map<String, dynamic> json) {
    if (json == null) {
      return null;
    }
    return Idea(
      id: json['id'],
      title: json["title"],
      description: json['description'],
      image: json['image'],
      ownerid: json["owner_id"] as String,
    );
  }

  static List<Idea> AllIdeas(List<Map<String, dynamic>> allUsersJson) {
    List<Idea> ideas = [];
    for (var usr in allUsersJson) {
      print(usr);
      Idea idea = Idea.fromJson(usr  as Map<String  , dynamic > );
      if (idea == null) {
        print("New User Is Null ");
      }else {
        ideas.add(idea);
      }
    }
    return ideas;
  }

  String toJson() {
    return jsonEncode({
      "id": this.id,
      "title": this.title,
      "description": this.description,
    });
  }
  
}
