import 'package:ChatUI/admin/admin.dart';
import 'package:ChatUI/admin/bloc/admin_idea_state.dart';
import 'package:ChatUI/home/datas/active_data_store.dart';
import 'package:ChatUI/ideas/models/idea.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

///This class is the one that list ideas and delete ideas
class IdeaFragment extends StatelessWidget {
  bool isLoading = false;
  bool searchEntryIsVisible = true;
  TextEditingController ideaController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        title: TextField(
          controller: ideaController,
          onChanged: (username) {
            StaticDataStore.adminIdeaState.searchIdeas(username);
          },
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
            hintText: "  title here  .. ",
            alignLabelWithHint: true,
            helperMaxLines: 1,
          ),
        ),
        centerTitle: true,
        elevation: 0.0,
        actions: [IconButton(icon: Icon(Icons.search), onPressed: () {})],
      ),
      body: BlocBuilder<AdminIdeaState, List<Idea>>(
        builder: (_, ideas) {
          return ListView.builder(
            itemCount: ideas == null ? 0 : ideas.length,
            itemBuilder: (_, idx) {
              final idea = ideas[idx];
              
              return DeletableIdea(idea:idea);
            },
          );
        },
      ),
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
