import 'dart:io';

import 'package:ChatUI/ideas/bloc/bloc.dart';
import 'package:ChatUI/ideas/models/models.dart';

import 'package:ChatUI/ideas/screens/screens.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

import 'idea_rout.dart';

class CreateIdea extends StatefulWidget {
  final CourseArgument args;
  // final CourseArgument args = ModalRoute.of(context).settings.arguments;

  CreateIdea({this.args});
  static const String Route = "/create";
  @override
  _CreateIdeaState createState() => _CreateIdeaState();
}

class _CreateIdeaState extends State<CreateIdea> {
  final _formKey = GlobalKey<FormState>();
  //final server = IdeaDataProvider();
  final Map<String, dynamic> _idea = {};

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
    // final CourseArgument args = ModalRoute.of(context).settings.arguments;
    MyIdeaBloc myideas = BlocProvider.of<MyIdeaBloc>(context);
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      appBar: AppBar(
        title: Text('${widget.args.edit ? "update idea" : "add new idea"}'),
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
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              TextFormField(
                  initialValue: widget.args.edit ? widget.args.idea.title : '',
                  decoration: InputDecoration(labelText: 'Enter  title'),
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Please enter idea title';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    setState(() {
                      this._idea["title"] = value;
                      print(value);
                    });
                  }),
              //  ),
              SizedBox(
                height: 20.0,
              ),
              TextFormField(
                  initialValue:
                      widget.args.edit ? widget.args.idea.description : '',
                  decoration: InputDecoration(labelText: 'Enter description'),
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Please enter idea discription';
                    }
                    return null;
                  },
                  maxLines: 3,
                  onSaved: (value) {
                    setState(() {
                      this._idea["description"] = value;
                      print(value);
                    });
                  }),
              SizedBox(
                height: 40.0,
              ),
              // Stack(
              //   children: <Widget>[
              //     // Container(
              //     //   // decoration: new BoxDecoration(color: Colors.white),
              //     //   alignment: Alignment.center,
              //     //   height: 100,

              //     //   child: _image == null
              //     //       ? Image.asset("assets/images/john.jpg")
              //     //       : Image.file(_image, fit: BoxFit.fill),
              //     // ),
              //     Positioned(
              //       bottom: 10,
              //       right: 80, //give the values according to your requirement
              //       child: IconButton(
              //         icon: Icon(
              //           Icons.add_a_photo,
              //           size: 60.0,
              //         ),
              //         onPressed: () {
              //           getImage();
              //         },
              //       ),
              //     ),
              //   ],
              // ),
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
                onPressed: () {
                  final form = _formKey.currentState;
                  if (form.validate()) {
                    form.save();

                    final IdeaEvent event = widget.args.edit
                        ? IdeaUpdate(
                            Idea(
                              id: widget.args.idea.id,
                              title: this._idea["title"],
                              description: this._idea["description"],
                            ),
                          )
                        : IdeaCreate(
                            Idea(
                              title: this._idea["title"],
                              description: this._idea["description"],
                            ),
                          );
                    myideas.add(event);
                    Navigator.of(context).pop();
                    Navigator.of(context).pop();
                    Navigator.of(context)
                        .pushNamed(IdeaList.routeName, );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
