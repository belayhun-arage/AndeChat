import 'package:ChatUI/libs.dart';

class ChatRepository {
  MessagingDataProvider _messagingDataProvider;

  ChatRepository() {
    MessagingDataProvider.getInstance().then((prov) {
      this._messagingDataProvider = prov;
    });
  }

  /// deleteMessage method to delete a message using
  /// it's friendID and messageNumber
  Future<bool> deleteMessage(String friendID, int messageNumber) async {
    final result =
        await _messagingDataProvider.deleteMessage(friendID, messageNumber);
    return result; 
  }

  Future<List<EEMessage>> getOurChats(String friendID) async {
    List<EEMessage> messages =
        await _messagingDataProvider.getOurChats(friendID);
    return messages;
  }
}
