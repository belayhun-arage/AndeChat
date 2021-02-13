import 'package:ChatUI/libs.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CategorySelector extends StatelessWidget {
  int selectedIndex;
  CategorySelector({this.selectedIndex}) {
    if (this.selectedIndex > 3) {
      this.selectedIndex = 0;
    }
  }

  final Map<String, IconData> categories = {
    "Home": Icons.home,
    "Messages": Icons.message,
    "Online ": Icons.online_prediction,
    "Groups": Icons.group,
  };
  final List<String> categoryNames = [
    "Home",
    "Messages",
    "Online ",
    "Groups",
  ];
  @override
  Widget build(BuildContext totalContext) {
    return Container(
      height: 90.0,
      color: Theme.of(totalContext).primaryColor,
      child: BlocBuilder<TabIndex, int>(
        builder: (context, val) {
          // Setting the Selected  index so that i can set the selected index to white ( Bold White  )
          this.selectedIndex = val;
          return ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: categories.length,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  this.selectedIndex = index;
                  switch (index) {
                    case 0:
                      {
                        totalContext.read<TabIndex>().add(TabChangeEvent.home);
                        break;
                      }
                    case 1:
                      {
                        totalContext
                            .read<TabIndex>()
                            .add(TabChangeEvent.messages);
                        break;
                      }
                    case 2:
                      {
                        totalContext
                            .read<TabIndex>()
                            .add(TabChangeEvent.online);
                        break;
                      }
                    case 3:
                      {
                        totalContext
                            .read<TabIndex>()
                            .add(TabChangeEvent.groups);
                        break;
                      }
                  }
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
                          color: index == val
                              ? Colors.white
                              : Colors.white60,
                        ),
                        Text(
                          categoryNames[index],
                          style: TextStyle(
                            color: index == val 
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
          );
        },
      ),
    );
  }
}
