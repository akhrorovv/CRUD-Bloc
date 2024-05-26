import '../../models/post_model.dart';

abstract class HomeEvent {}

class LoadPostListEvent extends HomeEvent {}

class DeletePostEvent extends HomeEvent {
  final Post post;

  DeletePostEvent(this.post);
}
