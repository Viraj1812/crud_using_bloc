part of 'posts_bloc.dart';

@immutable
sealed class PostsState {}

sealed class PostsActionState extends PostsState {}

final class PostsInitial extends PostsState {}

class PostFeatchingLoadingState extends PostsState {}

class PostFetchingSuccessfulState extends PostsState {
  final List<PostDataUiModel> posts;
  PostFetchingSuccessfulState({required this.posts});
}

class PostFetchingFailedState extends PostsState {
  final String errorMessage;
  PostFetchingFailedState({required this.errorMessage});
}

class PostAddSuccessState extends PostsActionState {
  final String message;
  PostAddSuccessState({required this.message});
}

class PostAddErrorState extends PostsActionState {
  final String errorMessage;
  PostAddErrorState({required this.errorMessage});
}
