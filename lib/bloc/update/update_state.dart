import '../../models/post_model.dart';

abstract class UpdateState {}

class UpdateInitialState extends UpdateState {}

class UpdatedPostState extends UpdateState {
  final Post post;

  UpdatedPostState(this.post);
}
