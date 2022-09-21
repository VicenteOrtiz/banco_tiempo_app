part of 'poc_bloc.dart';

@immutable
abstract class PocState {}

class PocInitial extends PocState {}

class PocError extends PocState {}

class PocLoaded extends PocState {
  final List<Post> posts;
  final bool hasReachedMax;

  PocLoaded({
    this.posts = const <Post>[],
    this.hasReachedMax = false,
  });

  PocLoaded copyWith({List<Post>? posts, bool? hasReachedMax}) {
    return PocLoaded(
      posts: posts ?? this.posts,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
    );
  }

  @override
  List<Object> get props => [posts, hasReachedMax];
}
