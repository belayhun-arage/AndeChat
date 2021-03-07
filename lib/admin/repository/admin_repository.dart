import 'package:ChatUI/libs.dart';
import 'dart:async';

class AdminRepository {
  AdminRepository() {
    AdminDataProvider.getInstance().then((prov) {
      this.provider = prov;
    });
  }

  AdminDataProvider provider;

  Future<Admin> getMyProfile() async {
    return this.provider.getMyProfile();
  }

  Future<Admin> adminRegister(String username, String email, String password,
      String confirmPassword) async {
    return this
        .provider
        .adminRegister(username, email, password, confirmPassword);
  }

  Future<AdminLoginRes> adminLogin(String email, String password) async {
    return await this.provider.AdminLogin(email, password);
  }

  Future<List<Idea>> getideasMoney() async {
    return await provider.getIdeasMoney();
  }

  /// deleteUserById method to delete a user
  Future<bool> deleteUserById(String id) async {
    return await provider.deleteUserById(id);
  }

  /// deleteSelfCreatedAdmin method to delete admins which i created
  /// the admin have full control over admins which he created
  Future<bool> deleteSelfCreatedAdmin(String id) async {
    return await provider.deleteSelfCreatedAdminById(id);
  }
}
