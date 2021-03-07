import 'dart:io';

import 'package:ChatUI/libs.dart';
// import 'package:ChatUI/models/message_model.dart';
// import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RecentChats extends StatelessWidget {
  final String filesPath;
  RecentChats({Key key, this.filesPath}) : super(key: key);

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
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(80),
                                  child: alie.imageUrl == ""
                                      ? Image.asset(alie.imageUrl == ""
                                          ? "assets/images/greg.jpg"
                                          : alie.imageUrl)
                                      : ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(25),
                                          child: Image.network(
                                              StaticDataStore.HOST +
                                                  alie.imageUrl)),
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
                                          ? (alie.messages[
                                                  alie.messages.length - 1])
                                              .text
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
