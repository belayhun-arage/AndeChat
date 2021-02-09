import 'package:ChatUI/data_store/shared_pref.dart';
import 'package:ChatUI/func_handler/updating_loop.dart';
import 'package:ChatUI/models/message_model.dart';
import 'package:ChatUI/models/user_model.dart';
import 'package:ChatUI/widgets/category_selector.dart';
import 'package:ChatUI/widgets/faourite_contacts.dart';
import 'package:ChatUI/widgets/my_navigation.dart';
import 'package:ChatUI/widgets/recent_chats.dart';
import 'package:flutter/material.dart';
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

  @override
  void initState() {
    getApplicationDocumentsDirectory()
        .then((value) => this.filesPath = value.path + '/images/');
    UpdateData.getInstance().then((value) async {
      SharedPrefHandler.getInstance().then((vala) async {
        _sharedPrefHandler = vala;
      });
      updator = value;
      updator.onSync.listen((bool syncState) => setState(() {
            isLoading = syncState;
            if (isLoading) {
              return false;
            }
          }));
      await updator.run();
      user = updator.theuser;
    });
    super.initState();
  }

  void setTabName(String name) {
    setState(() {
      this.tabname = name;
    });
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
            : Text(
                tabname,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
                textAlign: TextAlign.center,
              ),
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
                    //
                  },
                ),
        ],
      ),
      body:
          //isLoading
          //     ? Center(
          //         child: CircularProgressIndicator(
          //         backgroundColor: Theme.of(context).primaryColor,
          //       ))
          //     :
          Column(
        children: [
          CategorySelector(setTabName: setTabName),
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: Theme.of(context).accentColor,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
              ),
              // padding: EdgeInsets.all(10.0),
              child: Column(
                children: [
                  // FavouriteContact(),
                  RecentChats(
                    filesPath: filesPath,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
