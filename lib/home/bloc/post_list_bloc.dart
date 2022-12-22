import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:instaclone/post/models/post_model.dart';
import 'package:instaclone/post/post_repository.dart';

part 'post_list_event.dart';
part 'post_list_state.dart';

class PostListBloc extends Bloc<PostListEvent, PostListState> {
  PostListBloc() : super(PostListInitial()) {
    on<GetPosts>((event, emit) async {
      emit(PostListLoading());
      await postRepo.all().then((posts) {
        emit(PostListLoaded(posts));
      }).onError((error, stackTrace) {
        emit(PostListLoaded([]));
      });
    });
  }
  final postRepo = PostRepository();
}
