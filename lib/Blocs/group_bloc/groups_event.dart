// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'groups_bloc.dart';

abstract class GroupsEvent extends Equatable {
  const GroupsEvent();

  @override
  List<Object> get props => [];
}

class CreateGroupEvent extends GroupsEvent {
  File image;
  String status;
  String groupName;
  String memberUserId;
  String inviteeUserId;
  String? password;
  String? pin;
  int amount;
  int noOfSavers;
  DateTime startDate;
  String memberEmail;
  String memberImageUrl;
  String memberName;

  CreateGroupEvent(
      {required this.image,
      required this.status,
      required this.groupName,
      this.password,
      this.pin,
      required this.inviteeUserId,
      required this.memberUserId,
      required this.amount,
      required this.noOfSavers,
      required this.startDate,
      required this.memberEmail,
      required this.memberImageUrl,
      required this.memberName});

  @override
  List<Object> get props => [status, groupName, amount, noOfSavers, startDate];
}

class JoinPrivateGroupEvent extends GroupsEvent {
  String memberUserId;
  String inviteeUserId;
  String memberEmail;
  String memberImageUrl;
  String memberName;
  String groupName;
  String pin;

  JoinPrivateGroupEvent({
    required this.inviteeUserId,
    required this.pin,
    required this.groupName,
    required this.memberEmail,
    required this.memberImageUrl,
    required this.memberName,
    required this.memberUserId,
  });

  @override
  List<Object> get props => [groupName, pin];
}

class AddMemberToGroupEvent extends GroupsEvent {
  String groupId;
  String memberUserId;
  String inviteeUserId;
  int invite;
  DateTime time;
  String memberEmail;
  String memberImageUrl;
  String memberName;
  Group group;

  AddMemberToGroupEvent({
    required this.groupId,
    required this.invite,
    required this.inviteeUserId,
    required this.memberUserId,
    required this.time,
    required this.memberEmail,
    required this.memberImageUrl,
    required this.memberName,
    required this.group,
  });

  @override
  List<Object> get props =>
      [groupId, invite, inviteeUserId, memberUserId, time];
}

class AcceptGroupInviteEvent extends GroupsEvent {
  String groupId;
  String currentUserId;
  String invitedUserId;
  AcceptGroupInviteEvent({
    required this.groupId,
    required this.invitedUserId,
    required this.currentUserId,
  });

  @override
  List<Object> get props => [];
}

class AddUserToPublicGroupEvent extends GroupsEvent {
  String groupId;
  String memberUserId;
  String inviteeUserId;
  String memberEmail;
  String memberImageUrl;
  String memberName;

  AddUserToPublicGroupEvent(
      {required this.groupId,
      required this.inviteeUserId,
      required this.memberUserId,
      required this.memberEmail,
      required this.memberImageUrl,
      required this.memberName});

  @override
  List<Object> get props => [];
}

class LeaveGroupEvent extends GroupsEvent {
  String currentUserId;
  String groupName;
  String groupId;

  LeaveGroupEvent({
    required this.currentUserId,
    required this.groupName,
    required this.groupId,
  });

  @override
  List<Object> get props => [groupName];
}
