// ignore_for_file: camel_case_types

part of 'add_delete_update_bloc.dart';

sealed class AddDeleteUpdateEvent extends Equatable {
  const AddDeleteUpdateEvent();

  @override
  List<Object> get props => [];
}

class addPostEvent extends AddDeleteUpdateEvent {
  final Post post;

  addPostEvent({required this.post});

  @override
  List<Object> get props => [post];
}

class updatePostEvent extends AddDeleteUpdateEvent {
  final Post post;

  updatePostEvent({required this.post});
 
  @override
  List<Object> get props => [post];
}

class deletePostEvent extends AddDeleteUpdateEvent {
  final int postId;

  deletePostEvent({required this.postId});

  @override
  List<Object> get props => [postId];
}
