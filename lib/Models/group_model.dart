class Group {
  final String? groupId;
  final String groupName;

  final String status;

  final String? password;
  final String? pin;
  final int amount;
  final int noOfSavers;
  final DateTime startDate;
  // final List<dynamic>? admins;
  final List<dynamic>? members;

  final String imageUrl;

  Group({
    this.groupId,
    required this.noOfSavers,
    required this.amount,
    required this.startDate,
    required this.groupName,
    required this.imageUrl,
    required this.status,
    // this.admins,
    this.members,
    this.password,
    this.pin,
  });

  static Group fromJson(json) => Group(
        // groupId: json['groupId'],
        noOfSavers: 30,
        amount: 600,
        groupId: json['groupId'] ?? '',
        //TODO UNDER HERE CHANGE START DATE
        //?? SAME
        startDate: DateTime.now(),
        groupName: json['groupName'] ?? '',
        imageUrl: json['imageUrl'] ?? '',
        status: json['status'] ?? '',
        // admins: json['admins'] ?? [],
        members: json['members'] ?? [],
        password: json['password'] ?? '',
        pin: json['pin'] ?? '',
      );

  Map<String, dynamic> toJson() => {
        "groupId": groupId,
        "noOfSavers": noOfSavers,
        "amount": amount,
        "startDate": startDate,
        "groupName": groupName,
        "imageUrl": imageUrl,
        "status": status,
        // "admins": admins,
        "members": members,
        "password": password,
        "pin": pin,
      };
}
