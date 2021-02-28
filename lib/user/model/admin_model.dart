import 'package:ChatUI/messaging/data_provider/data_provider.dart';

class Admin {
  final String id;
  final String createdby;
  final String username;
  final String email;

  Admin({
    this.id,
    this.createdby,
    this.email,
    this.username,
  });

  factory Admin.fromJson(Map<String, dynamic> theJson) {
    Admin user;
    try {
      user = Admin(
        id: theJson["id"],
        username: theJson["username"],
        email: theJson["email"],
        createdby: theJson["createdby"],
    } catch (e, a) {
      print(e.toString());
      user = null;
    }
    return user;
  }




  Future<bool> populateChats(MessagingDataProvider handler) async {
    List<EEMessage> ourMessages = await handler.getOurChats(this.id);
    if (ourMessages == null) {
      this.messages = [];
      return false;
    }
    this.messages = ourMessages;
    return true;
  }



  
}
