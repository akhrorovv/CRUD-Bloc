import 'package:crud/bloc/home/home_bloc.dart';
import 'package:flutter/material.dart';

import '../models/post_model.dart';
import 'item_of_post.dart';

Widget viewOfHomePage(bool isLoading, List<Post> posts, HomeBloc homeBloc) {
  return Stack(
    children: [
      RefreshIndicator(
        onRefresh: homeBloc.handleRefresh,
        child: ListView.builder(
          physics: const BouncingScrollPhysics(),
          itemCount: posts.length,
          itemBuilder: (ctx, index) {
            return itemOfPost(posts[index], homeBloc);
          },
        ),
      ),
      isLoading
          ? const Center(
        child: CircularProgressIndicator(),
      )
          : const SizedBox.shrink(),
    ],
  );
}
