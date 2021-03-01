import 'package:ChatUI/admin/bloc/admin_state_bloc.dart';
import 'package:ChatUI/libs.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AdminPage extends StatefulWidget {
  static const RouteName = '/adminpage';
  AdminPage({Key key, this.title}) : super(key: key);

  final String title;

  final drawerItems = [
    new DrawerItem("Ideas ", Icons.person_add),
    new DrawerItem("Search User", Icons.search),
    new DrawerItem("Add Admin", Icons.person_add),
    new DrawerItem("Logout", Icons.logout),
  ];

  @override
  _AdminPageState createState() => _AdminPageState();
}

class _AdminPageState extends State<AdminPage> {
  int _selectedDrawerIndex = 0;
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
    IdeaBloc ideaBloc = BlocProvider.of<IdeaBloc>(context);
    ideaBloc.add(IdeaLoadMoney());

    List<Widget> drawerOptions = [];
    for (var i = 0; i < widget.drawerItems.length; i++) {
      var d = widget.drawerItems[i];
      drawerOptions.add(
        new ListTile(
          leading: new Icon(d.icon),
          title: new Text(d.title),
          selected: i == _selectedDrawerIndex,
          onTap: () => _onSelectItem(i),
        ),
      );
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
              BlocBuilder<AdminState, Admin>(
                builder: (context, admin) {
                  return UserAccountsDrawerHeader(
                    accountEmail: new Text(admin.email),
                    accountName: new Text(admin.username),
                    currentAccountPicture: new GestureDetector(
                      child: new CircleAvatar(
                        backgroundImage: new NetworkImage(
                            'https://images.unsplash.com/photo-1614359499552-2440ac739eeb?ixid=MXwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=750&q=80'),
                      ),
                      onTap: () => print("This is your current account."),
                    ),
                  );
                },
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
