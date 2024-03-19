import 'package:_/core/error/exeptions.dart';
import 'package:_/core/error/failure.dart';
import 'package:_/core/network/network_info.dart';
import 'package:_/features/posts/data/data_sources/local_data_source.dart';
import 'package:_/features/posts/data/data_sources/remote_data_source.dart';
import 'package:_/features/posts/data/models/post_model.dart';
import 'package:_/features/posts/domain/entities/post.dart';
import 'package:_/features/posts/domain/repositories/post_repository.dart';
import 'package:dartz/dartz.dart';

typedef DeleteOrUpdateOrAddPost = Future<Unit> Function();

class PostRepoSitoryImp implements PostRepository {
  final RemoteDataSource remoteDataSource;
  final LocalDataSource localDataSource;
  final NetworkInfo networkInfo;

  PostRepoSitoryImp({
    required this.remoteDataSource,
    required this.localDataSource,
    required this.networkInfo,
  });

  @override 
  Future<Either<Failure, List<Post>>> getAllPosts() async {
    if (await networkInfo.isConnected) {
      try {
        final remotePosts = await remoteDataSource.getAllPosts();
        localDataSource.cachPosts(remotePosts);
        return Right(remotePosts);
      } on ServerExeption {
        return Left(ServerFailure());
      }
    } else {
      try {
        final localPosts =  await localDataSource.getChachedPosts();
        return Right(localPosts);
      } on EmtpyCacheExeption {
        return Left(EmptyCacheFailure());
      }
    }
  }

  @override
  Future<Either<Failure, Unit>> addPost(Post post) async {
    final postModel =
        PostModel(title: post.title, body: post.body);
    return await getMessage(() => remoteDataSource.addPost(postModel));
  }

  @override
  Future<Either<Failure, Unit>> deletePost(int postId) async {
    return await getMessage(() => remoteDataSource.deletePost(postId));
  }

  @override
  Future<Either<Failure, Unit>> updatePost(Post post) async {
    final postModel =
        PostModel(id: post.id, title: post.title, body: post.body);
    return await getMessage(() => remoteDataSource.updatePost(postModel));
  }

  Future<Either<Failure, Unit>> getMessage(
      DeleteOrUpdateOrAddPost deleteOrUpdateOrAddPost) async {
    if (await networkInfo.isConnected) {
      try {
        await deleteOrUpdateOrAddPost();
        return const Right(unit);
      } on ServerExeption {
        return Left(ServerFailure());
      }
    } else {
      return Left(OfflineFailure());
    }
  }
}
