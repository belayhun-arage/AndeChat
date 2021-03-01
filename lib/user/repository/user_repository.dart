import 'package:ChatUI/libs.dart';
import 'dart:async';

class UserRepository {
  UserRepository() {
    UserDataProvider.getInstance().then((prov) {
      this.provider = prov;
    });
  }

  UserDataProvider provider;

  Future<Alie> getMyProfile() async {
    return this.provider.getMyProfile();
  }

  Future<LoginRes> logUserIn(String email, String password) async {
    return await this.provider.Login(email, password);
  }

  Future<RegistrationRes> registerUser(
      RegistrationInput registrationInput) async {
    return await this.provider.Register(registrationInput);
  }

  Future<Alie> updateMyProfile(String username, String bio) async {
    return await this.provider.updateMyProfile(username, bio);
  }

  Future<List<Alie>> getMyFriends() async {
    final friends = await this.provider.getMyFriends();
    MessagingDataProvider provide = await MessagingDataProvider.getInstance();
    for (int a = 0; a < friends.length; a++) {
      final friend = friends[a];
      try {
        if (friend != null) {
          friend.populateChats(provide);
        }
      } catch (e, a) {
        continue;
      }
    }
    return friends;
  }
}
