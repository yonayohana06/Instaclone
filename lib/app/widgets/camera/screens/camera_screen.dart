import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:instaclone/app/widgets/camera/camera.dart';

class CameraScreen extends StatelessWidget {
  const CameraScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CameraBloc()..add(InitCamera()),
      child: _View(),
    );
  }
}

class _View extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          BlocConsumer<CameraBloc, CameraState>(
            listener: (context, state) {
              if (state is CameraCaptureConfirmed) {
                Navigator.pop(context, state.image);
              }
            },
            builder: (context, state) {
              if (state is CameraLoading) {
                return const Center(
                  child: Text('Loading...'),
                );
              }

              if (state is CameraCaptureSuccess) {
                return Center(
                  child: Image.file(state.image),
                );
              }

              return Builder(builder: (context) {
                if (context.read<CameraBloc>().cameraController == null) {
                  return const Center(
                    child: Text('Reading camera...'),
                  );
                }
                return CameraPreview(
                  context.read<CameraBloc>().cameraController!,
                );
              });
            },
          ),
          BlocBuilder<CameraBloc, CameraState>(
            builder: (context, state) {
              if (state is CameraCaptureSuccess) {
                return Align(
                  alignment: Alignment.bottomCenter,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          context.read<CameraBloc>().add(ClearImage());
                        },
                        child: const Text('Clear'),
                      ),
                      const SizedBox(width: 10),
                      ElevatedButton(
                        onPressed: () {
                          context.read<CameraBloc>().add(ConfirmImage());
                        },
                        child: const Text('Confirm'),
                      ),
                    ],
                  ),
                );
              }
              return Align(
                alignment: Alignment.bottomCenter,
                child: ElevatedButton(
                  onPressed: () {
                    context.read<CameraBloc>().add(CaptureImage());
                  },
                  child: const Text('Take Image'),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
