import 'package:crud/bloc/home/home_event.dart';
import 'package:crud/bloc/home/home_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/home/home_bloc.dart';
import '../views/view_of_home.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late HomeBloc homeBloc;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    homeBloc = context.read<HomeBloc>();
    homeBloc.add(LoadPostListEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        backgroundColor: Colors.blue,
        centerTitle: true,
        title: const Text("Networking", style: TextStyle(color: Colors.white)),
      ),
      body: BlocConsumer<HomeBloc, HomeState>(
        listener: (context, state) {},
        builder: (context, state) {
          if (state is HomeLoadingState) {
            return viewOfHomePage(true, [], homeBloc);
          }
          if (state is HomeLoadPostState) {
            return viewOfHomePage(false, state.posts, homeBloc);
          }
          return viewOfHomePage(false, [], homeBloc);
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blue,
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
        onPressed: () {
          homeBloc.callCreatePage(context);
        },
      ),
    );
  }
}
