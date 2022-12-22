part of 'post_list_bloc.dart';

abstract class PostListState extends Equatable {
  const PostListState();

  @override
  List<Object> get props => [];
}

class PostListInitial extends PostListState {}

class PostListLoading extends PostListState {}

class PostListLoaded extends PostListState {
  final List<Post> posts;

  const PostListLoaded(this.posts);
  @override
  List<Object> get props => [posts];
}
