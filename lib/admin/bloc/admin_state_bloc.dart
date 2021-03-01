import 'package:ChatUI/libs.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AdminState extends Cubit<Admin> {
  static AdminState _instance;
  AdminState({this.repo}) : super(null) {
    if (_instance == null) {
      _instance == this;
    }
  }

  static AdminState get instance {
    return _instance;
  }

  AdminRepository repo;
  updateUser(Admin user) {
    emit(user);
  }

  Future<AdminLoginRes> adminLogin(String email, String password) async {
    final res = await this.repo.adminLogin(email, password);
    if (res != null && res.success) {
      if (res.admin != null) {
        // setting the admin state frem the response
        emit(res.admin);
      }
    }
    return res;
  }
  

  

  /// register taking an input RegistrationInput
  // Future<RegistrationRes> register(RegistrationInput input) {
  //   return this.repo.registerUser(input);
  // }

  void getMyProfile() async {
    final user = await this.repo.getMyProfile();
    if (user != null) {
      emit(user);
    }
  }
}
