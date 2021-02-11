import 'package:flutter/material.dart';

class IdeaDescriptionText extends StatefulWidget {
  final String text;

  const IdeaDescriptionText({Key key, this.text}) : super(key: key);
  @override
  _IdeaDescriptionTextState createState() => _IdeaDescriptionTextState();
}

class _IdeaDescriptionTextState extends State<IdeaDescriptionText> {
  String firsthalf;
  String secondhalf;
  bool flag = true;

  @override
  void initState() {
    super.initState();

    if (widget.text.length > 50) {
      firsthalf = widget.text.substring(0, 50);
      secondhalf = widget.text.substring(50, widget.text.length);
    } else {
      firsthalf = widget.text;
      secondhalf = "";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: new EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
        child: secondhalf.isEmpty
            ? new Text(firsthalf)
            : new Column(
                children: <Widget>[
                  Text(flag ? (firsthalf + "...") : (firsthalf + secondhalf)),
                  InkWell(
                    child: new Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        new Text(
                          flag ? "show more" : "show less",
                          style: TextStyle(color: Colors.blue),
                        ),
                      ],
                    ),
                    onTap: () {
                      setState(() {
                        flag = !flag;
                      });
                    },
                  ),
                ],
              ),
      ),
    );
  }
}
