import 'package:_/core/widgets/loading_widget.dart';
import 'package:_/features/posts/prestations/bloc/posts/post_bloc.dart';
import 'package:_/features/posts/prestations/bloc/posts/post_state.dart';
import 'package:_/features/posts/prestations/pages/add_update_post_page.dart';
import 'package:_/features/posts/prestations/widgets/floating_btn.dart';
import 'package:_/features/posts/prestations/widgets/message_display_widget.dart';
import 'package:_/features/posts/prestations/widgets/post_list_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PostsPage extends StatelessWidget {
  const PostsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: buildBody(),
      floatingActionButton : FloatingBtn(
        backGroundColor: Colors.lightGreen[600]!,
        onPressed: (){
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (_) => const AddUpdatePostPage(
                      isUpdatePost: false,
                    )));
        },
        icon: const Icon(Icons.add),
      ),
    );
  }

  AppBar _buildAppBar() => AppBar(
        title: const Text(
          'Posts',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.lightGreen[600],
        centerTitle: true,
      );

  Widget buildBody() {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: BlocBuilder<PostBloc, PostState>(builder: (context, state) {
        if (state is LoadingPostsState) {
          return const LoadingWidget();
        } else if (state is LoadedPostsState) {
          return RefreshIndicator(
              color: Colors.blueAccent,
              onRefresh: () => _onRefresh(context),
              child: PostListWidget(posts: state.post));
        } else if (state is ErrorPostState) {
          return MessageDisplayWidget(message: state.message);
        }
        return const LoadingWidget();
      }),
    );
  }
  Future<void> _onRefresh(BuildContext context) async {
    return BlocProvider.of<PostBloc>(context).add(RefreshPostsEvent());
  }
}
