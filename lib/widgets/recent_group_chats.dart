import 'dart:io';

import 'package:ChatUI/models/ee_message_model.dart';
import 'package:ChatUI/screens/chat_screen.dart';
import 'package:flutter/material.dart';

class RecentGroupChats extends StatelessWidget {
  final String filesPath;
  const RecentGroupChats({Key key, this.filesPath}) : super(key: key);

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
          child: ListView.builder(
            itemCount: chats.length,
            itemBuilder: (context, index) {
              final chat = chats[index];
              return GestureDetector(
                onTap: () =>
                    Navigator.pushNamed(context, ChatScreen.Route, arguments: {
                  'user': chat.sender,
                }),
                child: Container(
                  margin: EdgeInsets.only(
                    bottom: 3,
                    right: 10,
                  ),
                  decoration: BoxDecoration(
                    color: chat.unread ? Color(0XFFffeeee) : Colors.white,
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
                          CircleAvatar(
                              radius: 35.0,
                              child: chat.sender.imageUrl == ""
                                  ? Image.asset(chat.sender.imageUrl == ""
                                      ? "assets/images/greg.jpg"
                                      : chat.sender.imageUrl)
                                  : Image.file(
                                      File(
                                          '$filesPath${(chat.sender.imageUrl.split('/')[(chat.sender.imageUrl.split('/').length - 1)])}'),
                                      height: 150,
                                      width: 180,
                                    )
                              // AssetImage(
                              //   chat.sender.imageUrl,
                              // ),
                              ),
                          SizedBox(
                            width: 10.0,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                chat.sender.username,
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
                                width: MediaQuery.of(context).size.width * 0.55,
                                child: Text(
                                  chat.text,
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
                            chat.time,
                            style: TextStyle(
                              color: Colors.grey,
                              fontWeight: FontWeight.bold,
                              fontSize: 15.0,
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          chat.unread
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
          ),
        ),
      ),
    );
  }
}
