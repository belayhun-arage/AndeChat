import 'package:ChatUI/libs.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OnlineFriends extends Cubit<List<String>> {
  OnlineFriends() : super([]);


  static OnlineFriends _instance;
  static OnlineFriends get instance {
    return _instance == null
        ? () {
            _instance = OnlineFriends();
            return _instance;
          }
        : _instance;
  }

  void updateOnlineFriends(List<String> onlineFriends) async {
    emit(onlineFriends);
  }
}
