import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../data/models/post.dart';
import '../logic/blocs/posts_bloc.dart';

class PostCreateScreen extends StatelessWidget {
  final PostsBloc postsBloc;

  const PostCreateScreen({
    super.key,
    required this.postsBloc,
  });

  @override
  Widget build(BuildContext context) {
    final titleController = TextEditingController();
    final descriptionController = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: const Text("Create New Post"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: BlocConsumer<PostsBloc, PostsState>(
          bloc: postsBloc,
          listener: (context, state) {
            // Affiche le chargement lors de la création
            if (state.status == PostsStatus.creating) {
              showDialog(
                context: context,
                barrierDismissible: false,
                builder: (context) => const Center(
                  child: CircularProgressIndicator(),
                ),
              );
            }

            // Ferme la boîte de dialogue après succès ou erreur
            if (state.status == PostsStatus.success ||
                state.status == PostsStatus.error) {
              if (Navigator.canPop(context)) {
                Navigator.of(context, rootNavigator: true).pop();
              }

              if (state.status == PostsStatus.success) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text("Post successfully created!"),
                  ),
                );

                // Retour à la liste après succès
                if (Navigator.canPop(context)) {
                  Navigator.pop(context);
                }
              } else if (state.status == PostsStatus.error) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text("Error: ${state.exception}"),
                    backgroundColor: Colors.red,
                  ),
                );
              }
            }
          },
          builder: (context, state) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Title",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                TextField(
                  controller: titleController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: "Enter post title",
                  ),
                ),
                const SizedBox(height: 16),
                const Text(
                  "Description",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                TextField(
                  controller: descriptionController,
                  maxLines: 5,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: "Enter post description",
                  ),
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () {
                    final title = titleController.text.trim();
                    final description = descriptionController.text.trim();

                    if (title.isEmpty || description.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text("Please fill out all fields."),
                        ),
                      );
                      return;
                    }

                    final newPost = Post(
                      id: DateTime.now().millisecondsSinceEpoch.toString(),
                      title: title,
                      description: description,
                    );

                    // Déclenche l'événement de création
                    postsBloc.add(CreatePost(newPost));
                  },
                  child: const Text("Create Post"),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}