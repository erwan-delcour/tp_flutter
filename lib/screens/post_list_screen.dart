import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../logic/blocs/posts_bloc.dart';

class PostListScreen extends StatelessWidget {
  const PostListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("List of Posts"),
      ),
      body: BlocBuilder<PostsBloc, PostsState>(
        builder: (context, state) {
          if (state.status == PostsStatus.loading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state.status == PostsStatus.success) {
            if (state.posts.isEmpty) {
              return const Center(
                child: Text(
                  "No posts available.",
                  style: TextStyle(fontSize: 18),
                ),
              );
            }

            return ListView.builder(
              itemCount: state.posts.length,
              itemBuilder: (context, index) {
                final post = state.posts[index];
                return Card(
                  margin: const EdgeInsets.all(8.0),
                  child: ListTile(
                    title: Text(
                      post.title,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    subtitle: Text(post.description),
                    trailing: const Icon(Icons.arrow_forward_ios),
                    onTap: () => Navigator.pushNamed(
                      context,
                      '/postDetail',
                      arguments: {'post': post, 'index': index},
                    ),
                  ),
                );
              },
            );
          } else if (state.status == PostsStatus.error) {
            return Center(
              child: Text(
                "Error: ${state.exception}",
                style: const TextStyle(color: Colors.red, fontSize: 18),
              ),
            );
          }

          return const Center(child: Text("Unexpected state."));
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () => Navigator.pushNamed(context, '/createPost'),
      ),
    );
  }
}