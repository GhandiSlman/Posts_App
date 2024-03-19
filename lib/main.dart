import 'package:_/features/posts/prestations/bloc/add_delete_update_post.dart/bloc/add_delete_update_bloc.dart';
import 'package:_/features/posts/prestations/bloc/posts/post_bloc.dart';
import 'package:_/features/posts/prestations/pages/posts_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'injection_container.dart' as di;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
 
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider(create: (_) => di.sl<PostBloc>()..add(GetAllPostEvent())),
          BlocProvider(create: (_) => di.sl<AddDeleteUpdateBloc>()),
        ],
        child: MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Flutter Demo',
            theme: ThemeData(),
            home: const PostsPage()));
  }
}
