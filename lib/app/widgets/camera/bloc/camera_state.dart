part of 'camera_bloc.dart';

abstract class CameraState extends Equatable {
  const CameraState();

  @override
  List<Object> get props => [];
}

class CameraInitial extends CameraState {}

class CameraLoading extends CameraState {}

class CameraLoaded extends CameraState {}

class CameraCaptureSuccess extends CameraState {
  final File image;

  const CameraCaptureSuccess(this.image);
  @override
  List<Object> get props => [image];
}

class CameraCaptureFailed extends CameraState {
  final File message;

  const CameraCaptureFailed(this.message);
  @override
  List<Object> get props => [message];
}

class CameraCaptureConfirmed extends CameraState {
  final File image;

  const CameraCaptureConfirmed(this.image);
  @override
  List<Object> get props => [image];
}
