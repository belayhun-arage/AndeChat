import 'package:ChatUI/messaging/models/message_model.dart';
import 'package:flutter/material.dart';

/// This class represents the a single Message item which is visible in the 
/// chat screen between two friends  
class MessageItem extends StatelessWidget {
  final EEMessage message;
  final bool isMe;
  MessageItem(this.message, this.isMe);
  @override
  Widget build(BuildContext context) {
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
          Text(
            message.time,
            textAlign: TextAlign.start,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.grey,
            ),
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
