import '../../models/post_model.dart';

abstract class UpdateEvent {}

class UpdatePostEvent extends UpdateEvent {
  final Post post;

  UpdatePostEvent(this.post);
}
