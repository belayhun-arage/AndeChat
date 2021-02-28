import 'dart:io';
import 'package:ChatUI/libs.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// ActiveChat active friends widget in a list of users which represents
/// your friends which are online
class ActiveChat extends StatelessWidget {
  final String filesPath;
  ActiveChat({Key key, this.filesPath}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).accentColor,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
          child: BlocBuilder<FriendsState, List<Alie>>(
            builder: (context, alies) {
              return ListView.builder(
                itemCount: alies != null ? alies.length : 0,
                itemBuilder: (context, index) {
                  final alie = alies[index];
                  return GestureDetector(
                    onTap: () => Navigator.pushNamed(context, ChatScreen.Route,
                        arguments: {
                          'user': alie,
                        }),
                    child: Container(
                      margin: EdgeInsets.only(
                        bottom: 3,
                        right: 10,
                      ),
                      decoration: BoxDecoration(
                        color: alie.unreadMessages > 0
                            ? Color(0XFFffeeee)
                            : Colors.white,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20.0),
                          topRight: Radius.circular(20.0),
                          bottomRight: Radius.circular(20.0),
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              SizedBox(
                                height: 80,
                                width: 80,
                                child: Stack(
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(80),
                                      child: alie.imageUrl == ""
                                          ? Image.asset(alie.imageUrl == ""
                                              ? "assets/images/greg.jpg"
                                              : alie.imageUrl)
                                          : Image.file(
                                              File(
                                                  '$filesPath${(alie.imageUrl.split('/')[(alie.imageUrl.split('/').length - 1)])}'),
                                              height: 150,
                                              width: 180,
                                            ),
                                    ),
                                    Container(
                                      margin: EdgeInsets.only(
                                        top: 60,
                                        left: 60,
                                      ),
                                      child: Icon(
                                        Icons.circle,
                                        color: Colors.green,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                width: 10.0,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    alie.username,
                                    style: TextStyle(
                                      color: Colors.grey,
                                      fontSize: 15.0,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 5.0,
                                  ),
                                  Container(
                                    width: MediaQuery.of(context).size.width *
                                        0.55,
                                    child: Text(
                                      alie.messages != null &&
                                              alie.messages.length > 0
                                          ? (alie.messages[0]).text
                                          : "Say Hi! to ${alie.username} ",
                                      style: TextStyle(
                                        color: Colors.blueGrey,
                                        fontSize: 15.0,
                                        fontWeight: FontWeight.w600,
                                      ),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                          Column(
                            children: [
                              Text(
                                "${Time.fromString(alie.lastSeen).showTime()}",
                                overflow: TextOverflow.clip,
                                softWrap: false,
                                style: TextStyle(
                                  color: Colors.grey,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12.0,
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              alie.unreadMessages > 0
                                  ? Container(
                                      width: 40,
                                      height: 20,
                                      decoration: BoxDecoration(
                                          color: Theme.of(context).primaryColor,
                                          borderRadius: BorderRadius.circular(
                                            30.0,
                                          )),
                                      alignment: Alignment.center,
                                      child: Text(
                                        "New",
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 12.0,
                                          color: Colors.white,
                                        ),
                                      ),
                                    )
                                  : Text(""),
                            ],
                          )
                        ],
                      ),
                    ),
                  );
                },
              );
            },
          ),
        ),
      ),
    );
  }
}
