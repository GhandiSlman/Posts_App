import 'package:_/core/error/failure.dart';
import 'package:_/features/posts/domain/entities/post.dart';
import 'package:_/features/posts/domain/repositories/post_repository.dart';
import 'package:dartz/dartz.dart';

class GetAllPostUseCase {
  final PostRepository repository;

  GetAllPostUseCase(this.repository);

  Future<Either<Failure, List<Post>>> call() async {
    return await repository.getAllPosts();
  }
}
