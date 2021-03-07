import 'dart:io';
import 'package:ChatUI/ideas/bloc/my_ideas_bloc.dart';
import 'package:ChatUI/libs.dart';
import 'package:ChatUI/user/widgets/delete_your_account.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:path_provider/path_provider.dart';

class MyNavigation extends StatefulWidget {
  final Alie user;
  final String filesPath;

  MyNavigation({this.user, this.filesPath});

  @override
  _MyNavigationState createState() {
    return _MyNavigationState(filesPath: filesPath);
  }
}

class _MyNavigationState extends State<MyNavigation> {
  String profileDir = '';
  // final Alie user;
  String filesPath;
  bool loading = false;
  _MyNavigationState({Key key, this.filesPath});

  @override
  void initState() {
    super.initState();
    getApplicationDocumentsDirectory().then((direct) {
      filesPath = direct.path + "/images/";
      // this.profileDir = filesPath
    });
  }

  List<String> categories = [
    "My Ideas",
    // "Deactivate Account",
  ];
  Map<String, List<Object>> categoryList = {
    // "Home": [Icons.home, HomeScreen.Route],
    // "Profile": [Icons.person, ChangeProfile.RouteName],
    "My Ideas": [Icons.wb_incandescent_sharp, IdeaList.routeName],
  };

  @override
  Widget build(BuildContext context) {
    // ignore: close_sinks
    final ideaBloc = BlocProvider.of<MyIdeaBloc>(context);
    ideaBloc.add(IdeaLoad());
    return Drawer(
      elevation: 1,
      child: Container(
        color: Theme.of(context).primaryColorDark,
        width: MediaQuery.of(context).size.width * 0.4,
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.only(
                top: 30,
                bottom: 20,
              ),
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * 0.3,
              child: Column(
                // crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  BlocBuilder<UserState, Alie>(
                    builder: (context, user) {
                      print(StaticDataStore.HOST + user.imageUrl);
                      return InkWell(
                        onTap: () {
                          Navigator.pushNamed(context, ChangeProfile.RouteName);
                        },
                        child: ClipRRect(
                          borderRadius: BorderRadius.all(Radius.circular(30)),
                          child: (user.imageUrl == "" || user.imageUrl == null)
                              ? Container(
                                  height: 100,
                                  width: 100,
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(25),
                                    child: Image.asset(
                                      "assets/images/avatar.png",
                                    ),
                                  ),
                                )
                              : Container(
                                  height: 100,
                                  width: 100,
                                  child: ClipRRect(
                                      borderRadius: BorderRadius.circular(25),
                                      child: Image.network(
                                          StaticDataStore.HOST +
                                              user.imageUrl)),
                                ),
                        ),
                      );
                    },
                  ),
                  BlocBuilder<UserState, Alie>(
                    builder: (_, me) {
                      return Text(
                        me.username,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
            ListTile(
              tileColor: Theme.of(context).primaryColorLight,
              leading: Icon(Icons.person),
              title: Text("Profile"),
              onTap: () {
                // "Profile": [, ChangeProfile.RouteName],
                Navigator.of(context).pushNamed(
                  ChangeProfile.RouteName,
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.wb_incandescent_sharp),
              title: Text("My Ideas"),
              onTap: () {
                Navigator.of(context).pushNamed(IdeaList.routeName);
              },
            ),
            // "Deactivate": [Icons.settings, "/"],
            ListTile(
              leading: Icon(Icons.delete_forever_rounded),
              title: Text("Deactivate"),
              onTap: () {
                StaticDataStore.userState.logout();
                // Stop Services
                UpdateData.onSyncController.close();
                UpdateData.onSyncSearchController.close();
                //Stop Loops
                MainService.stopLoop = true;

                // Close streams
                WebSocketService.channel.sink
                    .close(WebSocketStatus.NORMAL_CLOSURE);

                // Navigator.of(context).pushNamedAndRemoveUntil(AuthScreen.Route,
                //     (_)
                ConfirmAccountDeletion(context, StaticDataStore.ID);
                return false;
                // });
              },
            ),
            ListTile(
              leading: Icon(Icons.logout),
              title: Text("Logout"),
              onTap: () {
                StaticDataStore.userState.logout();

                // Stop Services
                UpdateData.onSyncController.close();
                UpdateData.onSyncSearchController.close();
                //Stop Loops
                MainService.stopLoop = true;

                // Close streams
                WebSocketService.channel.sink
                    .close(WebSocketStatus.NORMAL_CLOSURE);

                Navigator.of(context).pushNamedAndRemoveUntil(AuthScreen.Route,
                    (_) {
                  return false;
                });
              },
            )
          ],
        ),
      ),
    );
  }
}

// "": [,],
