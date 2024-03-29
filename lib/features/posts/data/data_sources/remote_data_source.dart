import 'dart:convert';

import 'package:_/core/error/exeptions.dart';
import 'package:_/features/posts/data/models/post_model.dart';
import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;

abstract class RemoteDataSource {
  Future<List<PostModel>> getAllPosts();
  Future<Unit> addPost(PostModel postModel);
  Future<Unit> updatePost(PostModel postModel);
  Future<Unit> deletePost(int id);
}

const BASE_URL = 'https://jsonplaceholder.typicode.com';

class RemoteDataSourceImp implements RemoteDataSource {
  final http.Client client;

  RemoteDataSourceImp({required this.client});

  @override
  Future<List<PostModel>> getAllPosts() async {
    final response = await client.get(Uri.parse('$BASE_URL/posts/'),
        headers: {'Content-Type': 'application/json'});
    if (response.statusCode == 200) {
      final List responseBody = json.decode(response.body);
      final List<PostModel> postModel = responseBody
          .map<PostModel>((jsonPostModel) => PostModel.fromJson(jsonPostModel))
          .toList();
      return postModel;
    } else {
      throw ServerExeption();
    }
  }

  @override
  Future<Unit> addPost(PostModel postModel) async {
    final body = {
      'title': postModel.title,
      'body': postModel.body,
    };
    final response =
        await client.post(Uri.parse('$BASE_URL/posts/'), body: body);
    if (response.statusCode == 201) {
      return unit;
    } else {
      throw ServerExeption();
    }
  }

  @override
  Future<Unit> deletePost(int postId) async {
    final response = await client.delete(
        Uri.parse('$BASE_URL/posts/${postId.toString()}'),
        headers: {"Content-Type": "application/json"});
    if (response.statusCode == 200) {
      return unit;
    } else {
      throw ServerExeption();
    }
  }

  @override
  Future<Unit> updatePost(PostModel postModel) async {
    final postId = postModel.id.toString();
    final body = {
      'title': postModel.title,
      'body': postModel.body,
    };
    final response =
        await client.patch(Uri.parse('$BASE_URL/posts/$postId'), body: body);
    if (response.statusCode == 200) {
      return unit;
    } else {
      throw ServerExeption();
    }
  }
}
