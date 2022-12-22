import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part 'upload_image_state.dart';

class UploadImageCubit extends Cubit<UploadImageState> {
  UploadImageCubit() : super(UploadImageInitial());

  Future<void> upload(File file) async {
    emit(UploadImageLoading());

    ///prepare image
    final fileName = file.path.split('/').last;

    final fs = FirebaseStorage.instance;
    final imageRef = fs.ref('images/$fileName');
    await imageRef.putFile(file).then((p0) async {
      final url = await p0.ref.getDownloadURL();
      emit(UploadImageSuccess(url));
    }).onError((error, stackTrace) {
      emit(UploadImageFailed(error.toString()));
    });
  }
}
