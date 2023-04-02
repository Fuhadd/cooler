part of 'groups_bloc.dart';

abstract class GroupsState extends Equatable {
  const GroupsState();

  @override
  List<Object> get props => [];
}

class GroupsInitial extends GroupsState {}

class CreateGroupInProgress extends GroupsState {}

class CreateGroupSuccessfull extends GroupsState {
  String? groupId;

  CreateGroupSuccessfull({
    this.groupId,
  });
}

class CreateGroupFailed extends GroupsState {
  String message;
  CreateGroupFailed(
    this.message,
  );

  @override
  List<Object> get props => [message];
}

class JoinPrivateGroupInProgress extends GroupsState {}

class JoinPrivateGroupSuccessfull extends GroupsState {
  Group? group;

  JoinPrivateGroupSuccessfull({
    this.group,
  });
}

class JoinPrivateGroupFailed extends GroupsState {
  String message;
  JoinPrivateGroupFailed(
    this.message,
  );

  @override
  List<Object> get props => [message];
}

class AddMemberToGroupInProgress extends GroupsState {
  String uniqueId;
  AddMemberToGroupInProgress(this.uniqueId);
}

class AddMemberToGroupSuccessfull extends GroupsState {
  String uniqueId;
  AddMemberToGroupSuccessfull(this.uniqueId);
}

class AddMemberToGroupFailed extends GroupsState {
  String message;
  AddMemberToGroupFailed(
    this.message,
  );

  @override
  List<Object> get props => [message];
}

class AcceptGroupInviteInProgress extends GroupsState {
  const AcceptGroupInviteInProgress();
}

class AcceptGroupInviteSuccessfull extends GroupsState {
  const AcceptGroupInviteSuccessfull();
}

class AcceptGroupInviteFailed extends GroupsState {
  String message;
  AcceptGroupInviteFailed(
    this.message,
  );

  @override
  List<Object> get props => [message];
}

class AddUserToPublicGroupInProgress extends GroupsState {}

class AddUserToPublicGroupSuccessfull extends GroupsState {
  String? groupId;

  AddUserToPublicGroupSuccessfull({
    this.groupId,
  });
}

class AddUserToPublicGroupFailed extends GroupsState {
  String message;
  AddUserToPublicGroupFailed(
    this.message,
  );

  @override
  List<Object> get props => [message];
}

class LeaveGroupInProgress extends GroupsState {}

class LeaveGroupSuccessfull extends GroupsState {
  String? groupId;

  LeaveGroupSuccessfull({
    this.groupId,
  });
}

class LeaveGroupFailed extends GroupsState {
  String message;
  LeaveGroupFailed(
    this.message,
  );

  @override
  List<Object> get props => [message];
}
