import 'package:ChatUI/libs.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MyAdminState extends Cubit<List<Alie>> {
  static MyAdminState _instance;
  MyAdminState({this.repo}) : super(List<Alie>()) {
    if (_instance == null) {
      _instance == this;
    }
  }

  static MyAdminState get instance {
    return _instance;
  }

  AdminUserRepository repo;
  updateUser(List<Alie> users) {
    emit(users);
  }

  Future<void> searchUsers(String username) async {
    final users = await this.repo.searchUsers(username);
    if (users != null) {
      emit(users);
    }
    return;
  }

  Future<void> deleteUserByID(String userid) async {
    final success = await this.repo.deleteUserByID(userid);
    if (success) {
      List<Alie> alies = this.state;
      alies.removeWhere((ali) {
        if (ali.id == userid) {
          return true;
        }
        return false;
      });
      emit(alies);
    }
  }
}
