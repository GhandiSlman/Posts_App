import 'package:_/core/error/failure.dart';
import 'package:_/core/strings/failure.dart';
import 'package:_/features/posts/domain/use_cases/get_all_post.dart';
import 'package:_/features/posts/prestations/bloc/posts/post_state.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'post_event.dart';

class PostBloc extends Bloc<PostEvent, PostState> {
  String mapFailureToMessage(Failure failure) {
    switch (failure.runtimeType) {
      case ServerFailure:
        return SERVER_FAILURE_MESSAGE;
      case EmptyCacheFailure:
        return EMPTY_CACHE_FAILURE_MESSAGE;
      case OfflineFailure:
        return OFFLINE_FAILURE_MESSAGE;
      default:
        return 'UnExpected error, please try again.';
    }
  }

  GetAllPostUseCase getAllPost;
  PostBloc({required this.getAllPost}) : super(PostInitial()) {
    on<PostEvent>((event, emit) async {
      if (event is GetAllPostEvent || event is RefreshPostsEvent) {
        
        emit(LoadingPostsState());
        final failureOrPosts = await getAllPost();
        failureOrPosts.fold((failure) {
          emit(ErrorPostState(message: mapFailureToMessage(failure)));
        }, (posts) {
          emit(LoadedPostsState(post: posts));
        });
      }
    });
  }
}
