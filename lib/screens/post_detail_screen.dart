import 'package:flutter/material.dart';

import '../data/models/post.dart';

class PostDetailScreen extends StatefulWidget {
  final Post post;
  final int index;

  const PostDetailScreen({
    super.key,
    required this.post,
    required this.index,
  });

  @override
  State<PostDetailScreen> createState() => _PostDetailScreenState();
}

class _PostDetailScreenState extends State<PostDetailScreen> {
  late Post post;

  @override
  void initState() {
    super.initState();
    post = widget.post;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(post.title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              post.title,
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 10),
            Text(
              post.description,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.edit),
        onPressed: () async {
          final updatedData = await Navigator.pushNamed(
            context,
            '/editPost',
            arguments: {'post': post, 'index': widget.index},
          ) as Map<String, dynamic>?;

          if (updatedData != null && updatedData['post'] != null) {
            setState(() {
              post = updatedData['post'];
            });
          }
        },
      ),
    );
  }
}