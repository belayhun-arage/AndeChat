import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class CategorySelector extends StatefulWidget {
  final Function setTabName;

  CategorySelector({this.setTabName});
  @override
  _CategorySelectorState createState() => _CategorySelectorState();
}

class _CategorySelectorState extends State<CategorySelector> {
  int selecteIndex = 0;

  final Map<String, IconData> categories = {
    "Messages": Icons.message,
    "Online ": Icons.online_prediction,
    "Groups": Icons.group,
    "Requests": Icons.request_page
  };
  final List<String> categoryNames = [
    "Messages",
    "Online ",
    "Groups",
    "Requests",
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 90.0,
      color: Theme.of(context).primaryColor,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: categories.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              setState(() {
                this.selecteIndex = index;
                widget.setTabName(categoryNames[this.selecteIndex]);
              });
            },
            child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 20.0,
                  vertical: 20.0,
                ),
                child: Container(
                    child: Column(
                  children: [
                    Icon(
                      categories[(categoryNames[index])],
                      color:
                          index == selecteIndex ? Colors.white : Colors.white60,
                    ),
                    Text(
                      categoryNames[index],
                      style: TextStyle(
                        color: index == selecteIndex
                            ? Colors.white
                            : Colors.white60,
                        fontWeight: FontWeight.bold,
                        // fontStyle: FontStyle.italic,
                      ),
                    ),
                  ],
                ))),
          );
        },
      ),
    );
  }
}
