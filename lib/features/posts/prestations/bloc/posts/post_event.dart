part of 'post_bloc.dart';

sealed class PostEvent extends Equatable {
  const PostEvent();

  @override
  List<Object> get props => [];
}

class GetAllPostEvent extends PostEvent{}

class RefreshPostsEvent extends PostEvent{}