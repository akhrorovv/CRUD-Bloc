import 'package:bloc/bloc.dart';
import 'package:crud/services/log_service.dart';
import 'package:flutter/material.dart';

import '../../models/post_model.dart';
import '../../services/http_service.dart';
import 'update_event.dart';
import 'update_state.dart';

class UpdateBloc extends Bloc<UpdateEvent, UpdateState> {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController bodyController = TextEditingController();

  UpdateBloc() : super(UpdateInitialState()) {
    on<UpdatePostEvent>(_onUpdatePostEvent);
  }

  Future<void> _onUpdatePostEvent(
      UpdatePostEvent event, Emitter<UpdateState> emit) async {
    String title = titleController.text.toString().trim();
    String body = bodyController.text.toString().trim();

    Post newPost = event.post;
    newPost.title = title;
    newPost.body = body;

    var response = await Network.PUT(
        Network.API_POST_UPDATE + newPost.id.toString(),
        Network.paramsUpdate(newPost));

    if (response != null) {
      emit(UpdatedPostState(newPost));
    } else {
      LogService.e('Could not delete post');
    }
  }
}
