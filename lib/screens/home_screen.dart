import 'package:ChatUI/data_store/active_data_store.dart';
import 'package:ChatUI/data_store/shared_pref.dart';
import 'package:ChatUI/func_handler/updating_loop.dart';

import 'package:ChatUI/models/user_model.dart';
import 'package:ChatUI/stateClasses/tab_index_state.dart';
import 'package:ChatUI/widgets/category_selector.dart';
import 'package:ChatUI/widgets/chats_list.dart';

import 'package:ChatUI/widgets/my_navigation.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:path_provider/path_provider.dart';

class HomeScreen extends StatefulWidget {
  static const String Route = "/home";

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String tabname = "Messages";

  List friends = [];
  List groups = [];

  Alie user;
  UpdateData updator;
  bool isLoading = true;
  String filesPath = "";
  SharedPrefHandler _sharedPrefHandler;
  bool searchEntryIsVisible = false;
  bool searching = false;

  TextEditingController searchController;
  bool searchInProgress = false;
  bool isSearchResultLoading = false;
  UpdateData _updateData;
  PageController pageController = PageController(initialPage: 0);

  @override
  void initState() {
    searchEntryIsVisible = false;
    searching = false;
    searchController = new TextEditingController();

    getApplicationDocumentsDirectory()
        .then((value) => this.filesPath = value.path + '/images/');

    UpdateData.getInstance().then((value) async {
      SharedPrefHandler.getInstance().then((vala) async {
        _sharedPrefHandler = vala;
      });
      updator = value;

      updator.onSyncSearch.listen((bool event) {
        setState(() {
          this.searchInProgress = event;
        });
      });

      updator.onSync.listen((bool syncState) => setState(() {
            isLoading = syncState;
            if (isLoading) {
              return false;
            }
          }));

      await updator.run();
      user = updator.theuser;
    });
    UpdateData.getInstance().then((value) => this._updateData = value);
    super.initState();
  }

  void setTabName(String name) {
    setState(() {
      this.tabname = name;
    });
  }

  void changeSearchStatus() {
    setState(() {
      if (this.searchEntryIsVisible) {
        this.searchEntryIsVisible = false;
        searchResultUsers = [];
      } else {
        this.searchEntryIsVisible = true;
      }
    });
  }

  Future<void> searchUsers(String username) async {
    if (this._updateData != null) {
      await this._updateData.searchUsers(username);
    }
  }

  @override
  Widget build(BuildContext context) {
    print(this.filesPath);
    return Scaffold(
      backgroundColor:
          isLoading ? Colors.white : Theme.of(context).primaryColor,
      drawer: isLoading
          ? null
          : MyNavigation(
              user: updator.theuser,
              filesPath: this.filesPath,
            ),
      drawerEnableOpenDragGesture: true,
      appBar: AppBar(
        // leading: IconButton(
        //   icon: Icon(Icons.menu),
        //   iconSize: 30,
        //   color: Colors.white,
        //   onPressed: () {
        //     //
        //   },
        // ),
        title: isLoading
            ? SizedBox()
            : (this.searchEntryIsVisible
                ? TextField(
                    autofocus: true,
                    cursorColor: Colors.white,
                    showCursor: true,
                    decoration: InputDecoration(
                      hintStyle: TextStyle(
                        color: Colors.white,
                        fontStyle: FontStyle.italic,
                        fontWeight: FontWeight.bold,
                      ),
                      counterStyle: TextStyle(
                        color: Colors.white24,
                      ),
                      focusColor: Colors.white,
                      hintText: "    Type Username .. ",
                      alignLabelWithHint: true,
                      helperMaxLines: 1,
                    ),
                    controller: searchController,
                    onChanged: (String value) {
                      this.searchUsers(value);
                      if (value.length > 0) {
                        setState(() {
                          searching = true;
                        });
                      } else {
                        setState(() {
                          searching = false;
                        });
                      }
                    },
                  )
                : Text(
                    tabname,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                    textAlign: TextAlign.center,
                  )),
        centerTitle: true,
        elevation: 0.0,
        actions: [
          isLoading
              ? SizedBox()
              : IconButton(
                  icon: Icon(Icons.search),
                  iconSize: 30,
                  color: Colors.white,
                  onPressed: () {
                    changeSearchStatus();
                  },
                ),
        ],
      ),
      body: isLoading
          ? Center(
              child: CircularProgressIndicator(
              backgroundColor: Theme.of(context).primaryColor,
            ))
          : Column(
              children: [
                // This is the category class where the Home  , Chat mnamn Navigations resides
                CategorySelector(
                  selectedIndex: 0,
                ),
                BlocBuilder<TabIndex, int>(builder: (_, val) {
                  switch (val) {
                    case 0:
                      {
                        return Expanded(child : Container(color: Colors.blue) , );
                      }
                    case 1:
                      {
                        return Chats(
                          filesPath: filesPath,
                          searchInProgress: searchInProgress,
                          searching: searching,
                        );
                      }
                    
                    case 2:
                      {
                        return Expanded(child : Container(color: Colors.green) , );
                      }
                    case 3:
                      {
                        return Expanded(child : Container(color: Colors.yellow), );
                      }
                    default:
                      {
                        return Chats(
                          filesPath: filesPath,
                          searchInProgress: searchInProgress,
                          searching: searching,
                        );
                      }
                  }
                }),
                // PageView(
                //     controller: pageController,
                //     children: [
                //       Chats(
                //         filesPath: filesPath,
                //         searchInProgress: searchInProgress,
                //         searching: searching,
                //       ),
                //       Container(color: Colors.blue),
                //       Container(color: Colors.green),
                //       Container(color: Colors.yellow),
                //     ],
                //   ),
              ],
            ),
    );
  }
}
