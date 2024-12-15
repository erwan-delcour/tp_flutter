import '../models/post.dart';
import 'posts_data_source.dart';

class FakePostsDataSource implements PostsDataSource {
  final List<Post> _fakePosts = [
    Post(id: '1', title: 'Post 1', description: 'Description of Post 1'),
    Post(id: '2', title: 'Post 2', description: 'Description of Post 2'),
    Post(id: '3', title: 'Post 3', description: 'Description of Post 3'),
  ];

  @override
  Future<List<Post>> getAllPosts() async {
    await Future.delayed(const Duration(seconds: 1));
    return _fakePosts;
  }

  @override
  Future<Post> createPost(Post postToAdd) async {
    await Future.delayed(const Duration(seconds: 1));
    _fakePosts.add(postToAdd);
    return postToAdd;
  }

  @override
  Future<Post> updatePost(Post newPost) async {
    await Future.delayed(const Duration(seconds: 1));
    final index = _fakePosts.indexWhere((post) => post.id == newPost.id);
    if (index != -1) {
      _fakePosts[index] = newPost;
    }
    return newPost;
  }
}
