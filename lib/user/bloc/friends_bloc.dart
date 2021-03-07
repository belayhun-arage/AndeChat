import 'package:ChatUI/libs.dart';
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
      friendsState.removeWhere((ale) {
        return StaticDataStore.ID == ale.id;
      });
      friendsState.add(StaticDataStore.userState.state);
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

  void updateThisFriend(Alie alie) async {
    final newMap = this.state.map<Alie>((al) {
      if (al.id == alie.id) {
        return alie;
      }
      return al;
    }).toList();

    if (newMap != null) {
      emit(newMap);
    }
  }

  void updateFriends() async {
    // while (true) {
    Future.delayed(Duration(seconds: 5), () {
      List<Alie> friends = [];
      for (int a = 0; a < this.state.length; a++) {
        Alie ali = this.state[a];
        ali.unreadMessages = 0;
        for (int m = 0; m < ali.messages.length; m++) {
          final mes = ali.messages[m];
          if (mes.receiverID == StaticDataStore.ID && mes.seen == false) {
            ali.unreadMessages++;
          }
        }
        friends.add(ali);
      }
      emit(friends);
    });
  }
}
