import 'package:ChatUI/libs.dart';

List<Alie> alies = [];

// String myid = '';

class StaticDataStore {
  // 10.9.216.182
  // static const String HOST = "http://10.0.3.2:8080/";
  static const String HOST = "http://10.9.216.182:8080/";
  static String ID = "";
  static UserState userState;
  static FriendsState friendsState;
  static OnlineFriends onlineFriends;
  static List<Alie> searchResultUsers = [];
}

enum WS_CONNECTION_STATUS {
  connecting,
  connected,
  not_connected,
  closed,
}