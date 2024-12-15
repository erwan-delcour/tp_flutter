import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../data/models/post.dart';
import '../../data/repositories/posts_repository.dart';

part 'posts_event.dart';
part 'posts_state.dart';

class PostsBloc extends Bloc<PostsEvent, PostsState> {
  final PostsRepository postsRepository;

  PostsBloc({required this.postsRepository}) : super(const PostsState()) {
    on<GetAllPosts>((event, emit) async {
      emit(state.copyWith(status: PostsStatus.loading));

      try {
        final posts = await postsRepository.getAllPosts();
        emit(state.copyWith(
          posts: posts,
          status: PostsStatus.success,
        ));
      } catch (error) {
        emit(state.copyWith(
          status: PostsStatus.error,
          exception: error.toString(),
        ));
      }
    });

    on<CreatePost>((event, emit) async {
      emit(state.copyWith(status: PostsStatus.creating));

      try {
        await postsRepository.createPost(event.post);
        final posts = await postsRepository.getAllPosts();
        emit(state.copyWith(
          posts: posts,
          status: PostsStatus.success,
        ));
      } catch (error) {
        emit(state.copyWith(
          status: PostsStatus.error,
          exception: error.toString(),
        ));
      }
    });
    on<UpdatePost>((event, emit) async {
      emit(state.copyWith(status: PostsStatus.updating));

      try {
        final updatedPosts = List<Post>.from(state.posts);
        updatedPosts[event.index] = event.post;

        emit(state.copyWith(
          posts: updatedPosts,
          status: PostsStatus.success,
        ));
      } catch (error) {
        emit(state.copyWith(
          status: PostsStatus.error,
          exception: error.toString(),
        ));
      }
    });
  }
}
