import 'package:ChatUI/models/message_model.dart';
import 'package:ChatUI/screens/chat_screen.dart';
import 'package:flutter/material.dart';

import 'package:flutter/material.dart';

class FavouriteContact extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 20.0,
          ),
          child: Row(
            // crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  "Favourite Contacts ",
                  style: TextStyle(
                    color: Colors.blueGrey,
                    letterSpacing: 1.0,
                    fontWeight: FontWeight.bold,
                    fontSize: 10.0,
                  ),
                ),
              ),
              IconButton(
                icon: Icon(Icons.more_horiz),
                iconSize: 30.0,
                color: Colors.blueGrey,
              ),
            ],
          ),
        ),
        Container(
          height: 122.0,
          color: Theme.of(context).accentColor,
          child: ListView.builder(
            padding: EdgeInsets.only(
              left: 10.0,
            ),
            scrollDirection: Axis.horizontal,
            itemCount: favorites.length,
            itemBuilder: (context, index) {
              return GestureDetector(
                  onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) => ChatScreen(
                                  user: favorites[index],
                                )),
                      ),
                  child: Padding(
                    padding: EdgeInsets.only(right: 8.0),
                    child: Column(
                      children: [
                        CircleAvatar(
                          backgroundImage:
                              AssetImage(favorites[index].imageUrl),
                          radius: 35.0,
                        ),
                        SizedBox(
                          height: 6.0,
                        ),
                        Text(
                          favorites[index].username,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.blueGrey,
                            fontSize: 12.0,
                          ),
                        ),
                      ],
                    ),
                  ));
            },
          ),
        )
      ],
    );
  }
}
