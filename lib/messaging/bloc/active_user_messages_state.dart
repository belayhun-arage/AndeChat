import 'package:ChatUI/libs.dart';
import 'package:ChatUI/user/repository/user_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/*
        Note : The Message is to be fetched at the time of getting the  Friend 
            and any other messages called are not expected to pass through the 
            bloc class but most of them are through the web socket connection channel in 
            the service directory and the implementation of the message fetcher is in the data provider class.
*/

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
      final result = await this
          .chatRepo
          .deleteMessage(event.friendID, event.messageNumber);
      alie = this.state;
      if (alie == null) {
        return;
      }
      int val = alie.messages.length;
      alie.messages.removeWhere((message) {
        return message.messageNumber == event.messageNumber;
      });

      StaticDataStore.friendsState.updateThisFriend(alie);
      print(
          "Yielding the newly updated user  .$val....  ${alie.messages.length} ");
      yield alie;
    }
    //  else if (event is InteractiveUser) {
    //   yield (event as InteractiveUser ) .alie ;
    // }
  }

  void updateActiveUserMessages(Alie alie) {
    emit(alie);
  }
}
