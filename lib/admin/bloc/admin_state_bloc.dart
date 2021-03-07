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

  Future<Admin> adminRegister(String username, String email, String password,
      String confirmPassword) async {
    return await this.repo.adminRegister(username  , email  , password , confirmPassword);
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

  Future<List<Idea>> getideasMoney() async {
    return await this.repo.getideasMoney();
  }

  /// deleteUserById method to delete a user
  Future<bool> deleteUserById(String id) async {
    return await repo.deleteUserById(id);
  }

  /// deleteSelfCreatedAdmin method to delete admins which i created
  /// the admin have full control over admins which he created
  Future<bool> deleteSelfCreatedAdmin(String id) async {
    return await repo.deleteSelfCreatedAdmin(id);
  }
}
