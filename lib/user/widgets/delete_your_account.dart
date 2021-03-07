import 'dart:io';

import 'package:ChatUI/home/datas/active_data_store.dart';
import 'package:ChatUI/home/handlers/updating_loop.dart';
import 'package:ChatUI/libs.dart';
import 'package:ChatUI/service/main_looping_service.dart';
import 'package:ChatUI/user/bloc/user_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:image_picker/image_picker.dart';

Future<File> ConfirmAccountDeletion(BuildContext context, String id) async {
  await showDialog(
    context: context,
    builder: (conta) {
      return Card(
        color: Colors.white,
        child: AlertDialog(
          title: Text(
            " Alert ",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          elevation: 25,
          actions: <Widget>[
            FlatButton(
              onPressed: () {
                Navigator.pop(conta);
              },
              child: Text(
                "Cancel",
                textAlign: TextAlign.justify,
                style: TextStyle(
                  backgroundColor: Theme.of(context).primaryColor,
                  color: Colors.white,
                ),
              ),
            ),
            FlatButton(
              onPressed: () async  {
                final success = await context.read<UserState>().deleteMyAccount();
                
                if (success) {
                  await context.read<UserState>().logout();
                  // Stop Services
                  UpdateData.onSyncController.close();
                  UpdateData.onSyncSearchController.close();
                  //Stop Loops
                  MainService.stopLoop = true;
                  // Close streams
                  WebSocketService.channel.sink
                      .close(WebSocketStatus.NORMAL_CLOSURE);

                  Navigator.of(context).pushNamedAndRemoveUntil(AuthScreen.Route,
                      (_) {
                    return false;
                  });
                }
                Navigator.pop(conta);
              },
              child: Text(
                "Yes",
                textAlign: TextAlign.justify,
                style: TextStyle(
                  backgroundColor: Theme.of(context).primaryColor,
                  color: Colors.white,
                ),
              ),
            )
          ],
          backgroundColor: Theme.of(context).primaryColor,
          contentPadding: EdgeInsets.all(20),
          titlePadding: EdgeInsets.all(10),
          content: Container(
            child: Text(" Are you sure do you want to delete your account ? "),
          ),
        ),
      );
    },
    barrierDismissible: true,
    useSafeArea: true,
  );
}
