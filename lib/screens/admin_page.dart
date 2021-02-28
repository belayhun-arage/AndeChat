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

class FirstFragment extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Scaffold(
      // child: new Text("Search For User"),
      /*
import 'package:MyIdeas/ideas/bloc/bloc.dart';
import 'package:MyIdeas/ideas/screens/screens.dart';
import 'package:MyIdeas/ideas/widgets/widgets.dart';
import 'package:MyIdeas/styleguide.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'idea_rout.dart';

class IdeaList extends StatelessWidget {
  static const routeName = '/';

  @override
  Widget build(BuildContext context) {
    return Scaffold(   */
      // appBar: AppBar(
      //   title: Text('List of ideas')

      // ),
      // body: BlocBuilder<IdeaBloc, IdeaState>(
      //   builder: (_, state) {
      //     if (state is IdeaOperationFailure) {
      //       return Text('Could not do idea operation');
      //     }

      //     if (state is IdeaLoadSuccess) {
      //       // print("ere love");
      //       final courses = state.ideass;

      body: ListView.builder(
        //    itemCount: courses.length,
        itemBuilder: (_, idx) => GestureDetector(
          // onTap: () => Navigator.of(context)
          //     .pushNamed(IdeaDetail.routeName, arguments: courses[idx]),
          child: Card(
            margin: const EdgeInsets.symmetric(vertical: 20),
            elevation: 4,
            color: Colors.white,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(24))),
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Container(
                    child: Row(
                      children: [
                        CircleAvatar(
                          radius: 24,
                          backgroundImage: AssetImage("assets/images/john.jpg"),
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        Text(
                          "Mekdes Genetu",
                          style: TextStyle(fontSize: 16.0),
                        ),
                        SizedBox(
                          width: 160,
                        ),
                        Icon(Icons.delete),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  ClipRRect(
                    borderRadius: BorderRadius.all(
                      Radius.circular(30),
                    ),
                    child: Image.asset(
                      "assets/images/greg.jpg",
                      height: 120,
                      fit: BoxFit.fitWidth,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0, left: 8.0),
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          flex: 3,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(''

                                  //'${courses[idx].title}',
                                  //style: eventTitleTextStyle,
                                  ),
                              SizedBox(
                                height: 10,
                              ),
                              // FittedBox(
                              Row(
                                children: <Widget>[
                                  Icon(Icons.more_horiz),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  // Flexible(
                                  // child: IdeaDescriptionText(
                                  //   text: '${courses[idx].description}',

                                  // style: eventLocationTextStyle,
                                  // ),
                                  //  ),
                                ],
                              ),
                              // ),
                              SizedBox(
                                height: 20.0,
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 80.0),
                                child: Row(
                                  children: [
                                    Icon(
                                      Icons.thumb_up,
                                      color: Colors.blue,
                                    ),
                                    Text("1k"),
                                    SizedBox(
                                      width: 50.0,
                                    ),
                                    Icon(
                                      Icons.thumb_down,
                                    ),
                                    Text("219"),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        // Expanded(
                        //   flex: 1,
                        //   child: Text(
                        //     event.duration.toUpperCase(),
                        //     textAlign: TextAlign.right,
                        //     style: eventLocationTextStyle.copyWith(
                        //       fontWeight: FontWeight.w900,
                        //     ),
                        //  ),
                        // ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            // title: Text('${courses[idx].title}'),
            //subtitle: Text('${courses[idx].description}'),
            // onTap: () => Navigator.of(context)
            //     .pushNamed(CourseDetail.routeName, arguments: courses[idx]),
          ),
        ),
      ),

      // floatingActionButton: FloatingActionButton(
      //   // onPressed: () => Navigator.of(context).pushNamed(
      //   //   CreateIdea.Route,
      //   //   arguments: CourseArgument(edit: false),
      //   // ),
      //   child: Icon(Icons.add),
      // ),
    );
  }
}

Widget _buildPopupDialog(BuildContext context) {
  return new AlertDialog(
    title: const Text('Popup example'),
    content: new Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text("Hello"),
      ],
    ),
    actions: <Widget>[
      new FlatButton(
        onPressed: () {
          Navigator.of(context).pop();
        },
        textColor: Theme.of(context).primaryColor,
        child: const Text('Close'),
      ),
    ],
  );
}

class SecondFragment extends StatelessWidget {
  bool isLoading = false;
  bool searchEntryIsVisible = true;
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Scaffold(
      appBar: AppBar(
        title: TextField(
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
          // controller: searchController,
          // onChanged: (String value) {
          //   this.searchUsers(value);
          //   if (value.length > 0) {
          //     setState(() {
          //       searching = true;
          //     });
          //   } else {
          //     setState(() {
          //       searching = false;
          //     });
          //   }
          // },
        ),
        centerTitle: true,
        elevation: 0.0,
        actions: [IconButton(icon: Icon(Icons.search), onPressed: () {})],
      ),
    );
  }
}

class ThirdFragment extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Scaffold(
        // child: new Text("You Add User "),
        // appBar: AppBar(
        //   title: Text("Create Admin"),
        //   centerTitle: true,
        // ),
        body: Container(
            padding: EdgeInsets.symmetric(vertical: 25),
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.all(0),
                  height: 80,
                  child: Card(
                    child: Expanded(
                      child: Container(
                        padding: EdgeInsets.all(5),
                        child: TextField(
                          decoration: InputDecoration(
                              labelText: "UserName",
                              hintText: "Enter Admin Name"),
                        ),
                      ),
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(0),
                  height: 80,
                  child: Card(
                    child: Expanded(
                      child: Container(
                        padding: EdgeInsets.all(5),
                        child: TextField(
                          decoration: InputDecoration(
                              labelText: "Email", hintText: "Enter the Email"),
                        ),
                      ),
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(0),
                  height: 80,
                  child: Card(
                    child: Expanded(
                      child: Container(
                        padding: EdgeInsets.all(5),
                        child: TextField(
                          decoration: InputDecoration(
                              labelText: "Password",
                              hintText: "Enter the password"),
                        ),
                      ),
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(0),
                  height: 80,
                  child: Card(
                    child: Expanded(
                      child: Container(
                        padding: EdgeInsets.all(5),
                        child: TextField(
                          decoration: InputDecoration(
                              labelText: "Confirm Password",
                              hintText: "confirm the password"),
                        ),
                      ),
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.all(25),
                  child: FlatButton(
                    child: Text(
                      'Add',
                      style: TextStyle(fontSize: 20.0),
                    ),
                    color: Colors.orange,
                    textColor: Colors.black,
                    onPressed: () {},
                  ),
                ),
              ],
            )));
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
