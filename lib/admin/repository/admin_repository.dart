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

  Future<AdminLoginRes> adminLogin(String email, String password) async {
    return await this.provider.AdminLogin(email, password);
  }

}
