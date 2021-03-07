import 'package:ChatUI/libs.dart';
import 'package:ChatUI/messaging/widgets/message_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'dart:math';

class ChatScreen extends StatefulWidget {
  static const String Route = "/chat";
  static WebSocketService websocketService;
  Alie user;
  ChatScreen({
    this.user,
  });

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  @override
  void initState() {
    if (ChatScreen.websocketService == null) {
      WebSocketService.getInstance().then((ws) {
        ChatScreen.websocketService = ws;
      });
    }
    super.initState();
  }

  List<Message> messageso;
  final TextEditingController textInputController = new TextEditingController();
  ScrollController scroller = new ScrollController();
  @override
  Widget build(BuildContext context) {
    if (widget.user == null) {
      widget.user = (ModalRoute.of(context).settings.arguments
          as Map<String, Object>)['user'] as Alie;
    }
    messageso = messages;
    // passing the alie to the interacting alie bloc
    InteractiveUser intuser = BlocProvider.of<InteractiveUser>(context);
    intuser.updateActiveUserMessages(widget.user);
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
                  child: BlocBuilder<InteractiveUser, Alie>(
                    builder: (_, alie) {
                      final messages = alie.messages;
                      return ListView.builder(
                        controller: scroller,
                        itemCount: messages == null ? 0 : messages.length,
                        padding: EdgeInsets.only(top: 15.0),
                        itemBuilder: (BuildContext context, int index) {
                          final EEMessage message = messages[index];
                          final bool isMe = message.senderID ==
                              StaticDataStore.userState.state.id;
                          return MessageItem(message, isMe);
                        },
                      );
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
                      // onSubmitted: sendMessageWithString,
                      decoration: InputDecoration(
                        hintText: "Message here ...",
                      ),
                      onEditingComplete: () => _sendMessage(),
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

  void sendTypingMessage() {
    TypingMessage typm = TypingMessage();
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
        senderID: StaticDataStore.userState.state.id,
        sent: false,
        text: messageText,
      );

      ChatScreen.websocketService.sendEEMessage(mess);
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
}
