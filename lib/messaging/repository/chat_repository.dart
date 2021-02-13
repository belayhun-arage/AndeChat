import 'package:ChatUI/libs.dart';

class ChatRepository {
  MessagingDataProvider _messagingDataProvider;
  ChatRepository(MessagingDataProvider messadp) {
    _messagingDataProvider = messadp;
  }

  Future<List<EEMessage>> getOurChats(String friendID) async {
    List<EEMessage> messages =
        await _messagingDataProvider.getOurChats(friendID);
    return messages; 
  }


}
