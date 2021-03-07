import 'package:ChatUI/libs.dart';
import 'dart:async';

class AdminUserRepository {
  AdminUserRepository() {
    AdminUsersProvider.getInstance().then((prov) {
      this.provider = prov;
    });
  }

  AdminUsersProvider provider;

  Future<Admin> getMyProfile() async {
    return this.provider.getMyProfile();
  }

  Future<List<Alie>> searchUsers(String username) async {
    return await this.provider.searchUsers(username);
  }

  Future<bool> deleteUserByID(String userid) async {
    return await this.provider.deleteUserByID(userid);
  }
}
