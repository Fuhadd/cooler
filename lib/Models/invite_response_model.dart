class InviteResponseModel {
  final String? groupId;
  final String? groupName;

  final String? isAccept;

  final String? isReject;
  final String? matchId;
  final DateTime? sentAt;
  final List<dynamic>? users;

  final String? sentBy;

  InviteResponseModel({
    this.groupId,
    this.groupName,
    this.isAccept,
    this.isReject,
    this.matchId,
    this.sentAt,
    this.sentBy,
    this.users,
  });

  static InviteResponseModel fromJson(json) => InviteResponseModel(
        groupId: json['groupId'],
        groupName: json['groupName'],
        isAccept: json['isAccept'],
        sentAt: json['sentAt'].toDate(),
        isReject: json['groupName'],
        matchId: json['isReject'],
        sentBy: json['sentBy'],
        users: json['users'],
      );

  Map<String, dynamic> toJson() => {
        "groupId": groupId,
        "groupName": groupName,
        "isAccept": isAccept,
        "sentAt": sentAt,
        "isReject": isReject,
        "matchId": matchId,
        "sentBy": sentBy,
        "users": users,
      };
}
