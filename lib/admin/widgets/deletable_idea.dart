import 'package:ChatUI/admin/bloc/admin_idea_state.dart';
import 'package:ChatUI/home/datas/datas.dart';
import 'package:ChatUI/ideas/models/idea.dart';
import 'package:ChatUI/ideas/widgets/ideadescription.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DeletableIdea extends StatefulWidget {
  final Idea idea;

  DeletableIdea({@required this.idea});
  @override
  _DeletableIdeaState createState() => _DeletableIdeaState();
}

class _DeletableIdeaState extends State<DeletableIdea> {
  @override
  Widget build(BuildContext context) {
    AdminIdeaState adminIdeaState = BlocProvider.of<AdminIdeaState>(context);
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
                    Container(
                      width: MediaQuery.of(context).size.width * 0.5,
                      child: Text(
                        widget.idea.owner == null
                            ? widget.idea.ownerid
                            : widget.idea.owner.username,
                        style: TextStyle(fontSize: 16.0),
                      ),
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(50),
                      child: Container(
                        color: Theme.of(context).primaryColor,
                        child: IconButton(
                          color: Theme.of(context).primaryColor,
                          icon: Icon(
                            Icons.delete,
                            color: Colors.white,
                          ),
                          onPressed: () {
                            adminIdeaState.deleteIdea(widget.idea.id);
                          },
                        ),
                      ),
                    ),
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
                child: widget.idea != null
                    ? widget.idea.image == ""
                        ? SizedBox()
                        : Image.network(
                            StaticDataStore.HOST + (widget.idea.image ?? ""),
                          )
                    : SizedBox(),
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
                          Text(
                            '${widget.idea.title}',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          // FittedBox(
                          Row(
                            children: <Widget>[
                              Container(
                                width: MediaQuery.of(context).size.width * 0.75,
                                child: IdeaDescriptionText(
                                    text: "${widget.idea.description}"),
                              ),
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
