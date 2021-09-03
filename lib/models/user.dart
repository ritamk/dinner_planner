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
  final String? uid;
  final String? name;
  final String? userPic;
  final String? email;
  final String? phone;
  final Map<String, dynamic>? address;
  final String? landmark;
  final String? adLine;
  final String? city;
  final String? state;
  final String? pin;

  ExtendedUserData({
    this.uid,
    this.name,
    this.userPic,
    this.email,
    this.phone,
    this.address,
    this.landmark,
    this.adLine,
    this.city,
    this.state,
    this.pin,
  });
}

class UserAddressData {
  String field;
  String value;

  UserAddressData({
    required this.field,
    required this.value,
  });
}
