import 'package:ChatUI/models/posts.dart';
import 'package:flutter/material.dart';

class PostWidget extends StatelessWidget {
  final Post post;

  const PostWidget({Key key, this.post}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text(
        "${post.title}",
        style: TextStyle(fontSize: 40.0),
      ),
    );
  }
}
