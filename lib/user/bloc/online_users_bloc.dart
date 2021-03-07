import 'package:ChatUI/user/repository/user_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


enum OnlineEvents {
  One  , 
  Two  ,
}
/// OnlineFriends bloc holds the ID of online friends
/// this list of string(List of ID ) will be used
/// in the Active users Tab in the home page to list active users.
/// 
/// 
class OnlineFriends extends Bloc<OnlineEvents  , List<String> > implements Cubit<List<String>> {
  UserRepository repository;
  static OnlineFriends _instance;
  OnlineFriends(UserRepository repository) : super([]) {
    this.repository = repository;
    _instance = this;
  }
  static OnlineFriends get instance {
    if (_instance == null) {
      _instance = OnlineFriends(UserRepository());
    }
    return _instance;
  }

  void updateOnlineFriends(List<String> onlineFriends) async {
    if (onlineFriends == null  || onlineFriends==[] ) {
      print("   Not Updating ....   ");
      return;
    }
    print("   Emiittedd   $onlineFriends  ");
    emit(onlineFriends);
  }

  @override
  Stream<List<String>> mapEventToState(OnlineEvents event) {
    // TODO: implement mapEventToState
    throw UnimplementedError();
  }
}
