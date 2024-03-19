import 'dart:convert';
import 'package:_/core/error/exeptions.dart';
import 'package:_/features/posts/data/models/post_model.dart';
import 'package:dartz/dartz.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class LocalDataSource {
  Future<List<PostModel>> getChachedPosts();
  Future<Unit> cachPosts(List<PostModel> postModel);
}

class LocalDataSaourceImp implements LocalDataSource {
  SharedPreferences sharedPreferences;
  LocalDataSaourceImp({required this.sharedPreferences});
  @override
  Future<Unit> cachPosts(List<PostModel> postModels) {
    List postModeltoJson = postModels
        .map<Map<String, dynamic>>((postModel) => postModel.toJson())
        .toList();
    sharedPreferences.setString('CACHED_POSTS', json.encode(postModeltoJson));
    return Future.value(unit);
  }

  @override
  Future<List<PostModel>> getChachedPosts() {
    final jsonString = sharedPreferences.getString('CACHED_POSTS');
    if (jsonString != null) {
      List decodeJsonData = json.decode(jsonString);
      List<PostModel> jsonToPostModel = decodeJsonData
          .map<PostModel>((jsonPostModel) => PostModel.fromJson(jsonPostModel))
          .toList();
      return Future.value(jsonToPostModel);
    } else {
      throw EmtpyCacheExeption();
    }
  }
}
