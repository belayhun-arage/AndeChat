import 'dart:io';

import 'package:ChatUI/libs.dart';
import 'package:ChatUI/user/repository/user_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UserState extends Cubit<Alie> {
  static UserState _instance;
  UserState({this.repo})
      : assert(repo != null),
        super(null) {
    if (_instance == null) {
      _instance == this;
    }
  }

  static UserState get instance {
    return _instance;
  }

  UserRepository repo;
  updateUser(Alie user) {
    emit(user);
  }

  Future<LoginRes> loginUser(String email, String password) {
    return this.repo.logUserIn(email, password);
  }

  /// register taking an input RegistrationInput
  Future<RegistrationRes> register(RegistrationInput input) {
    return this.repo.registerUser(input);
  }

  void getMyProfile() async {
    final user = await this.repo.getMyProfile();
    if (user != null) {
      emit(user);
    }
  }

  Future<Alie> updateMyProfile(String username,String bio) async  {
    final alie = await this.repo.updateMyProfile(username  , bio );
  }
}
