import 'dart:convert';
import 'dart:io';

import 'package:ChatUI/libs.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'package:web_socket_channel/io.dart';

class WebSocketService {
  static WebSocketChannel _channel;
  static WebSocketService _service; // 10.9.216.182
  // static const String WSHOST = 'ws://10.0.3.2:8081/chat/';
  static const String WSHOST = 'ws://10.9.208.154:8080/chat/';
  //  List Of Blocs will be listed here .
  static UserState userState;
  static FriendsState firendsState;
  static InteractiveUser activeUser;
  static OnlineFriends onlineFriendsStates;
  static MessagingDataProvider messagingDataProvider;

  // WebSocketService();
  static WebSocketChannel get channel {
    return _channel;
  }

  static Map<String, String> headers;
  static SessionHandler _sessionHandler;
  static Future<WebSocketService> getInstance() async {
    // instanciating web socket used blocs will be listed here.
    if (_sessionHandler == null) {
      _sessionHandler = await HttpCallHandler.sessionHandler;
    }
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
      onlineFriendsStates = StaticDataStore.onlineFriends;
      // onlineFriendsStates = OnlineFriends.
    }
    if (messagingDataProvider == null) {
      MessagingDataProvider.getInstance().then((mdp) {
        messagingDataProvider = mdp;
      });
    }

