import 'package:ChatUI/libs.dart';
import 'package:ChatUI/messaging/bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// ShowMessagePopup is a method to show a pop up containing delete and related Functionality for a
/// sinlgle message
void ShowMessagePopup(BuildContext context, String friendId, int messanumber) {
  InteractiveUser interactiveMan = BlocProvider.of<InteractiveUser>(context);
  StaticDataStore.interactingUser = interactiveMan;
  showDialog(
    context: context,
    builder: (conta) {
      return AlertDialog(
        elevation: 25,
        backgroundColor: Colors.white,
        contentPadding: EdgeInsets.all(20),
        titlePadding: EdgeInsets.all(10),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            GestureDetector(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Delete",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Icon(
                    Icons.delete,
                    color: Colors.red,
                  ),
                ],
              ),
              onTap: () {
                interactiveMan.add(new MessageDelete(friendId, messanumber));
                Navigator.pop(context);
              },
            ),
            Container(
              color: Colors.black,
              child: SizedBox(),
            ),
          ],
        ),
      );
    },
    barrierDismissible: true,
    useSafeArea: true,
  );
}
