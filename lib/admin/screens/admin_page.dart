import 'package:ChatUI/admin/widgets/add_admin_fragment.dart';
import 'package:ChatUI/admin/widgets/ida_fragment.dart';

import 'package:ChatUI/admin/widgets/logout_fragment.dart';
import 'package:ChatUI/admin/widgets/search_fragment.dart';
import 'package:flutter/material.dart';

// void main() {
//   runApp(MyApp());
// }

class AdminPage extends StatelessWidget {
  static const RouteName = '/adminpage';
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.deepOrange,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(),
    );
  }
}

class DrawerItem {
  String title;
  IconData icon;
  DrawerItem(this.title, this.icon);
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  final drawerItems = [
    new DrawerItem("Ideas ", Icons.person_add),
    new DrawerItem("Search User", Icons.search),
    new DrawerItem("Add Admin", Icons.person_add),
    new DrawerItem("Logout", Icons.logout),
  ];

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _selectedDrawerIndex = 0;
  // String currentProfilePic =
  //     "https://avatars3.githubusercontent.com/u/16825392?s=460&v=4";

  _getDrawerItemWidget(int pos) {
    switch (pos) {
      case 0:
        return new IdeaFragment();
      case 1:
        return new SearchFragment();
      case 2:
        return new AddAdminFragment();
      case 3:
        return new LogoutFragment();

      default:
        return new Text("Error");
    }
  }

  _onSelectItem(int index) {
    setState(() => _selectedDrawerIndex = index);
    Navigator.of(context).pop(); // close the drawer
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> drawerOptions = [];
    for (var i = 0; i < widget.drawerItems.length; i++) {
      var d = widget.drawerItems[i];
      drawerOptions.add(new ListTile(
        leading: new Icon(d.icon),
        title: new Text(d.title),
        selected: i == _selectedDrawerIndex,
        onTap: () => _onSelectItem(i),
      ));
    }
    return WillPopScope(
      onWillPop: () {
        if (_selectedDrawerIndex != 0) {
          setState(() {
            _selectedDrawerIndex = 0;
          });
          _getDrawerItemWidget(_selectedDrawerIndex);
        } else {
          Navigator.pop(context, true);
        }
        return;
      },
      child: Scaffold(
        appBar: new AppBar(
          title: new Text(widget.drawerItems[_selectedDrawerIndex].title),
        ),
        drawer: new Drawer(
          child: new Column(
            children: <Widget>[
              UserAccountsDrawerHeader(
                accountEmail: new Text("faniman1@gmail.com"),
                accountName: new Text("Fanimann"),
                currentAccountPicture: new GestureDetector(
                  child: new CircleAvatar(
                    // child: Image.asset('images/person3'),

                    //backgroundImage: new NetworkImage(currentProfilePic),
                    backgroundImage: new NetworkImage(
                        'https://images.unsplash.com/photo-1614359499552-2440ac739eeb?ixid=MXwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=750&q=80'),
                  ),
                  onTap: () => print("This is your current account."),
                ),
              ),
              Column(children: drawerOptions)
            ],
          ),
        ),
        body: _getDrawerItemWidget(_selectedDrawerIndex),
      ),
    );
  }
}
