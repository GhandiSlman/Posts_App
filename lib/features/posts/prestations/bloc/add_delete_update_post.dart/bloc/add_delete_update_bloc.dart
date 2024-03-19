import 'package:_/core/error/failure.dart';
import 'package:_/core/strings/failure.dart';
import 'package:_/core/strings/messages.dart';
import 'package:_/features/posts/domain/entities/post.dart';
import 'package:_/features/posts/domain/use_cases/add_post.dart';
import 'package:_/features/posts/domain/use_cases/delete_post.dart';
import 'package:_/features/posts/domain/use_cases/update_post.dart';
import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

part 'add_delete_update_event.dart';
part 'add_delete_update_state.dart';

class AddDeleteUpdateBloc
    extends Bloc<AddDeleteUpdateEvent, AddDeleteUpdateState> {
  AddDeleteUpdateState eitherSuccessMessageOrErrorState(
      Either<Failure, Unit> either, String message) {
    return either.fold((failure) {
      return ErrorAddUpdateDeleteState(message: mapFailureToMessage(failure));
    }, (_) {
      return SuccessAddUpdateDeleteState(message: message);
    });
  }

  String mapFailureToMessage(Failure failure) {
    switch (failure.runtimeType) {
      case ServerFailure:
        return SERVER_FAILURE_MESSAGE;
      case OfflineFailure:
        return OFFLINE_FAILURE_MESSAGE;
      default:
        return 'UnExpected error, please try again.';
    }
  }

  final AddPostUseCase addPostUseCase;
  final UpdatePostUseCase updatePostUseCase;
  final DeletePostUseCase deletePostUseCase;
  AddDeleteUpdateBloc(
      {required this.addPostUseCase,
      required this.updatePostUseCase,
      required this.deletePostUseCase})
      : super(AddDeleteUpdateInitial()) {
    on<AddDeleteUpdateEvent>((event, emit) async {
      if (event is addPostEvent) {
        emit(LoadingAddUpdateDeleteState());

        final failureOrSuccess = await addPostUseCase(event.post);

        emit(eitherSuccessMessageOrErrorState(
            failureOrSuccess, ADD_SUCCESS_MESSAGE));
      } else if (event is updatePostEvent) {
        emit(LoadingAddUpdateDeleteState());

        final failureOrSuccess = await updatePostUseCase(event.post);
        emit(eitherSuccessMessageOrErrorState(
            failureOrSuccess, UPDATE_SUCCESS_MESSAGE));
      } else if (event is deletePostEvent) {
        emit(LoadingAddUpdateDeleteState());

        final failureOrSuccess = await deletePostUseCase(event.postId);
        emit(eitherSuccessMessageOrErrorState(
            failureOrSuccess, DELETE_SUCCESS_MESSAGE));
      }
    });
  }
}
