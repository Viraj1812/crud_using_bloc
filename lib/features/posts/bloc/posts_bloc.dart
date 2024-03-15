import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:crud_using_bloc/features/posts/models/post_data_ui_model.dart';
import 'package:crud_using_bloc/features/posts/repos/posts_repo.dart';
import 'package:flutter/material.dart';

part 'posts_event.dart';
part 'posts_state.dart';

class PostsBloc extends Bloc<PostsEvent, PostsState> {
  PostsBloc() : super(PostsInitial()) {
    on<PostsInitialFetchEvent>(postsInitialFetchEvent);
    on<PostAddEvent>(postAddEvent);
  }

  FutureOr<void> postsInitialFetchEvent(PostsInitialFetchEvent event, Emitter<PostsState> emit) async {
    emit(PostFeatchingLoadingState());
    List<PostDataUiModel> posts = await PostsRepo.getPosts();
    emit(PostFetchingSuccessfulState(posts: posts));
  }

  FutureOr<void> postAddEvent(PostAddEvent event, Emitter<PostsState> emit) async {
    bool isAdded = await PostsRepo.addPosts();
    if (isAdded) {
      emit(PostAddSuccessState(message: "Post added successfully"));
    } else {
      emit(PostAddErrorState(errorMessage: "Failed to add post"));
    }
  }
}
