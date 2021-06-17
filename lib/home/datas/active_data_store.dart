import 'package:ChatUI/admin/bloc/admin_idea_state.dart';
import 'package:ChatUI/admin/bloc/admin_state_bloc.dart';
import 'package:ChatUI/admin/bloc/admin_users_.dart';
import 'package:ChatUI/libs.dart';

List<Alie> alies = [];

class StaticDataStore {
  // 10.9.216.182
  static const String HOST = "http://10.9.208.154:8080/";
  // static const String HOST = "http://10.0.3.2:8081/";
  static String ID = "";
  static UserState userState;
  static FriendsState friendsState;
  static OnlineFriends onlineFriends;
  static List<Alie> searchResultUsers = [];
  static InteractiveUser interactingUser;
  static AdminState adminState;
  static AdminUsersState adminUsersState;
  static AdminIdeaState adminIdeaState;
}

enum WS_CONNECTION_STATUS {
  connecting,
  connected,
  not_connected,
  closed,
}
