class UserID {
  final String uid;

  UserID({required this.uid});
}

class UserData {
  final String uid;
  final String name;
  final String? userPic;

  UserData({required this.uid, required this.name, this.userPic});
}

class ExtendedUserData {
  final String uid;
  final String name;
  final String userPic;
  final String? email;
  final String phone;
  final String landmark;
  final String adLine;
  final String city;
  final String state;
  final String pin;

  ExtendedUserData(
      {required this.uid,
      required this.name,
      required this.userPic,
      required this.email,
      required this.phone,
      required this.landmark,
      required this.adLine,
      required this.city,
      required this.state,
      required this.pin});
}
