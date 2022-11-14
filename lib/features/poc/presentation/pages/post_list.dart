import 'package:flutter/material.dart';

import '../bloc/poc_bloc.dart';
import '../widgets/bottom_loader.dart';
import 'post_detail.dart';

class PostList extends StatelessWidget {
  const PostList({
    Key? key,
    required this.scrollController,
    required this.state,
  }) : super(key: key);

  final ScrollController scrollController;
  final PocLoaded state;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
      ),
      itemCount:
          state.hasReachedMax ? state.posts.length : state.posts.length + 1,
      controller: scrollController,
      itemBuilder: (context, index) {
        if (index >= state.posts.length) return BottomLoader();

        return ListTile(
          leading: Text(state.posts[index].id.toString()),
          title: Text(
            state.posts[index].title,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          subtitle: Text(
            state.posts[index].body,
            style: TextStyle(
              fontSize: 16,
            ),
          ),
          contentPadding:
              EdgeInsets.symmetric(horizontal: 10).copyWith(bottom: 10),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => PostDetail(post: state.posts[index]),
              ),
            );
          },
        );
      },
      /* separatorBuilder: (BuildContext context, int index) => Divider(
        thickness: 1,
      ), */
    );
  }
}
