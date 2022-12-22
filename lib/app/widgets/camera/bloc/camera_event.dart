part of 'camera_bloc.dart';

abstract class CameraEvent extends Equatable {
  const CameraEvent();

  @override
  List<Object> get props => [];
}

class CaptureImage extends CameraEvent {}

class ClearImage extends CameraEvent {}

class ConfirmImage extends CameraEvent {}

class InitCamera extends CameraEvent {}
