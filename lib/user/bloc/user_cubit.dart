import 'package:ChatUI/libs.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UserCubit extends Cubit<Alie> {
  UserCubit() : super(null);

  updateUser(Alie user) {
    emit(user);
  }
}
