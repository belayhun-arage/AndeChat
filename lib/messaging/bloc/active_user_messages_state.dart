import 'package:ChatUI/user/user.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

enum ActiveUsersEvent {
  abebe  , 
}
class InteractiveUser extends Bloc<ActiveUsersEvent, Alie>
    implements Cubit<Alie> {
  static InteractiveUser instance;
  InteractiveUser() : super(null) {
    if (instance == null) {
      instance = this; 
    }
  }

  @override
  Stream<Alie> mapEventToState(event) {}

  void updateActiveUserMessages(Alie alie ) {
    emit(alie);
  }
}
