/*This File containes a User Model named Alie 
****** and it's methods + static functions.

 */
import 'package:ChatUI/service/http_service.dart';
class Alie {
  final String id;
  final String imageUrl;
  final String email;
  final String bio;
  final String lastUpdatedTime;
  final String lastSeen;
  final String username;
  bool online=false ;
  bool typing=false;
  List<String> myalies;
  List<String> mygroups;
  List<EEMessage> messages;
  int unreadMessages = 0;

  Alie({
    this.id,
    this.imageUrl,
    this.email,
    this.bio,
    this.lastUpdatedTime,
    this.lastSeen,
    this.username,
    this.myalies,
    this.mygroups,
  });

  factory Alie.fromJson(Map<String, dynamic> theJson) {
    Alie user;
    try {
      user = Alie(
        id: theJson["id"],
        username: theJson["username"],
        imageUrl: theJson["imageurl"] == null ? "" : theJson["imageurl"],
        email: theJson["email"],
        bio: theJson["bio"] == null ? "" : theJson["bio"],
        lastUpdatedTime:
            theJson["last_updated"] != null ? theJson["lastUpdatedTime"] : "",
        lastSeen: theJson['last_seen'] != null ? theJson['last_seen'] : "",
        // myalies: theJson['my_alies'] != null ? theJson['my_alies'] : [],
        // mygroups: theJson['my_groups'] != null ? theJson["my_groups"] : [],
      );
      // user.myalies = (theJson["my_alies"] as List<dynamic>).forEach((element) { }) ;
      user.mygroups = [];
      user.myalies = [];
      if (theJson['my_alies'] != null) {
        for (int a = 0; a < theJson['my_alies'].length; a++) {
          user.myalies.add(theJson['my_alies'][a]);
        }
      }
      if (theJson['my_groups'] != null) {
        for (int a = 0; a < theJson['my_groups'].length; a++) {
          user.mygroups.add(theJson['my_groups'][a]);
        }
      }
    } catch (e, a) {
      print(e.toString());
      user = null;
    }
    return user;
  }

  /// populateChats populates the alie messages field
  /// it returns a bool telling whether the request was
  /// succesful or not
  Future<bool> populateChats(HttpCallHandler handler) async {
    List<EEMessage> ourMessages = await handler.getOurChats(this.id);
    if (ourMessages == null) {
      this.messages = [];
      return false;
    }
    this.messages = ourMessages;
    return true;
  }

  void addMessage(EEMessage message) {
    if (messages == null) {
      this.messages == [];
    }
    this.messages.add(message);
  }

  EEMessage getMessagesByMessageNumber(int messNo) {
    for (EEMessage mess in this.messages) {
      if (mess.messageNumber == messNo) {
        return mess;
      }
    }
    return null;
  }

  bool updateMessage(EEMessage message) {
    for (int a = 0; a < this.messages.length; a++) {
      var mes = this.messages[a];
      if (mes.messageNumber == message.messageNumber) {
        this.messages[a] = message;
        return true;
      }
    }
    return false;
  }

  static List<Alie> AllUsers(List<Map<String, dynamic>> allUsersJson) {
    List<Alie> users = [];
    for (var usr in allUsersJson) {
      Alie newUser = Alie.fromJson(usr);
      users.add(newUser);
    }
    return users;
  }
}

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
