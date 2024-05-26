import 'package:crud/bloc/create/create_bloc.dart';
import 'package:crud/bloc/update/update_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../models/post_model.dart';
import '../../pages/create_page.dart';
import '../../pages/update_page.dart';
import '../../services/http_service.dart';
import '../../services/log_service.dart';
import 'home_event.dart';
import 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  List<Post> posts = [];

  HomeBloc() : super(HomeInitialState()) {
    on<LoadPostListEvent>(_onLoadPostListEvent);
    on<DeletePostEvent>(_onDeletePostEvent);
  }

  Future<void> _onLoadPostListEvent(
      LoadPostListEvent event, Emitter<HomeState> emit) async {
    emit(HomeLoadingState());

    var response =
        await Network.GET(Network.API_POST_LIST, Network.paramsEmpty());
    if (response != null) {
      var postList = Network.parsePostList(response);
      posts.addAll(postList);
      LogService.i('Response List length: ${postList.length.toString()}');
      emit(HomeLoadPostState(posts));
    } else {
      emit(HomeErrorState('Could not fetch posts'));
    }
  }

  Future<void> _onDeletePostEvent(
      DeletePostEvent event, Emitter<HomeState> emit) async {
    emit(HomeLoadingState());

    var response = await Network.DEL(
        Network.API_POST_DELETE + event.post.id.toString(),
        Network.paramsEmpty());
    LogService.d(response!);

    if (response != null) {
      emit(HomeLoadPostState(posts));
    } else {
      emit(HomeErrorState('Could not delete post'));
    }
  }

  Future callCreatePage(BuildContext context) async {
    bool result = await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (BuildContext context) {
          return BlocProvider(
            create: (context) => CreateBloc(),
            child: const CreatePage(),
          );
        },
      ),
    );

    if (result) {
      emit(HomeLoadPostState(posts));
    }
  }

  Future callUpdatePage(BuildContext context, Post post) async {
    bool result = await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (BuildContext context) {
          return BlocProvider(
            create: (context) => UpdateBloc(),
            child: UpdatePage(post: post),
          );
        },
      ),
    );

    if (result) {
      emit(HomeLoadPostState(posts));
    }
  }

  Future<void> handleRefresh() async {
    emit(HomeLoadPostState(posts));
  }
}
