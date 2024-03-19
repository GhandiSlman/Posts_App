import 'package:_/core/error/failure.dart';
import 'package:_/features/posts/domain/repositories/post_repository.dart';
import 'package:dartz/dartz.dart';

class DeletePostUseCase {
  final PostRepository repository;

  DeletePostUseCase(this.repository);

  Future<Either<Failure, Unit>> call(int PostID) async {
    return await repository.deletePost(PostID);
  }
}
