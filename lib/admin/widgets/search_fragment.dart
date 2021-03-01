import 'package:flutter/material.dart';
///This class gives the privilege to the admin to search and delete users
class SearchFragment extends StatelessWidget {
  bool isLoading = false;
  bool searchEntryIsVisible = true;
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Scaffold(
      appBar: AppBar(
        title: TextField(
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
            hintText: "    Type Username .. ",
            alignLabelWithHint: true,
            helperMaxLines: 1,
          ),
          // controller: searchController,
          // onChanged: (String value) {
          //   this.searchUsers(value);
          //   if (value.length > 0) {
          //     setState(() {
          //       searching = true;
          //     });
          //   } else {
          //     setState(() {
          //       searching = false;
          //     });
          //   }
          // },
        ),
        centerTitle: true,
        elevation: 0.0,
        actions: [IconButton(icon: Icon(Icons.search), onPressed: () {})],
      ),
    );
  }
}
