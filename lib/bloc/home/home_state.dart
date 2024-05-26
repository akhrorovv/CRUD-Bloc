import '../../models/post_model.dart';

abstract class HomeState {}

class HomeInitialState extends HomeState {}

class HomeLoadingState extends HomeState {}

class HomeErrorState extends HomeState {
  final String errorMessage;

  HomeErrorState(this.errorMessage);
}

class HomeDeleteState extends HomeState {
  final Post post;

  HomeDeleteState(this.post);
}

class HomeLoadPostState extends HomeState {
  late final List<Post> posts;

  HomeLoadPostState(this.posts);
}
