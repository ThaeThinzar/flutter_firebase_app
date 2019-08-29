class FriendModel {
  final String profileURL;
  final String name;
  final String dateTime;

  FriendModel({
    this.profileURL,
    this.name,
    this.dateTime,
  });

  static final List<FriendModel> dummyData = [
    FriendModel(
      profileURL: "https://randomuser.me/api/portraits/women/34.jpg",
      name: "Laurent",
      dateTime: "20:18",
    ),
    FriendModel(
      profileURL: "https://randomuser.me/api/portraits/women/49.jpg",
      name: "Tracy",
      dateTime: "19:22",

    ),
    FriendModel(
      profileURL: "https://randomuser.me/api/portraits/women/77.jpg",
      name: "Claire",
      dateTime: "14:34",

    ),
    FriendModel(
      profileURL: "https://randomuser.me/api/portraits/men/81.jpg",
      name: "Mard",
      dateTime: "11:05",

    ),
    FriendModel(
      profileURL: "https://randomuser.me/api/portraits/men/83.jpg",
      name: "Joe",
      dateTime: "09:46",

    ),
    FriendModel(
      profileURL: "https://randomuser.me/api/portraits/men/85.jpg",
      name: "Williams",
      dateTime: "08:15",

    ),
  ];

}

