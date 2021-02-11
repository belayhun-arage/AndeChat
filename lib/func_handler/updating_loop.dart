import 'dart:async';
import 'dart:io';
import 'dart:typed_data';

import 'package:ChatUI/data_store/active_data_store.dart';
import 'package:ChatUI/data_store/shared_pref.dart';
import 'package:ChatUI/models/ee_message_model.dart';
import 'package:ChatUI/models/user_model.dart';
import 'package:ChatUI/service/http_service.dart';
import 'package:path_provider/path_provider.dart';

class UpdateData {
  UpdateData();

  Alie theuser;
  static UpdateData _updateData;
  static SharedPrefHandler _sharedPrefHandler;
  static HttpCallHandler _httpHandler;
  Alie get profile => theuser;
  static String filePath;

  static StreamController<bool> onSyncController = StreamController();
  static StreamController<bool> onSyncSearchController = StreamController();
  Stream<bool> get onSync => onSyncController.stream;
  Stream<bool> get onSyncSearch => onSyncSearchController.stream;

  static Future<UpdateData> getInstance() async {
    if (onSyncController == null) {
      onSyncController = new StreamController();
    }
    if (_updateData == null) {
      if (_sharedPrefHandler == null) {
        _sharedPrefHandler = await SharedPrefHandler.getInstance();
      }
      if (_httpHandler == null) {
        _httpHandler = await HttpCallHandler.getInstance();
      }
      _updateData = UpdateData();
    }
    return _updateData;
  }

  void run() async {
    while (theuser == null) {
      await Future<void>.delayed(Duration(seconds: 0), () async {
        // await _httpHandler.
        onSyncController.add(true);

        this.theuser = await _httpHandler.getMyProfile();
        print("The User Found Is ${this.theuser}");
        if (theuser != null) {
          print('${theuser.username} , ${theuser.bio}');
        } else {
          return;
        }
        if (theuser.imageUrl != '' && theuser.imageUrl.split('/').length > 0) {
          await downloadImage(this.theuser);
        }
        myid = theuser.id;
        final users = await getFriends();
        if (users != null && users.length > 0) {
          print("The Length of Users List ${users.length}");
          for (var usr in users) {
            bool result = await usr.populateChats(_httpHandler);
            if (!result) {
              print(
                  "fetching messages was not succesful .. error has happened ...");
            } else {
              print('succesfuly fetched messages nigga .');
            }
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
        print('Number of Found Friends ${users.length}');
        alies.addAll(users);
        onSyncController.add(false);
      });
    }
  }

  Future<List<Alie>> getFriends() async {
    List<Alie> friends = [];
    final usersJson = await _httpHandler.getMyFriends();
    if ((usersJson['success'] as bool) == true) {
      print(usersJson['alies'] as List<dynamic>);
      List<Map<String, dynamic>> newmapListUser = [];
      for (int a = 0; a < usersJson['alies'].length; a++) {
        newmapListUser.add(usersJson['alies'][a] as Map<String, dynamic>);
      }
      friends = Alie.AllUsers(newmapListUser);
      return friends;
    } else {
      return friends;
    }
  }

  // Future<List<Group>>  getGroups() async {

  // }

  Future<bool> downloadImage(Alie user) async {
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
    Uint8List bodyBytes = await _httpHandler.getProfileImage(theuser.imageUrl);
    if (!(bodyBytes == null || bodyBytes.length == 0)) {
      // valie image found now i am saving to the localstorage

      file2.writeAsBytesSync(
        bodyBytes,
      );
      print("image Downloadedd .... ");
    }
  }

  Future<void> searchUsers(String username) async {
    onSyncSearchController.add(true);
    final result = await _httpHandler.searchUsers(username);
    if (result == null) {
      print("Error Searching Users by username $username");
      return;
    }
    searchResultUsers = result;
    for (var usr in searchResultUsers) {
      bool result = await usr.populateChats(_httpHandler);
      await downloadImage(usr);
    }
    onSyncSearchController.add(false);
  }
  /*var documentDirectory = await getApplicationDocumentsDirectory();
          var firstPath = "${documentDirectory.path}/images/";
          filePath = firstPath;
          var dir = theuser.imageUrl.split("/");

          var filePathAndName = firstPath + dir[dir.length - 1];
          // saving the file path to the shared preferences
          _sharedPrefHandler.setFilePath(firstPath);

          await Directory(firstPath).create(recursive: true);
          File file2 = new File(filePathAndName);
          if (file2.existsSync()) {
            onSyncController.add(false);
            return;
          }
          Uint8List bodyBytes =
              await _httpHandler.getProfileImage(theuser.imageUrl);
          if (!(bodyBytes == null || bodyBytes.length == 0)) {
            // valie image found now i am saving to the localstorage

            file2.writeAsBytesSync(
              bodyBytes,
            );
            print("Downloading nigga ... ");
          }*/
}
