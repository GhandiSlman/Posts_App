import 'package:_/features/posts/domain/entities/post.dart';
import 'package:_/features/posts/prestations/pages/post_detail_page.dart';
import 'package:flutter/material.dart';

class PostListWidget extends StatelessWidget {
  final List<Post>  posts;
  const PostListWidget({super.key, required this.posts});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
        itemBuilder: (context, index) {
          return ListTile(
            leading: Text(
              posts[index].id.toString(),
              style: const TextStyle(fontSize: 15),
            ),
            title: Text(
              posts[index].title,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            subtitle: Text(
              posts[index].body,
              style: const TextStyle(fontSize: 15),
            ),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (_) => PostDetailPage(post: posts[index])));
            },
          );
        },
        separatorBuilder: (context, index) => const Divider(
              indent: 15,
              endIndent: 15,
            ),
        itemCount: posts.length);
  }
}
