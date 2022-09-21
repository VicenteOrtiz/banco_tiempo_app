import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../domain/post.dart';
import '../../infraestructure/datasource/post_datasource.dart';

part 'poc_event.dart';
part 'poc_state.dart';

class PocBloc extends Bloc<PocEvent, PocState> {
  PocBloc() : super(PocInitial()) {
    List<Post> posts;

    on<PocRefresh>((event, emit) async {
      // TODO: implement event handler

      try {
        posts = await PostDatasource.fetchPost(0, 20);
        emit(PocLoaded(posts: posts, hasReachedMax: false));
      } catch (e, s) {
        emit(PocError());
      }
    });

    on<PocFetched>((event, emit) async {
      // TODO: implement event handler

      try {
        if (state is PocInitial) {
          posts = await PostDatasource.fetchPost(0, 10);
          emit(PocLoaded(posts: posts, hasReachedMax: false));
        } else {
          PocLoaded postLoaded = state as PocLoaded;
          posts = await PostDatasource.fetchPost(postLoaded.posts.length, 10);

          if (posts.isEmpty) {
            emit(postLoaded.copyWith(hasReachedMax: true));
          } else {
            emit(postLoaded.copyWith(posts: postLoaded.posts + posts));
          }
        }
      } catch (e, s) {
        emit(PocError());
      }
    });
  }
}
