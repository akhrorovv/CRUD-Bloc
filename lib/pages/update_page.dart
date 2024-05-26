import 'package:crud/bloc/update/update_bloc.dart';
import 'package:crud/bloc/update/update_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/update/update_state.dart';
import '../models/post_model.dart';

class UpdatePage extends StatefulWidget {
  final Post post;

  const UpdatePage({super.key, required this.post});

  @override
  State<UpdatePage> createState() => _UpdatePageState();
}

class _UpdatePageState extends State<UpdatePage> {
  late UpdateBloc updateBloc;

  backToFinish() {
    Navigator.of(context).pop(true);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    updateBloc = context.read<UpdateBloc>();
    updateBloc.titleController.text = widget.post.title!;
    updateBloc.bodyController.text = widget.post.body!;

    updateBloc.stream.listen((state) {
      if (state is UpdatedPostState) {
        backToFinish();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blue,
          title: Text("Update Post"),
        ),
        body: Container(
          width: double.infinity,
          padding: EdgeInsets.all(20),
          child: Column(
            children: [
              Container(
                child: TextField(
                  controller: updateBloc.titleController,
                  decoration: InputDecoration(hintText: "Title"),
                ),
              ),
              Container(
                child: TextField(
                  controller: updateBloc.bodyController,
                  decoration: InputDecoration(hintText: "Body"),
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 10),
                width: double.infinity,
                child: MaterialButton(
                  color: Colors.blue,
                  onPressed: () {
                    updateBloc.add(UpdatePostEvent(widget.post));
                  },
                  child: Text("Update"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
