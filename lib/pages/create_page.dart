import 'package:crud/bloc/create/create_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/create/create_bloc.dart';
import '../bloc/create/create_state.dart';

class CreatePage extends StatefulWidget {
  const CreatePage({super.key});

  @override
  State<CreatePage> createState() => _CreatePageState();
}

class _CreatePageState extends State<CreatePage> {
  late CreateBloc createBloc;

  backToFinish() {
    Navigator.of(context).pop(true);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    createBloc = context.read<CreateBloc>();

    createBloc.stream.listen((state) {
      if (state is CreatedPostState) {
        backToFinish();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: const Text("Create Post"),
      ),
      body: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Container(
              child: TextField(
                controller: createBloc.titleController,
                decoration: const InputDecoration(hintText: "Title"),
              ),
            ),
            Container(
              child: TextField(
                controller: createBloc.bodyController,
                decoration: const InputDecoration(hintText: "Body"),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 10),
              width: double.infinity,
              child: MaterialButton(
                color: Colors.blue,
                onPressed: () {
                  String title = createBloc.titleController.text.toString().trim();
                  String body = createBloc.bodyController.text.toString().trim();

                  createBloc.add(CreatePostEvent(title, body));
                },
                child: const Text("Create"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
