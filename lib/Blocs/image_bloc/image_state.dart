part of 'image_bloc.dart';

abstract class ImageState extends Equatable {
  const ImageState();

  @override
  List<Object> get props => [];
}

class ImageInitial extends ImageState {}

class UpdateImageInProgress extends ImageState {}

class UpdateImageSuccessful extends ImageState {
  @override
  List<Object> get props => [];
}

class UpdateImageFailed extends ImageState {
  String message;

  UpdateImageFailed(this.message);
}
