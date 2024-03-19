import 'package:_/features/posts/domain/entities/post.dart';
import 'package:_/features/posts/prestations/bloc/add_delete_update_post.dart/bloc/add_delete_update_bloc.dart';
import 'package:_/features/posts/prestations/widgets/floating_btn.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FormWidget extends StatefulWidget {
  final bool isUpdatePost;
  final Post? post;
  const FormWidget({super.key, required this.isUpdatePost, this.post});

  @override
  State<FormWidget> createState() => _FormWidgetState();
}

class _FormWidgetState extends State<FormWidget> {
  final formKey = GlobalKey<FormState>();
  TextEditingController titleController = TextEditingController();
  TextEditingController bodyController = TextEditingController();
  @override
  void initState() {
    if (widget.isUpdatePost) {
      titleController.text = widget.post!.title;
      bodyController.text = widget.post!.body;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: TextFormField(
              controller: titleController,
              validator: (val) => val!.isEmpty ? "Title can't be empty" : null,
              decoration: const InputDecoration(
                  hintText: 'Title', border: OutlineInputBorder()),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: TextFormField(
              controller: bodyController,
              validator: (val) => val!.isEmpty ? "Body can't be empty" : null,
              decoration: const InputDecoration(
                  hintText: 'Body', border: OutlineInputBorder()),
              minLines: 6,
              maxLines: 6,
            ),
          ),
          const SizedBox(height: 100,),
          FloatingBtn(
            onPressed: () {
              final isValid = formKey.currentState!.validate();
              if (isValid) {
                final posts = Post(
                    id: widget.isUpdatePost ? widget.post!.id : null,
                    title: titleController.text,
                    body: bodyController.text);
                if (widget.isUpdatePost) {
                  BlocProvider.of<AddDeleteUpdateBloc>(context)
                      .add(updatePostEvent(post: posts));
                } else {
                  BlocProvider.of<AddDeleteUpdateBloc>(context)
                      .add(addPostEvent(post: posts));
                }
              }
            },
            icon: Icon(widget.isUpdatePost ? Icons.edit : Icons.done),
            backGroundColor: Colors.lightGreen[600]!,
          ),
        ],
      ),
    );
  }
}
