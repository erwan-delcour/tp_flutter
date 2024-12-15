import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'data/datasources/fake_posts_data_source.dart';
import 'data/repositories/posts_repository.dart';
import 'logic/blocs/posts_bloc.dart';
import 'screens/post_list_screen.dart';
import 'screens/post_detail_screen.dart';
import 'screens/post_create_screen.dart';
import 'screens/post_edit_screen.dart';
import 'data/models/post.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (context) => PostsRepository(FakePostsDataSource()),
      child: BlocProvider(
        create: (context) => PostsBloc(
          postsRepository: context.read<PostsRepository>(),
        )..add(const GetAllPosts()),
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          routes: {
            '/': (context) => const PostListScreen(),
            '/postDetail': (context) {
              final arguments = ModalRoute.of(context)!.settings.arguments
                  as Map<String, dynamic>;
              final post = arguments['post'] as Post;
              final index = arguments['index'] as int;
              return PostDetailScreen(post: post, index: index);
            },
            '/createPost': (context) {
              final postsBloc = BlocProvider.of<PostsBloc>(context);
              return PostCreateScreen(postsBloc: postsBloc);
            },
            '/editPost': (context) {
              final arguments = ModalRoute.of(context)!.settings.arguments
                  as Map<String, dynamic>;
              final post = arguments['post'] as Post;
              final index = arguments['index'] as int;
              final postsBloc = BlocProvider.of<PostsBloc>(context);
              return PostEditScreen(
                post: post,
                index: index,
                postsBloc: postsBloc,
              );
            },
          },
        ),
      ),
    );
  }
}