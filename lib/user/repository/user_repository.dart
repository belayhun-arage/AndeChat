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
  Future<LoginRes> logUserIn(String email, String password)async {
    return await this.provider.Login(email, password);
  }
  Future<RegistrationRes> registerUser(
      RegistrationInput registrationInput) async  {
    return await this.provider.Register(registrationInput);
  }

  Future<List<Alie>> getMyFriends()async {
    return  await this.provider.getMyFriends();
  }
}
