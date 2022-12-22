import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:instaclone/post/models/post_model.dart';
import 'package:instaclone/post/post_repository.dart';

part 'add_post_event.dart';
part 'add_post_state.dart';

class AddPostBloc extends Bloc<AddPostEvent, AddPostState> {
  AddPostBloc() : super(AddPostInitial()) {
    on<SubmitAddPost>((event, emit) async {
      emit(AddPostLoading());
      final post = Post(
        uid: uid.text,
        avatarUrl: avatarUrl.text,
        username: username.text,
        imageUrl: imageUrl.text,
        caption: caption.text,
      );
      await postRepo.create(post).then((value) {
        emit(AddPostSuccess());
      }).onError((error, stackTrace) {
        emit(AddPostFailed(error.toString()));
      });
    });

    on<Initialize>((event, emit) {
      final auth = FirebaseAuth.instance;
      final user = auth.currentUser;

      uid.text = user!.uid;
      username.text = user.email!;
      avatarUrl.text = 'https://placeimg.com/100/100';
      imageUrl.text = 'https://placeimg.com/600/600/people';
      caption.text = 'Halo';
    });
  }

  final uid = TextEditingController();
  final avatarUrl = TextEditingController();
  final username = TextEditingController();
  final imageUrl = TextEditingController();
  final caption = TextEditingController();

  final postRepo = PostRepository();
}
