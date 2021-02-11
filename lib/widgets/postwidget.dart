import 'package:ChatUI/models/posts.dart';
import 'package:flutter/material.dart';

import '../styleguide.dart';
import 'ideadescription.dart';

class PostWidget extends StatelessWidget {
  final Post post;

  const PostWidget({Key key, this.post}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 20),
      elevation: 4,
      color: Colors.white,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(24))),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Container(
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 24,
                    backgroundImage: AssetImage(post.profileimage),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Text(
                    post.username,
                    style: TextStyle(fontSize: 16.0),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 10.0,
            ),
            ClipRRect(
              borderRadius: BorderRadius.all(
                Radius.circular(30),
              ),
              child: Image.asset(
                post.imagePath,
                height: 150,
                fit: BoxFit.fitWidth,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8.0, left: 8.0),
              child: Row(
                children: <Widget>[
                  Expanded(
                    flex: 3,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          post.title,
                          style: eventTitleTextStyle,
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        // FittedBox(
                        Row(
                          children: <Widget>[
                            Icon(Icons.location_on),
                            SizedBox(
                              width: 5,
                            ),
                            Flexible(
                              child: IdeaDescriptionText(
                                text: post.description,

                                //style: eventLocationTextStyle,
                              ),
                            ),
                          ],
                        ),
                        // ),
                        SizedBox(
                          height: 20.0,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 80.0),
                          child: Row(
                            children: [
                              Icon(
                                Icons.thumb_up,
                                color: Colors.blue,
                              ),
                              Text("1k"),
                              SizedBox(
                                width: 50.0,
                              ),
                              Icon(
                                Icons.thumb_down,
                              ),
                              Text("219"),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  // Expanded(
                  //   flex: 1,
                  //   child: Text(
                  //     event.duration.toUpperCase(),
                  //     textAlign: TextAlign.right,
                  //     style: eventLocationTextStyle.copyWith(
                  //       fontWeight: FontWeight.w900,
                  //     ),
                  //  ),
                  // ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
