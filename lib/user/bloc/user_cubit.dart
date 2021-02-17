import 'package:ChatUI/libs.dart';
import 'package:ChatUI/user/repository/user_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UserCubit extends Cubit<Alie> {
  static UserCubit _instance;
  UserCubit({this.repo})
      : assert(repo != null),
        super(null) {
    if (_instance == null) {
      _instance == this;
    }
  }

  static UserCubit get instance {
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
}
