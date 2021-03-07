import 'package:ChatUI/libs.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

///This class gives the privilege to the admin to search and delete users
class SearchFragment extends StatelessWidget {
  bool isLoading = false;
  bool searchEntryIsVisible = true;
  TextEditingController usernameController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    StaticDataStore.adminUsersState = BlocProvider.of<AdminUsersState>(context);
    return new Scaffold(
      appBar: AppBar(
        title: TextField(
          controller: usernameController,
          onChanged: (username) {
            StaticDataStore.adminUsersState.searchUsers(username);
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
            hintText: "  Type Username .. ",
            alignLabelWithHint: true,
            helperMaxLines: 1,
          ),
        ),
        centerTitle: true,
        elevation: 0.0,
        actions: [IconButton(icon: Icon(Icons.search), onPressed: () {})],
      ),
      body: Column(
        children: [
          Expanded(
            child: BlocBuilder<AdminUsersState, List<Alie>>(
              builder: (_, users) {
                if (users == null || users.length == 0) {
                  return Center(
                    child: isLoading
                        ? CircularProgressIndicator(
                            backgroundColor: Theme.of(context).primaryColor,
                          )
                        : Text(
                            "    No Users Found ...",
                            style: TextStyle(
                              color: Colors.red,
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                            ),
                          ),
                  );
                }
                return ListView.builder(
                  itemCount: users.length,
                  itemBuilder: (context, val) {
                    final user = users[val];
                    return ListTile(
                      tileColor: Colors.white30,
                      leading: ClipRRect(
                        borderRadius: BorderRadius.all(
                          Radius.circular(80),
                        ),
                        child: user.imageUrl != ""
                            ? Image.network(
                                StaticDataStore.HOST + user.imageUrl)
                            : Image.asset("assets/sam.jpg"),
                      ),
                      title: Text("${user.username}"),
                      subtitle: Text("${user.email}"),
                      trailing: IconButton(
                        icon: Icon(
                          Icons.delete,
                          color: Colors.red,
                        ),
                        onPressed: () {
                          StaticDataStore.adminUsersState
                              .deleteUserByID(user.id);
                        },
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
