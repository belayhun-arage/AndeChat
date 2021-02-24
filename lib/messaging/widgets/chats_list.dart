import 'package:ChatUI/libs.dart';
import 'package:flutter/material.dart';

class Chats extends StatelessWidget {
  final String filesPath;
  final bool searchInProgress;
  final bool searching;
  Chats({this.filesPath, this.searchInProgress , this.searching});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).accentColor,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        // padding: EdgeInsets.all(10.0),
        child: Column(
          children: [
            // FavouriteContact(),
            searchInProgress
                ? Column(
                    children: [
                      SizedBox(
                        height: 50,
                      ),
                      Center(
                        child: CircularProgressIndicator(
                          backgroundColor: Theme.of(context).primaryColor,
                        ),
                      )
                    ],
                  )
                : searching
                    ? (StaticDataStore.searchResultUsers.length > 0
                        ? SearchResult(
                            filesPath: filesPath,
                          )
                        : Column(
                            children: [
                              SizedBox(
                                height: 50,
                              ),
                              Center(
                                child: Center(
                                  child: Text(
                                    " No Result Found ... ",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20,
                                      fontStyle: FontStyle.italic,
                                      color: Colors.black54,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ))
                    : RecentChats(
                        filesPath: filesPath,
                      ),
          ],
        ),
      ),
    );
  }
}
