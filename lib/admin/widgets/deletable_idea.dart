import 'package:flutter/material.dart';

class DeletableIdea extends StatefulWidget {
  @override
  _DeletableIdeaState createState() => _DeletableIdeaState();
}

class _DeletableIdeaState extends State<DeletableIdea> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
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
                          width: 100,
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
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
  }
}