// import 'package:ChatUI/libs.dart';
import 'package:ChatUI/user/repository/user_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OnlineFriends extends Cubit<List<String>> {
  UserRepository repository;
  static OnlineFriends _instance;
  OnlineFriends(UserRepository repository) : super([]) {
    this.repository = repository;
    _instance = this;
  }
  static OnlineFriends get instance {
    return _instance;
  }

  void updateOnlineFriends(List<String> onlineFriends) async {
    emit(onlineFriends);
  }
  
}
