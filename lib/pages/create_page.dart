import 'package:flutter/material.dart';
import '../models/post_model.dart';
import '../models/post_res_model.dart';
import '../services/http_service.dart';
import '../services/log_service.dart';

class CreatePage extends StatefulWidget {
  const CreatePage({super.key});

  @override
  State<CreatePage> createState() => _CreatePageState();
}

class _CreatePageState extends State<CreatePage> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _bodyController = TextEditingController();

  createPost() async{
    String title = _titleController.text.toString().trim();
    String body = _bodyController.text.toString().trim();
    Post post = Post(userId: 1,title: title, body: body);

    var response = await Network.POST(Network.API_POST_CREATE, Network.paramsCreate(post));
    LogService.d(response!);
    PostRes postRes = Network.parsePostRes(response);
    backToFinish();
  }

  backToFinish(){
    Navigator.of(context).pop(true);
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
                controller: _titleController,
                decoration: const InputDecoration(
                    hintText: "Title"
                ),
              ),
            ),
            Container(
              child: TextField(
                controller: _bodyController,
                decoration: const InputDecoration(
                    hintText: "Body"
                ),
              ),
            ),
            Container(
                margin: const EdgeInsets.only(top: 10),
                width: double.infinity,
                child: MaterialButton(
                  color: Colors.blue,
                  onPressed: () {
                    createPost();
                  },
                  child: const Text("Create"),
                )
            ),
          ],
        ),
      ),
    );
  }
}