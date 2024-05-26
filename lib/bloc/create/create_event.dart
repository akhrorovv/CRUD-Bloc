abstract class CreateEvent {}

class CreatePostEvent extends CreateEvent {
  final String title;
  final String body;

  CreatePostEvent(this.title, this.body);
}
