import 'package:_/core/util/snackbar_message.dart';
import 'package:_/core/widgets/loading_widget.dart';
import 'package:_/features/posts/domain/entities/post.dart';
import 'package:_/features/posts/prestations/bloc/add_delete_update_post.dart/bloc/add_delete_update_bloc.dart';
import 'package:_/features/posts/prestations/pages/posts_page.dart';

import 'package:_/features/posts/prestations/widgets/form_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddUpdatePostPage extends StatelessWidget {
  final Post? post;
  final bool isUpdatePost;
  const AddUpdatePostPage({super.key, this.post, required this.isUpdatePost});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(),
      body: _buildBody(),
    
    );
  }

  AppBar _appBar() {
    return AppBar(
      title: Text(isUpdatePost ? 'Update Post' : 'Add Post'),
      backgroundColor: Colors.lightGreen[600],
      centerTitle: true,
    );
  }

  Widget _buildBody() {
    return Center(
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: BlocConsumer<AddDeleteUpdateBloc,AddDeleteUpdateState>(builder: (context, state) {
            if (state is LoadingAddUpdateDeleteState) {
              return const LoadingWidget();
            }
            return  FormWidget(isUpdatePost: isUpdatePost, post: isUpdatePost? post: null);
          }, listener: (context, state) {
            if (state is SuccessAddUpdateDeleteState) {
              SnackBarMessage()
                  .showSnackBar(message: state.message, context: context);
              Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(builder: (_) => const PostsPage()),
                  (route) => false);
            } else if (state is ErrorAddUpdateDeleteState) {
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Text(
                  state.message,
                  style: const TextStyle(color: Colors.white),
                ),
                backgroundColor: Colors.grey,
              ));
            }
          }),
        ),
      ),
    );
  }
}
