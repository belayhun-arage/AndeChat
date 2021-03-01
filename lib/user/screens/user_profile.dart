import 'package:ChatUI/libs.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChangeProfile extends StatelessWidget {
  static const String RouteName = "/editProfile";
  @override
  Widget build(BuildContext context) {
    UserState userState = BlocProvider.of<UserState>(context);
    TextEditingController usernameController = new TextEditingController();
    TextEditingController bioController = new TextEditingController();

    String message = "  Edit Your Profile ";
    return Scaffold(
      appBar: AppBar(
        title: Text(" Change Your Profile "),
      ),
      drawer: MyNavigation(),
      body: Container(
        child: Column(
          children: <Widget>[
            Container(
              child: Padding(
                padding: EdgeInsets.fromLTRB(30, 50, 30, 30),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Container(
                      height: 30,
                      width: 50,
                      child: IconButton(
                        onPressed: () {
                          // Navigator.pop(context);
                        },
                        icon: Icon(
                          Icons.arrow_back_ios,
                        ),
                        iconSize: 24,
                        color: Colors.black54,
                      ),
                    ),
                    Text(
                      '$message',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white70,
                      ),
                    ),
                    Container(height: 24, width: 90)
                  ],
                ),
              ),
            ),
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
                    child: Column(
                      children: [
                        Stack(
                          children: <Widget>[
                            CircleAvatar(
                              radius: 70,
                              child: ClipOval(
                                child: Image.asset(
                                  'images/img.jpg',
                                  height: 150,
                                  width: 150,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            IconButton(
                              icon: Icon(Icons.add_a_photo),
                              onPressed: () async {
                                final image = await pickImage(context);
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Flexible(
              child: Expanded(
                child: Container(
                  child: Column(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.fromLTRB(20, 25, 20, 4),
                        child: Container(
                          height: 80,
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: TextField(
                                decoration:
                                    InputDecoration(labelText: 'Username'),
                                controller: usernameController,
                                // onChanged: (value) => title = value,
                              ),
                            ),
                          ),
                          decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20)),
                              border: Border.all(
                                  width: 1.0, color: Colors.white70)),
                        ),
                      ),
                      Flexible(
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(20, 5, 20, 4),
                          child: Container(
                            height: 80,
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: TextField(
                                  decoration: InputDecoration(labelText: 'Bio'),
                                  // onChanged: (value) => title = value,
                                  controller: bioController,
                                ),
                              ),
                            ),
                            decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20)),
                                border: Border.all(
                                    width: 1.0, color: Colors.white70)),
                          ),
                        ),
                      ),
                      Expanded(
                        child: GestureDetector(
                          child: Align(
                            alignment: Alignment.bottomRight,
                            child: Container(
                              height: 70,
                              width: 200,
                              child: Align(
                                child: Text(
                                  'Save',
                                  style: TextStyle(
                                      color: Colors.white70, fontSize: 20),
                                ),
                              ),
                              decoration: BoxDecoration(
                                  color: Colors.deepOrange,
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(30),
                                  )),
                            ),
                          ),
                          onTap: () async {
                            final alie = await userState.updateMyProfile(
                                usernameController.text, bioController.text);
                            userState.updateUser(alie);
                          },
                        ),
                      )
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
