import 'package:ChatUI/libs.dart';

List<Alie> alies = [];

// String myid = '';

class StaticDataStore {
  static const String HOST = "http://10.0.3.2:8080/";
  static String ID = "";
  static UserState userState;
  static FriendsState friendsState;
  static List<Alie> searchResultUsers = [];
}

enum WS_CONNECTION_STATUS {
  connecting,
  connected,
  not_connected,
  closed,
}
