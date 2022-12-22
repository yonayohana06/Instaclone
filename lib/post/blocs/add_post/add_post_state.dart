part of 'add_post_bloc.dart';

abstract class AddPostState extends Equatable {
  const AddPostState();

  @override
  List<Object> get props => [];
}

class AddPostInitial extends AddPostState {}

class AddPostLoading extends AddPostState {}

class AddPostFailed extends AddPostState {
  final String message;

  const AddPostFailed(this.message);

  @override
  List<Object> get props => [message];
}

class AddPostSuccess extends AddPostState {}
