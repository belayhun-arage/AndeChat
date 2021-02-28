import 'package:ChatUI/user/repository/user_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


/// OnlineFriends bloc holds the ID of online friends 
/// this list of string(List of ID ) will be used 
/// in the Active users Tab in the home page to list active users.
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
