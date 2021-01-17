/*End to end message data structure and its methods  */
import 'package:ChatUI/models/user_model.dart';

class Message {
  // final Alie sender;
  Alie sender;
  
  final String
      time; // Would usually be type DateTime or Firebase Timestamp in production apps
  final String text;
    bool isLiked;
  // final bool isLiked;
  final bool unread;

  Message({
    this.sender,
    this.time,
    this.text,
    this.isLiked,
    this.unread,
  });
}

// YOU - current Alie
final Alie currentAlie = Alie(
  // id: 0,
  username: 'Current Alie',
  imageUrl: 'assets/images/greg.jpg',
);

// AlieS
final Alie greg = Alie(
  // id: 1,
  username: 'Greg',
  imageUrl: 'assets/images/greg.jpg',
);
final Alie james = Alie(
  // id: 2,
  username: 'James',
  imageUrl: 'assets/images/james.jpg',
);
final Alie john = Alie(
  // id: 3,
  username: 'John',
  imageUrl: 'assets/images/john.jpg',
);
final Alie olivia = Alie(
  // id: 4,
  username: 'Olivia',
  imageUrl: 'assets/images/olivia.jpg',
);
final Alie sam = Alie(
  // id: 5,
  username: 'Sam',
  imageUrl: 'assets/images/sam.jpg',
);
final Alie sophia = Alie(
  // id: 6,
  username: 'Sophia',
  imageUrl: 'assets/images/sophia.jpg',
);
final Alie steven = Alie(
  // id: 7,
  username: 'Steven',
  imageUrl: 'assets/images/steven.jpg',
);

// FAVORITE CONTACTS
List<Alie> favorites = [sam, steven, olivia, john, greg];

// EXAMPLE CHATS ON HOME SCREEN
List<Message> chats = [
  Message(
    sender: james,
    time: '5:30 PM',
    text: 'Hey, how\'s it going? What did you do today?',
    isLiked: false,
    unread: true,
  ),
  Message(
    sender: olivia,
    time: '4:30 PM',
    text: 'Hey, how\'s it going? What did you do today?',
    isLiked: false,
    unread: true,
  ),
  Message(
    sender: john,
    time: '3:30 PM',
    text: 'Hey, how\'s it going? What did you do today?',
    isLiked: false,
    unread: false,
  ),
  Message(
    sender: sophia,
    time: '2:30 PM',
    text: 'Hey, how\'s it going? What did you do today?',
    isLiked: false,
    unread: true,
  ),
  Message(
    sender: steven,
    time: '1:30 PM',
    text: 'Hey, how\'s it going? What did you do today?',
    isLiked: false,
    unread: false,
  ),
  Message(
    sender: sam,
    time: '12:30 PM',
    text: 'Hey, how\'s it going? What did you do today?',
    isLiked: false,
    unread: false,
  ),
  Message(
    sender: greg,
    time: '11:30 AM',
    text: 'Hey, how\'s it going? What did you do today? What did you do today? What did you do today? What did you do today? What did you do today? What did you do today? What did you do today?',
    isLiked: false,
    unread: false,
  ),
];

// EXAMPLE MESSAGES IN CHAT SCREEN
List<Message> messages = [
  Message(
    sender: james,
    time: '5:30 PM',
    text: 'Hey, how\'s it going? What did you do today?',
    isLiked: true,
    unread: true,
  ),
  Message(
    sender: currentAlie,
    time: '4:30 PM',
    text: 'Just walked my doge. She was super duper cute. The best pupper!!',
    isLiked: false,
    unread: true,
  ),
  Message(
    sender: james,
    time: '3:45 PM',
    text: 'How\'s the doggo?',
    isLiked: false,
    unread: true,
  ),
  Message(
    sender: james,
    time: '3:15 PM',
    text: 'All the food',
    isLiked: true,
    unread: true,
  ),
  Message(
    sender: currentAlie,
    time: '2:30 PM',
    text: 'Nice! What kind of food did you eat?',
    isLiked: false,
    unread: true,
  ),
  Message(
    sender: james,
    time: '2:00 PM',
    text: 'I ate so much food today.',
    isLiked: false,
    unread: true,
  ),
];
