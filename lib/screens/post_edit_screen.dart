import 'package:flutter/material.dart';

import '../data/models/post.dart';
import '../logic/blocs/posts_bloc.dart';

class PostEditScreen extends StatelessWidget {
  final Post post;
  final int index;
  final PostsBloc postsBloc;

  const PostEditScreen({
    super.key,
    required this.post,
    required this.index,
    required this.postsBloc,
  });

  @override
  Widget build(BuildContext context) {
    final titleController = TextEditingController(text: post.title);
    final descriptionController =
        TextEditingController(text: post.description);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Edit Post"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
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
                final updatedTitle = titleController.text.trim();
                final updatedDescription =
                    descriptionController.text.trim();

                // Vérifie si les champs sont vides
                if (updatedTitle.isEmpty || updatedDescription.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text("Please fill out all fields."),
                    ),
                  );
                  return;
                }

                // Crée un nouveau post mis à jour
                final updatedPost = Post(
                  id: post.id,
                  title: updatedTitle,
                  description: updatedDescription,
                );

                // Envoie l'événement de mise à jour
                postsBloc.add(UpdatePost(index, updatedPost));

                // Retourne le post modifié
                Navigator.pop(context, {'post': updatedPost, 'index': index});

                // Affiche le message de succès
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text("Post successfully updated!"),
                  ),
                );
              },
              child: const Text("Update Post"),
            ),
          ],
        ),
      ),
    );
  }
}