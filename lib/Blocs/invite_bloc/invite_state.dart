part of 'invite_bloc.dart';

abstract class InviteState extends Equatable {
  const InviteState();

  @override
  List<Object> get props => [];
}

class InviteInitial extends InviteState {}

class SendInviteInProgress extends InviteState {}

class SendInviteSuccessfull extends InviteState {
  const SendInviteSuccessfull();
}

class SendInviteFailed extends InviteState {
  String message;
  SendInviteFailed(
    this.message,
  );

  @override
  List<Object> get props => [message];
}
