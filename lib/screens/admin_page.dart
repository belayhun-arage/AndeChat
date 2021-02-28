import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
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
    new DrawerItem("Search ", Icons.search),
    new DrawerItem("Remove User", Icons.person_remove),
    new DrawerItem("Add User", Icons.person_add),
    new DrawerItem("Logout", Icons.logout),
  ];

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _selectedDrawerIndex = 0;
  String currentProfilePic =
      "https://avatars3.githubusercontent.com/u/16825392?s=460&v=4";

  _getDrawerItemWidget(int pos) {
    switch (pos) {
      case 0:
        return new FirstFragment();
      case 1:
        return new SecondFragment();
      case 2:
        return new ThirdFragment();
      case 3:
        return new FourthFragment();

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
//     return Scaffold(
//       appBar: AppBar(title: Text('Naviagtion')),
//       body: SingleChildScrollView(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//           children: [
//             Card(
//               child: Text('This Is Fanimann'),
//             ),

//           ],
//         ),
//       ),
//       drawer: Drawer(

//         child: ListView(
//           children: <Widget>[
//             DrawerHeader(
//               padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 15.0),
//               child: Column(
//                 children: <Widget>[
//                   Row(
//                     children: <Widget>[
//                       SizedBox(
//                         height: 130,
//                       ),
//                       ClipRRect(
//                           borderRadius: BorderRadius.circular(25.0),
//                           child: Image.asset(
//                             'images/person3.jpeg',
//                             width: 40,
//                           )),
//                       SizedBox(
//                         width: 20,
//                       ),
//                       Flexible(
//                         child: Stack(
//                           children: <Widget>[
//                             Row(
//                               children: <Widget>[
//                                 Text('Welcolme',
//                                     style: TextStyle(
//                                         fontSize: 13,
//                                         color: Color(0xffBAB8B8))),
//                               ],
//                             ),
//                             Row(
//                               children: <Widget>[
//                                 SizedBox(
//                                   height: 48,
//                                 ),
//                                 Text(
//                                   'Fani Man',
//                                   style: TextStyle(
//                                       fontWeight: FontWeight.bold,
//                                       color: Color(0xffECF0F1)),
//                                 ),
//                               ],
//                             )
//                           ],
//                         ),
//                       )
//                     ],
//                   ),
//                 ],
//               ),
//               decoration: BoxDecoration(
//                 color: Color(0xff2A3F54),
//               ),
//             ),
//             ListTile(
//               leading: const Icon(
//                 Icons.search,
//                 color: Color(0xffE7E7E7),
//               ),
//               title: Text(
//                 'Search',
//                 style: TextStyle(
//                   color: Color(0xffE7E7E7),
//                   fontSize: 14,
//                 ),
//               ),
//               onTap: () {
// //                      HomePage();
//                 setState(() {
//                   Navigator.pop(context);
//                   //_currentPage = 0;
//                 });
//               },
//             ),
//             ListTile(
//               leading:
//                   const Icon(Icons.person_remove, color: Color(0xffE7E7E7)),
//               title: Text('Remove User',
//                   style: TextStyle(
//                     color: Color(0xffE7E7E7),
//                     fontSize: 14,
//                   )),
//               onTap: () {
// //                      HomePage();
//                 setState(() {
//                   Navigator.pop(context);
//                   //  _currentPage = 1;
//                 });
//               },
//             ),
//             ListTile(
//                 leading: const Icon(Icons.person_add, color: Color(0xffE7E7E7)),
//                 title: Text('Add User',
//                     style: TextStyle(
//                       color: Color(0xffE7E7E7),
//                       fontSize: 14,
//                     )),
//                 onTap: () {
// //                      HomePage();
//                   setState(() {
//                     Navigator.pop(context);
//                     //  _currentPage = 1;
//                   });
//                 }),
//             ListTile(
//                 leading: const Icon(Icons.person_add, color: Color(0xffE7E7E7)),
//                 title: Text('Yehone Ngr',
//                     style: TextStyle(
//                       color: Color(0xffE7E7E7),
//                       fontSize: 14,
//                     )),
//                 onTap: () {
// //                      HomePage();
//                   setState(() {
//                     Navigator.pop(context);
//                     //  _currentPage = 1;
//                   });
//                 }),
//             ListTile(
//                 leading: const Icon(Icons.logout, color: Color(0xffE7E7E7)),
//                 title: Text('Log Out',
//                     style: TextStyle(
//                       color: Color(0xffE7E7E7),
//                       fontSize: 14,
//                     )),
//                 onTap: () {
// //                      HomePage();
//                   setState(() {
//                     Navigator.pop(context);
//                     //  _currentPage = 1;
//                   });
//                 }),
//           ],
//         ),
//       ),
//     );
//  }
//}

//////
class FirstFragment extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Center(
      child: new Text("Search For User"),
    );
  }
}

class SecondFragment extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Center(
      child: new Text("You Remove User"),
    );
  }
}

class ThirdFragment extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Center(
      child: new Text("You Add User "),
    );
  }
}

class FourthFragment extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Center(
      child: new Text("You are Logging Out"),
    );
  }
}

/*  //Using Different Screens For EACH Drawer Elements In Flutter
void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
        title: 'Navigation Demo',
        debugShowCheckedModeBanner: false,
        theme: new ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: HomePage()
    );
  }
}
class DrawerItem {
  String title;
  IconData icon;
  DrawerItem(this.title, this.icon);
}

class HomePage extends StatefulWidget {
  final drawerItems = [
    new DrawerItem("Favorites ", Icons.rss_feed),
    new DrawerItem("Music", Icons.local_pizza),
    new DrawerItem("Places", Icons.info)
  ];

  @override
  State<StatefulWidget> createState() {
    return new HomePageState();
  }
}

class HomePageState extends State<HomePage> {
  int _selectedDrawerIndex = 0;

  String currentProfilePic =
      "https://avatars3.githubusercontent.com/u/16825392?s=460&v=4";

  _getDrawerItemWidget(int pos) {
    switch (pos) {
      case 0:
        return new FirstFragment();
      case 1:
        return new SecondFragment();
      case 2:
        return new ThirdFragment();

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
                accountEmail: new Text("bramvbilsen@gmail.com"),
                accountName: new Text("Bramvbilsen"),
                currentAccountPicture: new GestureDetector(
                  child: new CircleAvatar(
                    backgroundImage: new NetworkImage(currentProfilePic),
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


*/

//   ),
//  ),
// Expanded(
//   child: Scaffold(
//     appBar: AppBar(
//       automaticallyImplyLeading:
//           MediaQuery.of(context).size.width < 600,
//       title: Text('AdminPage'),
//       actions: <Widget>[
//         IconButton(
//           icon: const Icon(
//             Icons.exit_to_app,
//             color: Color(0xff2A3F54),
//           ),
//           tooltip: 'Logout',
//           onPressed: () {
//             // scaffoldKey.currentState.showSnackBar(snackBar);
//           },
//         ),
//       ],
//     ),

//     //   body:  _pages[_currentPage],
//   ),
// ),
// ],
//     ),
//    ),
//  );
