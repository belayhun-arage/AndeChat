/*This file Contains a classes which we used to decode and Encode 
  messages which are to be exchanged through the web socket channel.
*/
import 'package:ChatUI/libs.dart';

class WS_STATUS_CODE {
  static const int UNKNOWN = 0,
      SEEN = 1,
      TYPING = 2,
      STOP_TYPING = 3,
      EEMESSAGE = 4,
      GMESSAGE = 5,
      ALIE_PROFILE_CHANGE = 6,
      NEW_ALIE = 7,
      GROUP_PROFILE_CHANGE = 8,
      GROUP_JOIN = 9,
      GROUP_LEAVE = 10,
      //this is to be implemented later
      // we did not include this functionality in
      //this project round .
      DELETE_USER = 11,
      ACTIVE_FRIENDS = 12;
}

/// class representing seen message body
/// for end to end message
/// status code 1
class SeenBody {
  int messageNumber;
  String senderID;
  String observerID;

  SeenBody({this.messageNumber, this.senderID, this.observerID});

  factory SeenBody.fromJson(Map<String , dynamic > theJson ) {
    try{
      return SeenBody(
        messageNumber: theJson['message_number'] as int  , 
        observerID: theJson["sender_id"] as String  ,
        senderID: theJson['observer_id'] as String  , 
      );
    }catch(e , a){
      return null ;
    }
  }

  Map<String, dynamic> toJson() {
    return {
      "message_number" : this.messageNumber , 
      "sender_id": this.senderID,
      "body": this.observerID,
    };
  }
}

/// class representing seen message
/// status code 1
class SeenMessage {
  int status;
  SeenBody body;
  SeenMessage({this.status, this.body});
  Map<String, dynamic> toJson() {
    return {
      "status": 1,
      "body": this.body.toJson(),
    };
  }

  /// fromJson frm json method
  factory SeenMessage.fromJson(Map<String, dynamic> theJson) {
    try{
    return SeenMessage(
      status: theJson["status"] as int,
      body: SeenBody.fromJson( theJson['body'] ),
    );
    }catch(e ,a ){
      return null;
    }
  }
}

class TypingBody {
  String typerID;
  String receiverID;

  // TypingBody message
  TypingBody({this.typerID, this.receiverID});

  factory TypingBody.fromJson(Map<String, dynamic> json) {
    try {
      return TypingBody(
        receiverID: json["receiver_id"] as String,
        typerID: json["sender_id"] as String,
      );
    } catch (e, a) {
      return null;
    }
  }
}

class TypingMessage {
  int status;
  TypingBody body;
  TypingMessage({this.status, this.body});

  factory TypingMessage.fromJson(Map<String, dynamic> json) {
    try {
      return TypingMessage(
        status: json["status"] as int,
        body: TypingBody.fromJson(json["body"] as Map<String, dynamic>),
      );
    } catch (e, a) {
      return null;
    }
  }
}

class XEEMessage {
  XEEMessage({this.status, this.body});

  Map<String, dynamic> toJson() {
    return {
      "status": 4,
      "body": this.body.toJson(),
    };
  }

  int status;
  EEMessage body;
}

class GMMessage {
  int status;
  GroupMessage body;

  GMMessage({this.status, this.body});

  Map<String, dynamic> toJson() {
    return {
      "status": this.status,
      "body": this.body.toJson(),
    };
  }
}

class AlieProfile {
  int status;
  Alie body;

  AlieProfile({this.status, this.body});

  Map<String, dynamic> fromJson() {
    return {
      "status": this.status,
      "body": this.body,
    };
  }
}

class NewAlieBody {
  String receiverID;
  Alie user;
  NewAlieBody({this.receiverID, this.user});

  Map<String, dynamic> fromJson() {
    return {
      "receiver_id": this.receiverID,
      "user": this.user,
    };
  }
}

class NewAlie {
  int status;
  NewAlieBody body;

  NewAlie({this.status, this.body});

  Map<String, dynamic> fromJson() {
    return {
      "status": this.status,
      "body": this.body,
    };
  }
}

class GroupProfile {
  int status;
  Group body;

  GroupProfile({this.status, this.body});

  Map<String, dynamic> fromJson() {
    return {
      "status": this.status,
      "body": this.body,
    };
  }
}

class JoinLeaveBody {
  Alie user;
  String groupID;
}

class JoinLeaveMessage {
  int status;
  JoinLeaveBody body;

  JoinLeaveMessage({this.status, this.body});

  Map<String, dynamic> fromJson() {
    return {
      "status": this.status,
      "body": this.body,
    };
  }
}

class ActiveFriends {
  int status;
  String receiverID;
  List<String> activeFriends;
}
