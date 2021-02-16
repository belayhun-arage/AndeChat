/*This file Contains a classes which we used to decode and Encode 
  messages which are to be exchanged through the web socket channel.
*/
import 'package:ChatUI/libs.dart';

enum WS_STATUS_CODE {
  UNKNOWN,
  SEEN,
  TYPING,
  STOP_TYPING,
  EEMESSAGE,
  GMESSAGE,
  ALIE_PROFILE_CHANGE,
  NEW_ALIE,
  GROUP_PROFILE_CHANGE,
  GROUP_JOIN,
  GROUP_LEAVE,
  //this is to be implemented later
  // we did not include this functionality in
  //this project round .
  DELETE_USER,
  ACTIVE_FRIENDS,
}

/// class representing seen message body
/// for end to end message
/// status code 1
class SeenBody {
  int messageNumber;
  String senderID;
  String observerID;

  SeenBody({this.messageNumber  ,this.senderID  , this.observerID });

  Map<String, dynamic> toJson() {
    return {
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
      "status": this.status,
      "body": this.body.toJson(),
    };
  }
}

class TypingBody {
  String typerID;
  String receiverID;
}

class TypingMessage {
  int status;
  TypingBody body;
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
