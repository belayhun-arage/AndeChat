/* This file contains class named Group and it's methods */
import 'package:ChatUI/models/group_messages.dart';

class Group {
  final String groupname;
  final int membersCount;
  final String imageUrl;
  final int activeCounts;
  final String ownerID;
  final String description;
  final int lastMessageNumber;
  final List<String> membersID;
  final String createdAt;
  List<GroupMessage> messages;

  Group(
      {this.groupname,
      this.membersCount,
      this.imageUrl,
      this.activeCounts,
      this.ownerID,
      this.description,
      this.lastMessageNumber,
      this.membersID,
      this.createdAt,
      this.messages});
  void addNewMessage(GroupMessage message) {
    if (this.messages == null) {
      this.messages = [];
    }
    this.messages.add(message);
  }

  GroupMessage getMessageByMessageNumber(int messNo) {
    for (var mes in this.messages) {
      if (mes.messageNumber == messNo) {
        return mes;
      }
    }
    return null;
  }
}
