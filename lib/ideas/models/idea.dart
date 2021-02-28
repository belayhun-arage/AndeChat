import 'package:ChatUI/libs.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

class Idea extends Equatable {
  final String id, title, description, image;
  //final FileImage image;
  Alie owner;

  // void getOwner(IdeaDataProvider repo) async {
  //   this.owner = await repo.getOwner(this.id);
  // }

  Idea({this.id, this.title, this.description, this.image});
  @override
  List<Object> get props => [id, title, description];

  // @override
  // List<Object> get ideas => [title, description];

  factory Idea.fromJson(Map<String, dynamic> json) {
    if (json == null) {
      return null;
    }
    return Idea(
        id: json['id'],
        title: json["title"],
        description: json['description'],
        image: json['image']);
  }
  @override
  String toString() =>
      'idea {id:$id, title: $title , description: $description}';
}
