import 'package:ChatUI/ideas/bloc/bloc.dart';
import 'package:ChatUI/ideas/models/models.dart';
import 'package:ChatUI/ideas/screens/idea_rout.dart';
import 'package:ChatUI/ideas/screens/screens.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../styleguide.dart';

class IdeaDetail extends StatelessWidget {
  static const routeName = 'ideaDetail';
  final Idea idea;

  const IdeaDetail({Key key, this.idea}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // title: Text('${this.idea.title}'),
        actions: [
          IconButton(
            icon: Icon(Icons.edit),
            onPressed: () => Navigator.of(context).pushNamed(
              CreateIdea.Route,
              arguments: CourseArgument(idea: this.idea, edit: true),
            ),
          ),
          SizedBox(
            width: 32,
          ),
          IconButton(
              icon: Icon(Icons.delete),
              onPressed: () {
                context.read<IdeaBloc>().add(IdeaDelete(this.idea));
                Navigator.of(context).pushNamedAndRemoveUntil(
                    IdeaList.routeName, (route) => false);
              }),
        ],
      ),
      body: Card(
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
                SizedBox(
                  height: 60.0,
                ),
                Text(
                  "Title",
                  style: eventTitleTextStyle,
                ),
                SizedBox(height: 15.0),
                Text('${this.idea.title}'),
                SizedBox(
                  height: 20.0,
                ),
                Text(
                  "description",
                  style: eventTitleTextStyle,
                ),
                SizedBox(height: 15.0),
                Text('${this.idea.description}')
              ]

              // child: Column(
              //   children: [
              //     ListTile(
              //       title: Text('Title: ${this.idea.title}'),
              //       subtitle: Text('ECTS: ${this.idea.description}'),
              //     ),
              //     Text(
              //       'Details',
              //       style: TextStyle(
              //         fontSize: 18,
              //         fontWeight: FontWeight.bold,
              //       ),
              //     ),
              //     SizedBox(
              //       height: 10,
              //     ),
              //     Text(this.idea.description),
              //   ],
              // ),
              ),
        ),
      ),
    );
  }
}
