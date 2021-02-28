import 'package:flutter/material.dart';

class AdminPage extends StatefulWidget {
  static const String RouteName="/adminPage";
  AdminPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _AdminPageState createState() => _AdminPageState();
}

class _AdminPageState extends State<AdminPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: <Widget>[
          Container(
            color: Color(0xff2A3F54),
            width: 150,
            child: Drawer(
              child: Container(
                color: Color(0xff2A3F54),
                child: ListView(
                  children: <Widget>[
                    DrawerHeader(
                      //padding: EdgeInsets.zero,
                      padding: EdgeInsets.symmetric(
                          vertical: 15.0, horizontal: 15.0),
                      child: Column(
                        children: <Widget>[
                          Row(
                            children: <Widget>[
                              SizedBox(
                                height: 130,
                              ),
                              ClipRRect(
                                  borderRadius: BorderRadius.circular(25.0),
                                  child: Image.asset(
                                    'images/person3.jpeg',
                                    width: 40,
                                  )),
                              SizedBox(
                                width: 20,
                              ),
                              Flexible(
                                child: Stack(
                                  children: <Widget>[
                                    Row(
                                      children: <Widget>[
                                        Text('Welcolme',
                                            style: TextStyle(
                                                fontSize: 13,
                                                color: Color(0xffBAB8B8))),
                                      ],
                                    ),
                                    Row(
                                      children: <Widget>[
                                        SizedBox(
                                          height: 48,
                                        ),
                                        Text(
                                          'Fani Man',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: Color(0xffECF0F1)),
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              )
                            ],
                          ),
                        ],
                      ),
                      decoration: BoxDecoration(
                        color: Color(0xff2A3F54),
                      ),
                    ),
                    ListTile(
                      leading: const Icon(
                        Icons.search,
                        color: Color(0xffE7E7E7),
                      ),
                      title: Text(
                        'Search',
                        style: TextStyle(
                          color: Color(0xffE7E7E7),
                          fontSize: 14,
                        ),
                      ),
                      onTap: () {
//                      HomePage();
                        setState(() {
                          //_currentPage = 0;
                        });
                      },
                    ),
                    ListTile(
                      leading: const Icon(Icons.person_remove,
                          color: Color(0xffE7E7E7)),
                      title: Text('Remove User',
                          style: TextStyle(
                            color: Color(0xffE7E7E7),
                            fontSize: 14,
                          )),
                      onTap: () {
//                      HomePage();
                        setState(() {
                          //  _currentPage = 1;
                        });
                      },
                    ),
                    ListTile(
                      leading: const Icon(Icons.person_add,
                          color: Color(0xffE7E7E7)),
                      title: Text('Add User',
                          style: TextStyle(
                            color: Color(0xffE7E7E7),
                            fontSize: 14,
                          )),
                      onTap: () {
//                      HomePage();
                        setState(() {
                          //  _currentPage = 1;
                        });
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
          Expanded(
            child: Scaffold(
              appBar: AppBar(
                automaticallyImplyLeading:
                    MediaQuery.of(context).size.width < 600,
                title: Text('AdminPage'),
                actions: <Widget>[
                  IconButton(
                    icon: const Icon(
                      Icons.exit_to_app,
                      color: Color(0xff2A3F54),
                    ),
                    tooltip: 'Logout',
                    onPressed: () {
                      // scaffoldKey.currentState.showSnackBar(snackBar);
                    },
                  ),
                ],
              ),

              //   body:  _pages[_currentPage],
            ),
          ),
        ],
      ),
    );
  }
}
