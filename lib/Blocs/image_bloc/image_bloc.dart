import 'dart:async';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../Repositories/firebase_storage_repository.dart';
import '../../Repositories/firestore_repository.dart';

part 'image_event.dart';
part 'image_state.dart';

class ImageBloc extends Bloc<ImageEvent, ImageState> {
  FirestoreRepository firestoreRepository;
  FirebaseStorageRepository firebaseStorageRepository;
  ImageBloc(this.firestoreRepository, this.firebaseStorageRepository)
      : super(ImageInitial()) {
    on<UpdateImageButtonPressed>(_handleUpdateImage);
  }

  FutureOr<void> _handleUpdateImage(
      UpdateImageButtonPressed event, Emitter<ImageState> emit) async {
    try {
      emit(UpdateImageInProgress());
      await firebaseStorageRepository.updateImage(event.image);
      print("--> Wetin dey sup");
      await firestoreRepository
          .saveUsersCredentialslocal()
          .then((value) => emit(UpdateImageSuccessful()));
      emit(UpdateImageSuccessful());
    } catch (error) {
      emit(UpdateImageFailed(error.toString()));
    }
  }
}
