import 'dart:async';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:cooler/Repositories/firebase_storage_repository.dart';
import 'package:cooler/Repositories/firestore_repository.dart';
import 'package:cooler/Repositories/user_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';

part 'signup_event.dart';
part 'signup_state.dart';

class SignupBloc extends Bloc<SignupEvent, SignupState> {
  UserRepository userRepository;
  FirestoreRepository firestoreRepository;
  FirebaseStorageRepository firebaseStorageRepository;

  SignupBloc(this.userRepository, this.firestoreRepository,
      this.firebaseStorageRepository)
      : super(SignupInitial()) {
    on<SignUpButtonPressed>(_handleUserSignUp);
  }

  FutureOr<void> _handleUserSignUp(
      SignUpButtonPressed event, Emitter<SignupState> emit) async {
    try {
      emit(SignupInProgress());
      var employee =
          await firestoreRepository.getEmployerFromNumber(event.employerNumber);
      if (employee == null) {
        emit(SignupFailed(
          'Employer Number is not valid, Contact your Organization',
        ));
        return;
      }
      // if (event.employerNumber != 0) {
      //   var employee = await firestoreRepository
      //       .getEmployerFromNumber(event.employerNumber);
      //   if (employee == null) {
      //     emit(SignupFailed(
      //       'Employer Number is not valid, Contact your Organization',
      //     ));
      //     return;
      //   }
      // }

      User? user =
          await userRepository.createUserWithEmail(event.email, event.password);

      if (user != null) {
        await firestoreRepository.saveUserCredentials(
            event.email, event.firstName, event.lastName, event.employerNumber);
      }
      var teea = await firebaseStorageRepository.uploadImage(event.image);
      print(teea);
      await userRepository.loginWithEmail(event.email, event.password);

      await firestoreRepository.saveUsersCredentialslocal();

      emit(SignupSuccessful(user));
    } catch (error) {
      emit(SignupFailed(
        error.toString(),
      ));
    }
  }
}
