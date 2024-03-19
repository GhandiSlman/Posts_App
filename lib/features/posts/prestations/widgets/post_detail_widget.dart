import 'package:_/core/util/snackbar_message.dart';
import 'package:_/core/widgets/loading_widget.dart';
import 'package:_/features/posts/domain/entities/post.dart';
import 'package:_/features/posts/prestations/bloc/add_delete_update_post.dart/bloc/add_delete_update_bloc.dart';
import 'package:_/features/posts/prestations/pages/add_update_post_page.dart';
import 'package:_/features/posts/prestations/pages/posts_page.dart';
import 'package:_/features/posts/prestations/widgets/detele_dialog_widget.dart';
import 'package:_/features/posts/prestations/widgets/floating_btn.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PostDetailWidget extends StatelessWidget {
  final Post post;
  const PostDetailWidget({super.key, required this.post});

  @override
  Widget build(BuildContext context) {
    void deleteDialog(BuildContext context) {
      showDialog(
          context: context,
          builder: (context) {
            return BlocConsumer<AddDeleteUpdateBloc, AddDeleteUpdateState>(
                builder: (context, state) {
              if (state is LoadingAddUpdateDeleteState) {
                return AlertDialog(
                  title: LoadingWidget(),
                );
              }
              return DeleteDialogWidget(postId: post.id!);
            }, listener: (context, state) {
              if (state is SuccessAddUpdateDeleteState) {
                SnackBarMessage()
                    .showSnackBar(message: state.message, context: context);
                Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(builder: (_) => const PostsPage()),
                    (route) => false);
              } else if (state is ErrorAddUpdateDeleteState) {
                Navigator.of(context).pop();
                SnackBarMessage()
                    .showSnackBar(message: state.message, context: context);
              }
            });
          });
    }

    return Padding(
      padding: const EdgeInsets.all(8),
      child: Column(
        children: [
          Text(
            post.title,
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const Divider(
            height: 50,
          ),
          Text(
            post.body,
            style: const TextStyle(fontSize: 15),
          ),
          const Divider(
            height: 50,
          ),
          const SizedBox(
            height: 300,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              FloatingBtn(
                  herTag: 'editBtn',
                  backGroundColor: Colors.lightGreen[600]!,
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (_) => AddUpdatePostPage(
                                isUpdatePost: true,
                                post: post,
                              )),
                    );
                  },
                  icon: const Icon(Icons.edit, color: Colors.black)),
              FloatingBtn(
                  herTag: 'deleteBtn',
                  backGroundColor: Colors.red,
                  onPressed: () {
                    deleteDialog(context);
                  },
                  icon: const Icon(
                    Icons.delete_outline,
                    color: Colors.black,
                  )),
            ],
          )
        ],
      ),
    );
  }
}
