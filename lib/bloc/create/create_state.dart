import '../../models/post_model.dart';

abstract class CreateState {}

class CreateInitialState extends CreateState {}

class CreatedPostState extends CreateState {
  final Post post;

  CreatedPostState(this.post);
}
