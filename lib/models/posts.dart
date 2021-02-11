class Post {
  final String imagePath, title, description, profileimage, username;

  Post(
      {this.profileimage,
      this.username,
      this.imagePath,
      this.title,
      this.description});
}

final post1 = Post(
    imagePath: "assets/images/john.jpg",
    title: "endet nachihu",
    description: "selam tinish dess bilogn new yemetawut...",
    profileimage: "assets/images/olivia.jpg",
    username: "Mekdes genetu");

final post2 = Post(
    imagePath: "assets/images/john.jpg",
    title: "endet nachihu",
    description: "selam tinish dess bilogn new yemetawut...",
    profileimage: "assets/images/olivia.jpg",
    username: "Mekdes genetu");

final post3 = Post(
    imagePath: "assets/images/john.jpg",
    title: "endet nachihu",
    description: "selam tinish dess bilogn new yemetawut",
    profileimage: "assets/images/olivia.jpg",
    username: "Mekdes genetu");

final post4 = Post(
    imagePath: "assets/images/john.jpg",
    title: "endet nachihu",
    description: "selam tinish dess bilogn new yemetawut",
    profileimage: "assets/images/olivia.jpg",
    username: "Mekdes genetu");

final post5 = Post(
    imagePath: "assets/images/jhon.jpg",
    title: "endet nachihu",
    description: "selam tinish dess bilogn new yemetawut",
    profileimage: "assets/images/olivia.jpg",
    username: "Mekdes genetu");

final posts = [post1, post2, post3, post4, post5];
