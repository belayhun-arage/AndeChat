import 'package:ChatUI/libs.dart';
import 'package:ChatUI/user/repository/user_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// InteractiveUser a bloc class representing the alie which the user is interacting with and
/// the messages inside the alie --which is exchanged between the two users
/// the neccesity of using this as a bloc class is because it's not only to be accesible by the
/// chatScreen file it is also to be used by the websocket service to notify the users
class InteractiveUser extends Bloc<MessageState, Alie> implements Cubit<Alie> {
  static InteractiveUser instance;
  UserRepository urepo;
  ChatRepository chatRepo;
  InteractiveUser(UserRepository repo, ChatRepository messRepo) : super(null) {
    this.urepo = repo;
    this.chatRepo = messRepo;
    if (instance == null) {
      instance = this;
    }
  }

  @override
  Stream<Alie> mapEventToState(event) async* {
    if (event is MessageDelete) {
      Alie alie;
      final result = this
          .chatRepo
          .deleteMessage(event.friendID, event.messageNumber)
          .then((res) {
        alie = state;
        alie.messages.removeWhere((message) {
          return message.messageNumber == event.messageNumber;
        });
        // yield alie;
      });
    }
    //  else if (event is InteractiveUser) {
    //   yield (event as InteractiveUser ) .alie ;
    // }
  }

  void updateActiveUserMessages(Alie alie) {
    emit(alie);
  }
}
