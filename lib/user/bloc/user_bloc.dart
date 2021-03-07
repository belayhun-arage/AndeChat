import 'dart:io';

import 'package:ChatUI/libs.dart';
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

  Future<Alie> getLoggedInUser() async {
    final user = await this.repo.getLoggedInUser();
    return user;
  }

  Future<LoginRes> loginUser(String email, String password) {
    return this.repo.logUserIn(email, password);
  }

  /// register taking an input RegistrationInput
  Future<RegistrationRes> register(RegistrationInput input) {
    return this.repo.registerUser(input);
  }

  /// getMyProfile  to get a profile and setting the bloc
  Future<void> getMyProfile() async {
    final user = await this.repo.getMyProfile();
    if (user != null) {
      emit(user);
    }
  }

  Future<bool> logout() async {
    return await this.repo.logout();
  }

  /// updateMyProfile method to update your profile
  Future<Alie> updateMyProfile(String username, String bio) async {
    final alie = await this.repo.updateMyProfile(username, bio);
    if (alie != null) {
      emit(alie);
    }
    return state;
  }

  /// deleteMyAccount to permanently delete my account
  Future<bool> deleteMyAccount() async {
    final success = await this.repo.deleteMyAccount();
    if (success) {
      emit(null);
      StaticDataStore.friendsState.updateFriendsState([]);
    }
    return success;
  }

  // UploadImage method to call the Upload image functionality and setting the path
  Future<String> UploadImage(File image) async {
    final imgurl = await this.repo.changeProfilePicture(image);
    if (imgurl != "") {
      print("image Url Is $imgurl ");
      return '';
    }
    print("\n\n\n\n\n\nThe Image Url is $imgurl\n\n\n\n\n\n");

    Alie alie = state;

    if (alie != null) {
      alie.imageUrl = imgurl;
      emit(alie);
    }
    return alie.imageUrl;
  }
}
