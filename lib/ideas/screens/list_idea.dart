import 'package:ChatUI/ideas/data_provider/data_provider.dart';
import 'package:ChatUI/ideas/models/models.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

class ListIdea extends StatefulWidget {
  static const routeName = '/';
  // final Idea idea;
  //static const routeName = '/';
  @override
  _ListIdeaState createState() => _ListIdeaState();
}

class _ListIdeaState extends State<ListIdea> {
  Future<List<Idea>> futureAlbum;

  @override
  void initState() {
    super.initState();
    // futureAlbum = IdeaDataProvider().getIdeas();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('List of ideas'),
      ),
      body: Center(
        child: FutureBuilder<List<Idea>>(
          future: futureAlbum,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                  itemCount: snapshot.data.length,
                  itemBuilder: (context, index) {
                    var item = snapshot.data[index];
                    return Text(item.description);
                  });
            }

            // By default, show a loading spinner.
            return CircularProgressIndicator();
          },
        ),
      ),

      // ),
    );

    // BlocBuilder<IdeaBloc, IdeaState>(
    //   builder: (_, state) {
    //     if (state is IdeaOperationFailure) {
    //       return Text('Could not do idea operation');
    //     }

    //     if (state is IdeaLoadSuccess) {
    //       print("ere love");
    //       final courses = state.ideass;

    //       return ListView.builder(
    //         itemCount: courses.length,
    //         itemBuilder: (_, idx) => ListTile(
    //           title: Text('{courses[idx].title}'),
    //           subtitle: Text('{courses[idx].description}'),
    //           // onTap: () => Navigator.of(context)
    //           //     .pushNamed(CourseDetail.routeName, arguments: courses[idx]),
    //         ),
    //       );
    //     } else {
    //       print("what the heack");
    //     }

    //     return CircularProgressIndicator();
    //   },
    // ),
    // floatingActionButton: FloatingActionButton(
    //   onPressed: () => Navigator.of(context).pushNamed(
    //     AddUpdateCourse.routeName,
    //     arguments: CourseArgument(edit: false),
    //   ),
    //   child: Icon(Icons.add),
    // ),
    //);
  }
}
