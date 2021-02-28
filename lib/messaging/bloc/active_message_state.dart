import 'package:ChatUI/libs.dart';
import 'package:ChatUI/messaging/models/message_model.dart';

class MessageState {
  //
}

class MessageDelete extends MessageState {
  String friendID;
  int messageNumber;
  MessageDelete(this.friendID, this.messageNumber);
}

class MessageEdit extends MessageState {
  EEMessage message;
  MessageEdit(this.message);
}

class InteractingUser extends MessageState {
  Alie alie;
  InteractingUser(this.alie);
}
