import 'dart:io';
import 'package:ChatUI/libs.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
  final String filesPath;
  bool loading = false;
  _MyNavigationState({Key key, this.filesPath}) {
    // this.profileDir =
    //     "${this.filesPath}${user.imageUrl.split('/')[user.imageUrl.split('/').length - 1]}";
  }

  List<String> categories = [
    "Home",
    "Profile",
    "New Group",
    "Setting",
    "Theme",
    "About Us",
    "Logout"
  ];
  Map<String, List<Object>> categoryList = {
    "Home": [Icons.home, HomeScreen.Route],
    "Profile": [Icons.person, ChangeProfile.RouteName],
    "New Group": [Icons.new_releases_rounded, "/"],
    "Setting": [Icons.settings, "/"],
    "Theme": [Icons.theater_comedy, "/"],
    "About Us": [Icons.group_work_sharp, "/"],
    "Logout": [Icons.logout, "/"],
  };

  @override
  Widget build(BuildContext context) {
    // ignore: close_sinks
    final ideaBloc = BlocProvider.of<IdeaBloc>(context);
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
                      return InkWell(
                        onTap: () {
                          Navigator.pushNamed(context, IdeaList.routeName);
                        },
                        child: ClipRRect(
                          borderRadius: BorderRadius.all(Radius.circular(30)),
                          child: (user.imageUrl == "" || user.imageUrl == null)
                              ? Image.asset(
                                  "assets/images/greg.jpg",
                                )
                              : Image.file(
                                  File('${this.profileDir}'),
                                  height: 150,
                                  width: 180,
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
            Expanded(
              child: Container(
                color: Theme.of(context).primaryColorLight,
                child: ListView.builder(
                  scrollDirection: Axis.vertical,
                  key: UniqueKey(),
                  itemCount: categories.length,
                  padding: EdgeInsets.all(3),
                  itemBuilder: (context, index) {
                    return ListTile(
                      leading: Icon((categoryList[categories[index]])[0]),
                      title: Text(categories[index]),
                      onTap: () {
                        Navigator.of(context)
                            .pushNamed((categoryList[categories[index]])[1]);
                      },
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
