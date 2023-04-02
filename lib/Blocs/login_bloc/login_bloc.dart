import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:cooler/Repositories/user_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../Repositories/firestore_repository.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  UserRepository userRepository;
  FirestoreRepository firestoreRepository;
  LoginBloc(this.userRepository, this.firestoreRepository)
      : super(LoginInitial()) {
    on<LoginButtonPressed>(_handleUserLogin);
  }

  FutureOr<void> _handleUserLogin(
      LoginButtonPressed event, Emitter<LoginState> emit) async {
    try {
      emit(LoginInProgress());

      User? user =
          await userRepository.loginWithEmail(event.email, event.password);

      await firestoreRepository
          .saveUsersCredentialslocal()
          .then((value) => emit(LoginSuccessfull(user: user)));
    } catch (error) {
      emit(LoginFailed(error.toString()));
    }
  }
}
