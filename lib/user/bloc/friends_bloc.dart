import 'package:ChatUI/libs.dart';
import 'package:ChatUI/user/repository/user_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FriendsState extends Cubit<List<Alie>> {
  UserRepository repository;
  static FriendsState _instance;
  FriendsState(UserRepository repository) : super([]) {
    this.repository = repository;
    _instance = this;
  }

  static FriendsState getInstance() {
    if (_instance == null) {
      _instance = FriendsState(UserRepository());
    }
    return _instance;
  }

  void updateFriendsState(List<Alie> friendsState) async {
    if (friendsState != null) {
      emit(friendsState);
    }
  }

  void fetchMyAlies() async {
    final friends = await repository.getMyFriends();
    if (friends != null) {
      emit(friends);
    }
  }

  void addFriend(Alie newFriend) {
    List<Alie> alioo = [...state, newFriend];
    emit(alioo);
  }
}
