import 'dart:async';
import 'dart:io';

import 'package:ChatUI/libs.dart';
import 'package:ChatUI/messaging/bloc/active_user_messages_state.dart';

class MainService {
  Alie theuser;
  static UpdateData _updateData;
  static SharedPrefHandler _sharedPrefHandler;
  static HttpCallHandler _httpHandler;
  Alie get profile => theuser;
  static String filePath;

  static UserState userState;
  static FriendsState firendsState;
  static InteractiveUser activeUser;
  static OnlineFriends onlineFriendsStates;
  static MessagingDataProvider messagingDataProvider;

  static MainService mainService;

  static Future<MainService> getInstance() async {
    if (userState == null) {
      userState = UserState.instance;
    }
    if (firendsState == null) {
      firendsState = FriendsState.getInstance();
    }
    if (activeUser == null) {
      activeUser = InteractiveUser.instance;
    }
    if (onlineFriendsStates == null) {
      onlineFriendsStates = OnlineFriends.instance;
    }
    if (mainService == null) {
      mainService = MainService();
    }
    if (messagingDataProvider == null) {
      MessagingDataProvider.getInstance().then((mdp) {
        messagingDataProvider = mdp;
      });
    }
    if (webSocketService == null) {
      webSocketService = await WebSocketService.getInstance();
    }
    return mainService;
  }

  void startService() {
    webSocketConnectionHandler();
  }

  static WebSocketService webSocketService;
  static StreamController<bool> onSyncController = StreamController();
  static StreamController<bool> onSyncSearchController = StreamController();
  Stream<bool> get onSync => onSyncController.stream;
  Stream<bool> get onSyncSearch => onSyncSearchController.stream;

  bool running = false;
  void webSocketConnectionHandler() async {
    while (true) {
      running = true;
      await Future.delayed(Duration(seconds: 2), () {
        // This Code Will Run Every 2 second to check the status of the websocket connections
        if (webSocketService.channel == null ||
            webSocketService.channel.closeCode == 1008 ||
            webSocketService.channel.closeCode == 1006) {
          print(
              "\n\n\n\n\n\\n\n\n\n\n\n\n\n\n\n\n\n\n\n    Called ------\n\n\n\n\n\n\n\n\n\n\n");
          WebSocketService.getInstance().then((wshand) {
            // print("Instantiating the WebSocket Class ");
            webSocketService = wshand;
          });
        }
      });
    }
  }

  void updateFriends() async {
    while (true) {
      await Future<void>.delayed(Duration(seconds: 0), () async {
        final users = await UpdateData.getFriends();
        if (users != null && users.length > 0) {
          for (var usr in users) {
            bool result = await usr.populateChats(messagingDataProvider);

            await UpdateData.downloadImage(usr);
          }
          int ctr = 0;
          for (int a = 0; a < chats.length; a++) {
            chats[a].sender = users[ctr];
            ctr++;
            if (ctr > (users.length - 1)) {
              ctr = 0;
            }
          }
        }

        alies.addAll(users);
      });
    }
  }
}
