import 'dart:async';
import 'dart:io';
import 'dart:typed_data';
import 'package:ChatUI/libs.dart';
import 'package:path_provider/path_provider.dart';

class UpdateData {
  UpdateData();

  Alie theuser;
  static UpdateData _updateData;
  static SharedPrefHandler _sharedPrefHandler;
  static UserDataProvider userDataProvider;
  Alie get profile => theuser;
  static String filePath;

  static UserCubit userState;
  static FriendsState firendsState;
  static InteractiveUser activeUser;
  static OnlineFriends onlineFriendsStates;
  static MessagingDataProvider messagingDataProvider;

  static StreamController<bool> onSyncController = StreamController();
  static StreamController<bool> onSyncSearchController = StreamController();
  Stream<bool> get onSync => onSyncController.stream;
  Stream<bool> get onSyncSearch => onSyncSearchController.stream;

  static Future<UpdateData> getInstance() async {
    if (userState == null) {
      userState = UserCubit.instance;
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
    if (messagingDataProvider == null) {
      MessagingDataProvider.getInstance().then((mdp) {
        messagingDataProvider = mdp;
      });
    }
    if (onSyncController == null) {
      onSyncController = new StreamController();
    }
    if (_sharedPrefHandler == null) {
      _sharedPrefHandler = await SharedPrefHandler.getInstance();
    }
    if (userDataProvider == null) {
      userDataProvider = await UserDataProvider.getInstance();
    }
    if (messagingDataProvider == null) {
      messagingDataProvider = await MessagingDataProvider.getInstance();
    }
    _updateData = UpdateData();

    return _updateData;
  }

  static Future<void> instantiateStates() async {
    if (userState == null) {
      userState = UserCubit.instance;
    }
    if (_sharedPrefHandler == null) {
      _sharedPrefHandler = await SharedPrefHandler.getInstance();
    }
    if (userDataProvider == null) {
      userDataProvider = await UserDataProvider.getInstance();
    }
    if (messagingDataProvider == null) {
      messagingDataProvider = await MessagingDataProvider.getInstance();
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
    _updateData = UpdateData();
  }

  void run() async {
    instantiateStates();
    while (theuser == null) {
      await Future<void>.delayed(Duration(seconds: 0), () async {
        // await _httpHandler.
        onSyncController.add(true);

        this.theuser = await userDataProvider.getMyProfile();
        if (theuser != null) {
        } else {
          return;
        }
        if (theuser.imageUrl != '' && theuser.imageUrl.split('/').length > 0) {
          await downloadImage(this.theuser);
        }
        myid = theuser.id;
        final users = await getFriends();
        if (users != null && users.length > 0) {
          for (var usr in users) {
            bool result = await usr.populateChats(messagingDataProvider);

            await downloadImage(usr);
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
        // print('Number of Found Friends ${users.length}');
        // alies.addAll(users);
//
        if (firendsState == null) {
          await Future.delayed(Duration(seconds: 3), () async {
            firendsState = await FriendsState.getInstance();
          });
        }
        firendsState.updateFriendsState(users);

        onSyncController.add(false);
      });
    }
  }

  static Future<List<Alie>> getFriends() async {
    List<Alie> friends = [];
    friends = await userDataProvider.getMyFriends();
    return friends;
  }

  // Future<List<Group>>  getGroups() async {

  // }

  static Future<bool> downloadImage(Alie user) async {
    instantiateStates();
    if (user == null || user.imageUrl == "") {
      return false;
    }
    var documentDirectory = await getApplicationDocumentsDirectory();
    var firstPath = "${documentDirectory.path}/images/";
    filePath = firstPath;
    var dir = user.imageUrl.split("/");

    var filePathAndName = firstPath + dir[dir.length - 1];
    // saving the file path to the shared preferences
    _sharedPrefHandler.setFilePath(firstPath);

    await Directory(firstPath).create(recursive: true);
    File file2 = new File(filePathAndName);
    if (file2.existsSync()) {
      return false;
    }
    Uint8List bodyBytes =
        await userDataProvider.getProfileImage(userState.state.imageUrl);
    if (!(bodyBytes == null || bodyBytes.length == 0)) {
      // valie image found now i am saving to the localstorage

      file2.writeAsBytesSync(
        bodyBytes,
      );
      print("image Downloadedd .... ");
    }
  }

  Future<void> searchUsers(String username) async {
    instantiateStates();
    onSyncSearchController.add(true);
    final result = await userDataProvider.searchUsers(username);
    if (result == null) {
      print("Error Searching Users by username $username");
      return;
    }
    searchResultUsers = result;
    for (var usr in searchResultUsers) {
      bool result = await usr.populateChats(messagingDataProvider);
      await downloadImage(usr);
    }
    onSyncSearchController.add(false);
  }
}
