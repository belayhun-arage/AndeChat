class GroupMessage {
  int ID;
  final String text;
  final String groupID;
  final int messageNumber;
  final String time;
  final String senderID;
  set id (int value) {
    this.ID = value ;
  }
  GroupMessage({
    this.senderID,
    this.text,
    this.groupID,
    this.messageNumber,
    this.time,
  });
  factory GroupMessage.fromJson(Map<String, dynamic> theJson) {
    GroupMessage gmessage;
    if (theJson != null) {
      gmessage = GroupMessage(
        text: theJson['text'],
        groupID: theJson['group_id'],
        messageNumber: theJson['message_number'] != null
            ? theJson['message_number'] as int
            : -1,
        time: theJson['time'],
        senderID: theJson["sender_id"] as String,
      );
      if (gmessage.senderID == '' ||
          gmessage.text == '' ||
          gmessage.groupID == '' ||
          gmessage.messageNumber <= 1 ||
          gmessage.time == "") {
        return null;
      }
    }
    return gmessage;
  }
}

