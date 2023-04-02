import 'dart:async';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:cooler/Models/group_model.dart';
import 'package:cooler/Repositories/firebase_storage_repository.dart';
import 'package:cooler/Repositories/firestore_repository.dart';
import 'package:equatable/equatable.dart';

part 'groups_event.dart';
part 'groups_state.dart';

class GroupsBloc extends Bloc<GroupsEvent, GroupsState> {
  FirestoreRepository firestoreRepository;
  FirebaseStorageRepository firebaseStorageRepository;
  GroupsBloc(this.firestoreRepository, this.firebaseStorageRepository)
      : super(GroupsInitial()) {
    on<CreateGroupEvent>(_handleCreateGroup);
    on<JoinPrivateGroupEvent>(_handleJoinPrivateGroup);
    on<AddMemberToGroupEvent>(_handleAddMemberToGroup);
    on<AcceptGroupInviteEvent>(_handleAcceptGroupInvite);
    on<AddUserToPublicGroupEvent>(_handleAddUserToGroup);
    on<LeaveGroupEvent>(_handleLeaveGroup);
  }

  FutureOr<void> _handleCreateGroup(
      CreateGroupEvent event, Emitter<GroupsState> emit) async {
    try {
      emit(CreateGroupInProgress());
      String groupId = await firestoreRepository.createGroup(
        event.status,
        event.groupName,
        event.password,
        event.pin,
        event.amount,
        event.noOfSavers,
        event.startDate,
      );

      await firebaseStorageRepository.uploadGroupImage(event.image, groupId);
      await firestoreRepository.addMemberToGroup(
          memberUserId: event.memberUserId,
          inviteeUserId: event.inviteeUserId,
          groupId: groupId,
          time: DateTime.now(),
          memberEmail: event.memberEmail,
          memberImageUrl: event.memberImageUrl,
          memberName: event.memberName,
          invite: 0);
      await firestoreRepository.AddGroupToUserCredentials([groupId]);
      await firestoreRepository.AddGroupToEmployerCredentials([groupId]);
      emit(CreateGroupSuccessfull(groupId: groupId));
    } catch (e) {
      emit(CreateGroupFailed(e.toString()));
    }
  }

  FutureOr<void> _handleJoinPrivateGroup(
      JoinPrivateGroupEvent event, Emitter<GroupsState> emit) async {
    try {
      emit(JoinPrivateGroupInProgress());
      Group? group =
          await firestoreRepository.getPrivateGroup(event.groupName, event.pin);

      if (group == null) {
        emit(JoinPrivateGroupFailed('Not Found'));
      } else {
        await firestoreRepository.addMemberToGroup(
            memberUserId: event.memberUserId,
            inviteeUserId: event.inviteeUserId,
            groupId: group.groupId!,
            time: DateTime.now(),
            memberEmail: event.memberEmail,
            memberImageUrl: event.memberImageUrl,
            memberName: event.memberName,
            invite: 0);
        await firestoreRepository.AddGroupToUserCredentials([group.groupId!]);
        await firestoreRepository.AddUserToGroupCredentials(
            group.groupId!, [event.memberUserId]);

        emit(JoinPrivateGroupSuccessfull(group: group));
      }
    } catch (e) {
      emit(JoinPrivateGroupFailed(e.toString()));
    }
  }

  FutureOr<void> _handleAddMemberToGroup(
      AddMemberToGroupEvent event, Emitter<GroupsState> emit) async {
    try {
      String uniqueId = await firestoreRepository.createUniqueId(
          event.memberUserId, event.inviteeUserId, event.groupId);
      emit(AddMemberToGroupInProgress(uniqueId));
      await firestoreRepository.addMemberToGroup(
        groupId: event.groupId,
        memberUserId: event.memberUserId,
        inviteeUserId: event.inviteeUserId,
        time: event.time,
        invite: event.invite,
        memberEmail: event.memberEmail,
        memberImageUrl: event.memberImageUrl,
        memberName: event.memberName,
      );

      await firestoreRepository
          .addMemberToGroupList([event.memberUserId], event.groupId);
      await firestoreRepository.initializeMatches(
          currentUserId: event.inviteeUserId,
          invitedUserId: event.memberUserId,
          group: event.group,
          time: event.time);
      emit(AddMemberToGroupSuccessfull(uniqueId));
    } catch (e) {
      emit(JoinPrivateGroupFailed(e.toString()));
    }
  }

  FutureOr<void> _handleAcceptGroupInvite(
      AcceptGroupInviteEvent event, Emitter<GroupsState> emit) async {
    try {
      emit(const AcceptGroupInviteInProgress());
      await firestoreRepository.deleteInviteRequest(
          event.currentUserId, event.invitedUserId);
      await firestoreRepository.acceptInviteRequest(
          event.groupId, event.currentUserId);
      await firestoreRepository.AddGroupToUserCredentials([event.groupId]);
      emit(const AcceptGroupInviteSuccessfull());
    } catch (e) {
      emit(AcceptGroupInviteFailed(e.toString()));
    }
  }

  FutureOr<void> _handleAddUserToGroup(
      AddUserToPublicGroupEvent event, Emitter<GroupsState> emit) async {
    try {
      emit(AddUserToPublicGroupInProgress());
      await firestoreRepository.addMemberToGroup(
          memberUserId: event.memberUserId,
          inviteeUserId: event.inviteeUserId,
          groupId: event.groupId,
          time: DateTime.now(),
          memberEmail: event.memberEmail,
          memberImageUrl: event.memberImageUrl,
          memberName: event.memberName,
          invite: 0);
      await firestoreRepository.AddGroupToUserCredentials([event.groupId]);
      await firestoreRepository.AddUserToGroupCredentials(
          event.groupId, [event.memberUserId]);
      emit(AddUserToPublicGroupSuccessfull(groupId: event.groupId));
    } catch (e) {
      emit(AddUserToPublicGroupFailed(e.toString()));
    }
  }

  FutureOr<void> _handleLeaveGroup(
      LeaveGroupEvent event, Emitter<GroupsState> emit) async {
    try {
      emit(LeaveGroupInProgress());
      await firestoreRepository.removeMemberFromGroup(
          event.groupId, event.currentUserId);
      await firestoreRepository.removeGroupFromUserCredentials([event.groupId]);
      await firestoreRepository
          .removeUserFromGroupCredentials(event.groupId, [event.currentUserId]);

      emit(LeaveGroupSuccessfull());
    } catch (e) {
      emit(LeaveGroupFailed(e.toString()));
    }
  }
}
