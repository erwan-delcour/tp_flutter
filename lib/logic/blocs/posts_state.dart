part of 'posts_bloc.dart';

enum PostsStatus {
  initial,
  loading,
  success,
  creating,
  updating,
  empty,
  error,
}

class PostsState {
  final PostsStatus status;
  final List<Post> posts;
  final String? exception;

  const PostsState({
    this.status = PostsStatus.initial,
    this.posts = const [],
    this.exception,
  });

  PostsState copyWith({
    PostsStatus? status,
    List<Post>? posts,
    String? exception,
  }) {
    return PostsState(
      status: status ?? this.status,
      posts: posts ?? this.posts,
      exception: exception ?? this.exception,
    );
  }
}
