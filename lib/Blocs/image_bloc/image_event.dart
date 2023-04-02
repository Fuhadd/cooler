part of 'image_bloc.dart';

abstract class ImageEvent extends Equatable {
  const ImageEvent();

  @override
  List<Object> get props => [];
}

class UpdateImageButtonPressed extends ImageEvent {
  File image;

  UpdateImageButtonPressed(this.image);

  @override
  List<Object> get props => [];
}
