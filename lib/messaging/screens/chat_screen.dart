import 'package:ChatUI/libs.dart';
import 'package:flutter/material.dart';

class ChatScreen extends StatefulWidget {
  static const String Route = "/chat";
  Alie user;
  ChatScreen({
    this.user,
  });

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  static WebSocketService websocketService;

  @override
  void initState() {
    if (websocketService == null) {
      WebSocketService.getInstance().then((ws) {
        websocketService = ws;
      });
    }
    super.initState();
  }

  Widget _buildMessage(EEMessage message, bool isMe) {
    final messageBody = Container(
      width: MediaQuery.of(context).size.width * 0.65,
      padding: EdgeInsets.symmetric(
        horizontal: 25.0,
        vertical: 15.0,
      ),
      margin: isMe
          ? EdgeInsets.only(
              top: 8.0,
              bottom: 8.0,
              left: 80.0,
            )
          : EdgeInsets.only(
              top: 8.0,
              bottom: 8.0,
              right: 80.0,
            ),
      // color: isMe ? Colors.white : Color(0XFFfeeeee),
      decoration: BoxDecoration(
        color: isMe ? Theme.of(context).accentColor : Color(0XFFfeeeee),
        borderRadius: isMe
            ? BorderRadius.only(
                topLeft: Radius.circular(20),
                bottomLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              )
            : BorderRadius.only(
                topLeft: Radius.circular(20),
                bottomRight: Radius.circular(20),
                topRight: Radius.circular(20),
              ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            message.time,
            textAlign: TextAlign.start,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.grey,
            ),
          ),
          SizedBox(
            height: 10.0,
          ),
          Text(
            message.text,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              // color: Colors.grey ,
            ),
            textAlign: TextAlign.start,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: SizedBox(),
              ),
              isMe
                  ? Icon(message.seen && message.sent
                      ? Icons.mark_chat_read
                      : Icons.check)
                  : SizedBox()
            ],
          )
        ],
      ),
    );
    if (isMe) {
      return messageBody;
    } else {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          messageBody,
          IconButton(
            iconSize: 30.0,
            icon: Icon(
              false ? Icons.favorite : Icons.favorite_border,
              color: false ? Theme.of(context).primaryColor : Colors.grey,
            ),
            onPressed: () {
              // setState(() {
              //   message.isLiked = message.isLiked ? false : true;
              // });
            },
          ),
        ],
      );
    }
  }

  void _sendMessage() {
    final String timeValue =
        "${TimeOfDay.now().hour}:${TimeOfDay.now().minute}";
    setState(() {
      final String messageText = textInputController.text;
      textInputController.text = "";
      final EEMessage mess = EEMessage(
        receiverID: widget.user.id,
        seen: false,
        senderID: StaticDataStore.ID,
        sent: false,
        text: messageText,
      );

      websocketService.sendEEMessage(mess);
      // messageso.insert(0, mess);
    });
  }

  void sendMessageWithString(String message) {
    final String timeValue =
        "${TimeOfDay.now().hour}:${TimeOfDay.now().minute}";
    setState(() {
      final String messageText = message;
      textInputController.text = "";
      final Message mess = Message(
        isLiked: false,
        sender: widget.user,
        text: messageText,
        time: timeValue,
        unread: true,
      );
      messageso.insert(0, mess);
    });
  }

  List<Message> messageso;
  final TextEditingController textInputController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    if (widget.user == null) {
      widget.user = (ModalRoute.of(context).settings.arguments
          as Map<String, Object>)['user'] as Alie;
    }
    messageso = messages;
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Theme.of(context).primaryColor,
        centerTitle: true,
        title: Text(
          widget.user.username,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 28.0,
          ),
        ),
        actions: [
          IconButton(
            iconSize: 30.0,
            icon: Icon(
              Icons.more_horiz,
              color: Colors.white,
            ),
            onPressed: () {},
          ),
        ],
      ),
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Column(
          children: [
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30.0),
                    topRight: Radius.circular(30.0),
                  ),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30.0),
                    topRight: Radius.circular(30.0),
                  ),
                  child: ListView.builder(
                    reverse: true,
                    itemCount: widget.user.messages==null ? 0 : widget.user.messages.length,
                    padding: EdgeInsets.only(top: 15.0),
                    itemBuilder: (BuildContext context, int index) {
                      final EEMessage message = widget.user.messages[index];
                      final bool isMe = message.senderID == StaticDataStore.ID;
                      return _buildMessage(message, isMe);
                    },
                  ),
                ),
              ),
            ),
            // File and Other Text Sending Widget Will Be Placed  heere nigga
            Container(
              padding: EdgeInsets.symmetric(horizontal: 8.0),
              height: 70.0,
              color: Colors.white,
              child: Row(
                children: [
                  IconButton(
                    icon: Icon(Icons.image),
                    color: Theme.of(context).primaryColor,
                    onPressed: () {},
                  ),
                  Expanded(
                    child: TextField(
                      textCapitalization: TextCapitalization.sentences,
                      showCursor: true,
                      controller: textInputController,
                      onSubmitted: sendMessageWithString,
                      decoration: InputDecoration(
                        hintText: "Message here ...",
                      ),
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.send),
                    color: Theme.of(context).primaryColor,
                    onPressed: () => _sendMessage(),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
