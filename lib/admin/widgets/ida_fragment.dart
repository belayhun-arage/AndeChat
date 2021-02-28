import 'package:flutter/material.dart';

class IdeaFragment extends StatelessWidget {
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
