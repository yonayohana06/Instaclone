part of 'post_list_bloc.dart';

abstract class PostListEvent extends Equatable {
  const PostListEvent();

  @override
  List<Object> get props => [];
}

class GetPosts extends PostListEvent {}

class RefreshPosts extends PostListEvent {}
