import 'package:ChatUI/models/user_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FriendsBloc extends Cubit<List<Alie>> {
  FriendsBloc() : super([]);

  void changeAlies(List<Alie> alies) {
    emit(alies);
  }

  Alie getAlieByID(String id) {
    for (Alie alie in state) {
      if (alie.id == id) {
        return alie; 
      }
    }
  }

}
