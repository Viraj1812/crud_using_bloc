import 'package:crud_using_bloc/features/posts/bloc/posts_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PostPage extends StatefulWidget {
  const PostPage({super.key});

  @override
  State<PostPage> createState() => _PostPageState();
}

class _PostPageState extends State<PostPage> {
  final PostsBloc _postsBloc = PostsBloc();

  @override
  void initState() {
    _postsBloc.add(PostsInitialFetchEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text('Posts Page')),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            _postsBloc.add(PostAddEvent());

            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Post added successfully'),
              ),
            );
          },
          child: const Icon(Icons.add),
        ),
        body: BlocConsumer<PostsBloc, PostsState>(
          bloc: _postsBloc,
          listenWhen: (previous, current) => current is PostsActionState,
          buildWhen: (previous, current) => current is! PostsActionState,
          listener: (context, state) {},
          builder: (context, state) {
            switch (state.runtimeType) {
              case PostFeatchingLoadingState:
                return const Center(
                  child: CircularProgressIndicator(),
                );
              case PostFetchingSuccessfulState:
                final successState = (state as PostFetchingSuccessfulState);
                return ListView.builder(
                  itemCount: successState.posts.length,
                  itemBuilder: (context, index) {
                    return Container(
                      padding: const EdgeInsets.all(16),
                      margin: const EdgeInsets.all(16),
                      color: Colors.grey[200],
                      child: ListTile(
                        title: Text(successState.posts[index].title),
                        subtitle: Text(successState.posts[index].body),
                      ),
                    );
                  },
                );
              default:
                return const SizedBox();
            }
          },
        ));
  }
}
