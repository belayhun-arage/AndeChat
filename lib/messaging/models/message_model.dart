
import 'package:ChatUI/libs.dart';

class Message {
  // final Alie sender;
  Alie sender;
  
  final String
      time; // Would usually be type DateTime or Firebase Timestamp in production apps
  final String text;
    bool isLiked;
  // final bool isLiked;
  final bool unread;

  Message({
    this.sender,
    this.time,
    this.text,
    this.isLiked,
    this.unread,
  });
}