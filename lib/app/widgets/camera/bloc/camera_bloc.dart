import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:path_provider/path_provider.dart' as path;

part 'camera_event.dart';
part 'camera_state.dart';

class CameraBloc extends Bloc<CameraEvent, CameraState> {
  CameraBloc() : super(CameraInitial()) {
    on<InitCamera>((event, emit) async {
      emit(CameraLoading());
      if (_cameraController == null) {
        await availableCameras().then((camera) {
          return camera.first;
        }).then((rearCamera) {
          return CameraController(
            rearCamera,
            ResolutionPreset.veryHigh,
            enableAudio: false,
            imageFormatGroup: Platform.isIOS
                ? ImageFormatGroup.bgra8888
                : ImageFormatGroup.jpeg,
          );
        }).then((controller) {
          _cameraController = controller;
        }).then((value) async {
          await _cameraController!.initialize();
          _cameraController!.setFlashMode(FlashMode.off);
        }).whenComplete(() {
          emit(CameraLoaded());
        });
      }
    });
    on<CaptureImage>((event, emit) async {
      emit(CameraLoading());

      // Prepare file image
      final docDir = await path.getApplicationDocumentsDirectory();
      final targetDir = '${docDir.path}/Picture';
      Directory(targetDir).create(recursive: true);

      // Handle camera take
      await _cameraController!.takePicture().then((cameraImageFile) async {
        final timestamp = DateTime.now().millisecondsSinceEpoch;
        final currentFilePath = cameraImageFile.path;

        /// xx/xxx/xx/wrhwrhwr.jpg
        final currentFileName = currentFilePath.split('/').last;
        final ext = currentFileName.split('.').last;
        final fileName = '$timestamp.$ext';

        final file = File('$targetDir/$fileName');
        final imageBytes = await cameraImageFile.readAsBytes();
        return await file.writeAsBytes(imageBytes);
      }).then((file) {
        _cameraController!.pausePreview();
        _capturedImage = file;
        emit(CameraCaptureSuccess(file));
      });
    });
    on<ClearImage>((event, emit) {
      emit(CameraLoading());
      _cameraController!.resumePreview();
      if (_capturedImage != null) {
        _capturedImage!.delete(recursive: true);
      }

      emit(CameraLoaded());
    });
    on<ConfirmImage>((event, emit) {
      emit(CameraLoading());
      emit(CameraCaptureConfirmed(_capturedImage!));
    });
  }
  CameraController? _cameraController;

  File? _capturedImage;

  CameraController? get cameraController => _cameraController;
}
