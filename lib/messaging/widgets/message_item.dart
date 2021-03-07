import 'dart:io';

import 'package:ChatUI/libs.dart';
import 'package:ChatUI/messaging/models/message_model.dart';
import 'package:ChatUI/messaging/widgets/message_option_pop_up.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// This class represents the a single Message item which is visible in the
/// chat screen between two friends
class MessageItem extends StatelessWidget {
  final EEMessage message;
  final bool isMe;
  MessageItem(this.message, this.isMe);
  @override
  Widget build(BuildContext context) {
    UserState state = BlocProvider.of<UserState>(context);
    if (!(this.isMe) && !(this.message.seen)) {
      SeenMessage mess = SeenMessage(
        status: 1,
        body: SeenBody(
          messageNumber: this.message.messageNumber,
          observerID: this.message.receiverID,
          senderID: this.message.senderID,
        ),
      );
      ChatScreen.websocketService.sendSeenMessage(mess);
    }
    final messageBody = Container(
      width: MediaQuery.of(context).size.width * 0.65,
      padding: EdgeInsets.symmetric(
        horizontal: 25.0,
        vertical: 15.0,
      ),
      margin: isMe
          ? EdgeInsets.only(
              top: 8.0,
              bottom: 8.0,
              left: 80.0,
            )
          : EdgeInsets.only(
              top: 8.0,
              bottom: 8.0,
              right: 80.0,
            ),
      // color: isMe ? Colors.white : Color(0XFFfeeeee),
      decoration: BoxDecoration(
        color: isMe ? Theme.of(context).accentColor : Color(0XFFfeeeee),
        borderRadius: isMe
            ? BorderRadius.only(
                topLeft: Radius.circular(20),
                bottomLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              )
            : BorderRadius.only(
                topLeft: Radius.circular(20),
                bottomRight: Radius.circular(20),
                topRight: Radius.circular(20),
              ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                Time.fromString(message.time).showFullTime(),
                textAlign: TextAlign.start,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.grey,
                ),
              ),
              IconButton(
                icon: Icon(Icons.more_horiz),
                onPressed: () {
                  // print("This is samua");
                  ShowMessagePopup(
                    context,
                    state.state.id == message.receiverID
                        ? message.senderID
                        : message.receiverID,
                    message.messageNumber,
                  );
                },
              )
            ],
          ),
          SizedBox(
            height: 10.0,
          ),
          Text(
            message.text,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              // color: Colors.grey ,
            ),
            textAlign: TextAlign.start,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: SizedBox(),
              ),
              isMe
                  ? Icon(message.seen && message.sent
                      ? Icons.mark_chat_read
                      : Icons.check)
                  : SizedBox()
            ],
          )
        ],
      ),
    );
    if (isMe) {
      return messageBody;
    } else {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          messageBody,
          // IconButton(
          //   iconSize: 30.0,
          //   icon: Icon(
          //     false ? Icons.favorite : Icons.favorite_border,
          //     color: false ? Theme.of(context).primaryColor : Colors.grey,
          //   ),
          //   onPressed: () {
          //     // setState(() {
          //     //   message.isLiked = message.isLiked ? false : true;
          //     // });
          //   },
          // ),
        ],
      );
    }
  }
}
