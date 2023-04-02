part of 'invite_bloc.dart';

abstract class InviteEvent extends Equatable {
  const InviteEvent();

  @override
  List<Object> get props => [];
}

class SendInviteEvent extends InviteEvent {
  String currentUserId;
  String invitedUserId;
  Group group;

  SendInviteEvent({
    required this.currentUserId,
    required this.invitedUserId,
    required this.group,
  });

  @override
  List<Object> get props => [];
}
