part of 'upload_image_cubit.dart';

abstract class UploadImageState extends Equatable {
  const UploadImageState();

  @override
  List<Object> get props => [];
}

class UploadImageInitial extends UploadImageState {}

class UploadImageLoading extends UploadImageState {}

class UploadImageSuccess extends UploadImageState {
  final String fileUrl;

  const UploadImageSuccess(this.fileUrl);
  @override
  List<Object> get props => [fileUrl];
}

class UploadImageFailed extends UploadImageState {
  final String message;

  const UploadImageFailed(this.message);
  @override
  List<Object> get props => [message];
}
