import 'package:_/features/posts/domain/entities/post.dart';
import 'package:_/features/posts/prestations/widgets/post_detail_widget.dart';
import 'package:flutter/material.dart';

class PostDetailPage extends StatelessWidget {
  final Post post;
  const PostDetailPage({super.key, required this.post});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buillAppBar(),
      body: _buildBody(),
    );
  }

  AppBar _buillAppBar() {
    return AppBar(
      title: const Text('Post Detail'),
      backgroundColor: Colors.lightGreen[600],
    );
  }

  Widget _buildBody() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: PostDetailWidget(
          post: post,
        ),
      ),
    );
  }
}
