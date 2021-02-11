import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class CreateIdea extends StatefulWidget {
  static const String Route = "/create";
  @override
  _CreateIdeaState createState() => _CreateIdeaState();
}

class _CreateIdeaState extends State<CreateIdea> {
  File _image;
  final picker = ImagePicker();

  Future getImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.camera);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }

  _goBack(BuildContext context) {
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          iconSize: 20.0,
          onPressed: () {
            _goBack(context);
          },
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 50.0, vertical: 40.0),
        child: Column(
          children: <Widget>[
            TextFormField(
              decoration: InputDecoration(labelText: 'Enter  title'),
            ),
            SizedBox(
              height: 20.0,
            ),
            TextFormField(
              decoration: InputDecoration(labelText: 'Enter description'),
            ),
            SizedBox(
              height: 40.0,
            ),
            Stack(
              children: <Widget>[
                Container(
                  // decoration: new BoxDecoration(color: Colors.white),
                  alignment: Alignment.center,
                  height: 100,

                  child: _image == null
                      ? Image.asset("assets/images/john.jpg")
                      : Image.file(_image, fit: BoxFit.fill),
                ),
                Positioned(
                  bottom: 10,
                  right: 80, //give the values according to your requirement
                  child: IconButton(
                    icon: Icon(
                      Icons.add_a_photo,
                      size: 60.0,
                    ),
                    onPressed: () {
                      getImage();
                    },
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 40.0,
            ),
            FlatButton(
              minWidth: 200.0,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18.0)),
              color: Colors.deepOrange,
              child: Text(
                "Submit",
                style: TextStyle(color: Colors.white),
              ),
              onPressed: () {},
            ),
          ],
        ),
      ),
    );
  }
}
