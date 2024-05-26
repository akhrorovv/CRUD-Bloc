import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

import '../../models/post_model.dart';
import '../../services/http_service.dart';
import '../../services/log_service.dart';
import 'create_event.dart';
import 'create_state.dart';

class CreateBloc extends Bloc<CreateEvent, CreateState> {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController bodyController = TextEditingController();

  CreateBloc() : super(CreateInitialState()) {
    on<CreatePostEvent>(_onCreatePostEvent);
  }

  Future<void> _onCreatePostEvent(CreatePostEvent event, Emitter<CreateState> emit) async {
    String title = titleController.text.toString().trim();
    String body = bodyController.text.toString().trim();

    if (title.isEmpty || body.isEmpty) {
      return;
    }

    Post post = Post(userId: 1, title: title, body: body);

    var response = await Network.POST(Network.API_POST_CREATE, Network.paramsCreate(post));
    LogService.d(response!);

    emit(CreatedPostState(post));
  }
}
