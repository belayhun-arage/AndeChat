/*This File containes a User Model named Alie 
****** and it's methods + static functions.
 */
import 'package:ChatUI/libs.dart';
import 'package:ChatUI/service/http_service.dart';
import 'package:ChatUI/user/user.dart';

class Alie {
  final String id;
  final String imageUrl;
  final String email;
  final String bio;
  final String lastUpdatedTime;
  final String lastSeen;
  final String username;
  int idesCount;
  bool online = false;
  bool typing = false;
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
      if(theJson[""])
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
  Future<bool> populateChats(MessagingDataProvider handler) async {
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
    print("$allUsersJson\n\n");
    print( allUsersJson.runtimeType );
    List<Alie> users = [];
    for (var usr in allUsersJson) {
      print(usr);
      Alie newUser = Alie.fromJson(usr);
      print(newUser);
      users.add(newUser);
    }
    return users;
  }
}