    if (_channel == null ||
        _channel.closeCode == 1008 ||
        _channel.closeCode == 1006) {
      headers = await _sessionHandler.getHeader();
      try {} catch (e, a) {}
      _channel = new IOWebSocketChannel.connect(WSHOST, headers: headers);
      // print(headers);
      _channel.stream.listen((data) async {
        final jsonMessage = jsonDecode(data);

        print(
            " >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> : ${jsonMessage["status"]} , ${jsonMessage["status"].runtimeType} ");

        switch (jsonMessage['status']) {

          /// End to End Message
          case 4:
            {
              print(
                  "\n\n\n\n\n\n\n\n\n\n\n\n\n\nMessage Has Commed \n\n\n\n\n\n\n\n\n\n\n\n\n\n");
              /*
              FOrmat 
              {
                "status":4,
                "body":{
                  "id":"",
                  "sender_id":"6018345a568eb05dba348aba",
                  "receiver_id":"6026863a8c78f9149bda8242",
                  "text":"dapdsd",
                  "time":"2021-02-28T20:17:56.937165352+03:00",
                  "seen":false,
                  "sent":false,
                  "seen_confirmed":false,
                  "message_number":4
                  }
              }  
              */
              final myID = StaticDataStore.userState.state.id;
              final eemessage = EEMessage.fromJson(jsonMessage['body']);

              String alieID = (eemessage.senderID == myID)
                  ? eemessage.receiverID
                  : eemessage.senderID;

              // getting the list of alies and change the messages in the alie
              // which matches the alie id

              // here  firendslist and its internal messages are to be changed
              int alieIndex = 0;
              int indctr = 0;

              Alie newAlie = StaticDataStore.interactingUser.state;
              newAlie.messages.add(eemessage);
              List<Alie> myfriends = StaticDataStore.friendsState.state;
              if (myfriends == null || myfriends.length == 0) {
                newAlie.messages =
                    newAlie.messages != null ? newAlie.messages : [];
                newAlie.messages.add(eemessage);
                myfriends = [newAlie];
                StaticDataStore.interactingUser
                    .updateActiveUserMessages(newAlie);
              } else {
                for (int a = 0; a < myfriends.length; a++) {
                  final dalie = myfriends[a];
                  if (dalie.id == alieID) {
                    print(
                        "\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n8888888888888888888888888888888888888888888888888\n\n\n\n\n\n\n\n\n\n\n");
                    dalie.messages.add(eemessage);
                    myfriends[a] = dalie;
                    StaticDataStore.friendsState.updateFriendsState(myfriends);
                    StaticDataStore.interactingUser
                        .updateActiveUserMessages(dalie);
                    break;
                  }
                }
                myfriends.add(newAlie);
              }

              // swaping the alie to the firest row in the alies list
              // final updatedAlie = updatedFriends[alieIndex];
              // updatedFriends.removeAt(alieIndex);
              // updatedFriends = [updatedAlie, ...updatedFriends];

              // if (StaticDataStore.interactingUser.state.id == alieID) {
              //   final alie = StaticDataStore.interactingUser.state;
              //   // alie.messages = removeRedundantMessage(alie.messages);
              //   if (alie.messages != null) {
              //     alie.messages.add(eemessage);
              //   } else {
              //     alie.messages = [eemessage];
              //   }
              //   StaticDataStore.interactingUser.updateActiveUserMessages(alie);
              // }
              // // now notifying the change to the
              // updatedFriends = removeRedundantAlie(updatedFriends);
              StaticDataStore.friendsState.updateFriendsState(myfriends);
              break;
            }

          /// active friends notification
          case WS_STATUS_CODE.ACTIVE_FRIENDS:
            {
              onlineFriendsStates ??= await OnlineFriends.instance;
              final friends =
                  List.generate(jsonMessage["active_friends"].length, (val) {
                return jsonMessage["active_friends"][val] as String;
              });
              onlineFriendsStates.updateOnlineFriends(friends);
              break;
            }
          case WS_STATUS_CODE.ALIE_PROFILE_CHANGE:
            {
              print("--------------ALIE_PROFILE_CHANGE--------------");
              break;
            }
          case WS_STATUS_CODE.DELETE_USER:
            {
              print("--------------DELETE-USER--------------");

              break;
            }
          // case WS_STATUS_CODE.GMESSAGE:
          //   {
          //     print("------------GMESSAGE----------------");

          //     break;
          //   }
          case WS_STATUS_CODE.ALIE_PROFILE_CHANGE:
            {
              print("----------------ALIE_PROFILE_CHANGE------------");

              break;
            }
          case WS_STATUS_CODE.SEEN:
            {
              /*
                {
                  "status": this.status,
                  "body":  {
                    "sender_id" : "99999999999" ,
                    "observer_id"  : "99998888888" , 
                  }
                }
              */
              final seen = SeenMessage.fromJson(jsonMessage['body']);
              print(" SEEN MESSAGE $jsonMessage");
              break;
            }
          case WS_STATUS_CODE.TYPING:
            {
              List<Alie> alies = [];

              final typingMessage = TypingMessage.fromJson(jsonMessage);
              if (typingMessage.body.typerID == userState.state.id) {
                break;
              }
              bool changed = false;
              for (Alie alie in StaticDataStore.friendsState.state) {
                if (alie.id == typingMessage.body.typerID) {
                  alie.typing = true;
                }
                alies.add(alie);
              }
              StaticDataStore.friendsState.updateFriendsState(alies);
              break;
            }
          // case WS_STATUS_CODE.GROUP_JOIN:
          //   {
          //     print("----------------------------");

          //     break;
          //   }
          // case WS_STATUS_CODE.GROUP_LEAVE:
          //   {
          //     print("----------------------------");

          //     break;
          //   }
          // case WS_STATUS_CODE.UNKNOWN:
          //   // TODO: Handle this case.
          //   print("----------------------------");

          //   break;
          // case WS_STATUS_CODE.STOP_TYPING:
          //   // TODO: Handle this case.
          //   print("----------------------------");

          //   break;
          // case WS_STATUS_CODE.NEW_ALIE:
          //   // TODO: Handle this case.
          //   print("----------------------------");
          //   break;
          // case WS_STATUS_CODE.GROUP_PROFILE_CHANGE:
          //   // TODO: Handle this case.
          //   print("----------------------------");

          //   break;
        }
      }, onError: (mess) {
        print("     Error Happened ... ");
      }, cancelOnError: false);
    }
    if (_service == null) {
      _service = WebSocketService();
    }
    return _service;
  }

  static WS_CONNECTION_STATUS status = WS_CONNECTION_STATUS.not_connected;
  WS_CONNECTION_STATUS getStatus() {
    if (_channel == null) {
      status = WS_CONNECTION_STATUS.closed;
    }
    return status;
  }

  // sendEEMessage
  bool sendEEMessage(EEMessage message) {
    print("message written to the websocket");

    final xeemess = XEEMessage(status: 4, body: message);
    print(jsonEncode(xeemess.toJson()));
    _channel.sink.add(jsonEncode(xeemess.toJson()));
  }

  // sendEEMessage
  bool sendSeenMessage(SeenMessage seenmes) {
    _channel.sink.add(jsonEncode(seenmes.toJson()));
  }

  bool sendTypingMessage(TypingMessage message) {
    _channel.sink.add(jsonEncode(message));
  }

  bool sendGroupMessage(GroupMessage message) {
    _channel.sink.add(jsonEncode(message));
  }

  bool sendJoinLeavMessage(JoinLeaveMessage message) {
    _channel.sink.add(jsonEncode(message));
  }
  // bool

  static List<Alie> removeRedundantAlie(List<Alie> alies) {
    for (int a = 0; a < alies.length; a++) {
      String id = alies[a].id;
      int count = 0;
      alies.removeWhere((alie) {
        if (alie.id == id) {
          count++;
        }
        return count > 1;
      });
    }
    return alies;
  }

  static List<EEMessage> removeRedundantMessage(List<EEMessage> messages) {
    for (int a = 0; a < messages.length; a++) {
      int msn = messages[a].messageNumber;
      int count = 0;
      for (int z = 0; z < messages.length; z++) {
        messages.removeWhere((message) {
          if (message.messageNumber == msn) {
            count++;
          }
          return count > 1;
        });
      }
    }
    return messages;
  }
}
