// ignore_for_file: must_be_immutable
import 'package:_/features/posts/prestations/bloc/add_delete_update_post.dart/bloc/add_delete_update_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DeleteDialogWidget extends StatelessWidget {
  int postId;
  DeleteDialogWidget({super.key, required this.postId});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Are you sure ?'),
      actions: [
        TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text('No',style: TextStyle(color: Colors.black))),
        TextButton(
            onPressed: () {
              BlocProvider.of<AddDeleteUpdateBloc>(context)
                  .add(deletePostEvent(postId: postId));
            },
            child: Text('Yes',style: TextStyle(color: Colors.lightGreen[600]),))
      ],
    );
  }
}
