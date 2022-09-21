import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/poc_bloc.dart';
import 'post_list.dart';

class PostPage extends StatelessWidget {
  const PostPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("List Posts"),
      ),
      body: BlocProvider(
        create: (context) => PocBloc()..add(PocFetched()),
        child: PostBody(),
      ),
    );
  }
}

class PostBody extends StatefulWidget {
  const PostBody({Key? key}) : super(key: key);

  @override
  _PostBodyState createState() => _PostBodyState();
}

class _PostBodyState extends State<PostBody> {
  ScrollController _scrollController = ScrollController();
  late PocBloc _pocBloc;

  @override
  void initState() {
    super.initState();
    _pocBloc = context.read<PocBloc>();
    _scrollController.addListener(_onScroll);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PocBloc, PocState>(
      builder: (context, state) {
        // Poc is initialize
        if (state is PocInitial) {
          return Center(child: CircularProgressIndicator());
        }

        // Poc is loaded
        if (state is PocLoaded) {
          if (state.posts.isEmpty)
            return Center(
              child: Text("No Post"),
            );

          return RefreshIndicator(
            onRefresh: _onRefresh,
            child: PostList(
              scrollController: _scrollController,
              state: state,
            ),
          );
        }

        // post is error
        return Center(child: Text("Error Fetched Posts"));
      },
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  Future<void> _onRefresh() async {
    _pocBloc..add(PocRefresh());
  }

  void _onScroll() {
    double maxScroll = _scrollController.position.maxScrollExtent;
    double currentScroll = _scrollController.position.pixels;
    if (currentScroll == maxScroll) _pocBloc..add(PocFetched());
  }
}
