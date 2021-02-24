
import 'package:ChatUI/libs.dart';



class EEMessage {
  int ID;
  final String senderID;
  final String text;
  final String time;
  final String receiverID;
  bool seen;
  bool sent;
  final int messageNumber;

  set id(int value) {
    this.ID = value;
  }

  EEMessage({
    this.senderID,
    this.text,
    this.time,
    this.receiverID,
    this.seen,
    this.sent,
    this.messageNumber,
  });

  /// fromJson takes a json map ,construct a EEMessage object and
  /// Return the message instance.
  factory EEMessage.fromJson(Map<String, dynamic> theJson) {
    if (theJson == null) {
      return null;
    }
    try {
      final message = EEMessage(
        messageNumber: theJson['message_number'] != null
            ? theJson['message_number'] as int
            : -1,
        receiverID:
            theJson['receiver_id'] != null ? theJson['receiver_id'] : '',
        seen: theJson['seen'] != null ? theJson['seen'] as bool : false,
        sent: theJson['sent'] != null ? theJson['sent'] as bool : false,
        senderID: theJson['sender_id'] != null ? theJson['sender_id'] : '',
        text: theJson['text'] != null ? theJson['text'] : '',
        time: theJson['time'] != null ? theJson['time'] : '',
      );
      if (message.receiverID == '' ||
          message.senderID == '' ||
          message.time == '' ||
          message.text == '' ||
          message.messageNumber <= 0) {
        return null;
      }
      return message;
    } catch (e, a) {
      print(e.toString());
      return null;
    }
  }

  Map<String, dynamic> toJson() {
    return {
      'message_number': this.messageNumber,
      "receiver_id": this.receiverID,
      "seen": seen,
      "sent": this.sent,
      "sender_id": this.senderID,
      "text": this.text,
      "time": this.time,
    };
  }

  /// allMessagesFromJson returning a list of EEMessage instancec from a list of map
  /// each map element will represent a EEMessage instance
  /// if the messages list value is null it will return null instead of list of messages
  static List<EEMessage> allMessagesFromJson(List<Map<String, dynamic>> msgs) {
    if (msgs == null) {
      return null;
    }
    List<EEMessage> messages = [];
    for (var map in msgs) {
      if (map == null) {
        continue;
      }
      final res = EEMessage.fromJson(map as Map<String, dynamic>);
      if (res != null) {
        messages.add(res);
      }
    }
    return messages;
  }
}











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


