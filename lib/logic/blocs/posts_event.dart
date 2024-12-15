part of 'posts_bloc.dart';

@immutable
sealed class PostsEvent {
  const PostsEvent();
}

class GetAllPosts extends PostsEvent {
  const GetAllPosts();
}

class CreatePost extends PostsEvent {
  final Post post;
  const CreatePost(this.post);
}

class UpdatePost extends PostsEvent {
  final int index;
  final Post post;

  const UpdatePost(this.index, this.post);
}