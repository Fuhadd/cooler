import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../Models/group_model.dart';
import '../../Repositories/firestore_repository.dart';
import '../../Repositories/user_repository.dart';

part 'invite_event.dart';
part 'invite_state.dart';

class InviteBloc extends Bloc<InviteEvent, InviteState> {
  UserRepository userRepository;
  FirestoreRepository firestoreRepository;
  InviteBloc(this.userRepository, this.firestoreRepository)
      : super(InviteInitial()) {
    on<SendInviteEvent>(_handleSendInvite);
  }

  FutureOr<void> _handleSendInvite(
      SendInviteEvent event, Emitter<InviteState> emit) async {
    try {
      emit(SendInviteInProgress());

      await firestoreRepository.initializeMatches(
          currentUserId: event.currentUserId,
          invitedUserId: event.invitedUserId,
          group: event.group,
          time: DateTime.now());

      emit(const SendInviteSuccessfull());
    } catch (error) {
      emit(SendInviteFailed(error.toString()));
    }
  }
}
