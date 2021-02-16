import 'package:ChatUI/libs.dart';

class ChatRepository {
  MessagingDataProvider _messagingDataProvider;

  ChatRepository(){
    MessagingDataProvider.getInstance().then((prov){
      this._messagingDataProvider = prov ; 
    });
  }

  Future<List<EEMessage>> getOurChats(String friendID) async {
    List<EEMessage> messages =
        await _messagingDataProvider.getOurChats(friendID);
    return messages; 
  }
}
