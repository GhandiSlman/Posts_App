import 'package:_/core/error/failure.dart';
import 'package:_/features/posts/domain/repositories/post_repository.dart';
import 'package:dartz/dartz.dart';

import '../entities/post.dart';

class AddPostUseCase {
  final PostRepository repository;

  AddPostUseCase(this.repository);

  Future<Either<Failure, Unit>> call(Post post) async {
    return await repository.addPost(post);
  }
}
