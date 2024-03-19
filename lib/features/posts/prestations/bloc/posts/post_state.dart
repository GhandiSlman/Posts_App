
import 'package:_/features/posts/domain/entities/post.dart';
import 'package:equatable/equatable.dart';

sealed class PostState extends Equatable {
  const PostState();

  @override
  List<Object> get props => [];
}

final class PostInitial extends PostState {}

class LoadingPostsState extends PostState {}

class LoadedPostsState extends PostState {
  final List<Post> post;

  const LoadedPostsState({required this.post});
  @override
  List<Object> get props => [post];
}

class ErrorPostState extends PostState {
  final String message;

  ErrorPostState({required this.message});
  @override
  List<Object> get props => [message];
}
