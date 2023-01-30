import 'package:d_view/d_view.dart';
import 'package:discuss_app/controller/c_comment.dart';
import 'package:discuss_app/controller/c_user.dart';
import 'package:discuss_app/model/comment.dart';
import 'package:discuss_app/model/topic.dart';
import 'package:discuss_app/source/comment_source.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import '../config/app_color.dart';

class CommentPage extends StatelessWidget {
  const CommentPage({super.key, required this.topic});

  final Topic topic;

  @override
  Widget build(BuildContext context) {
    final cComment = context.read<CComment>();
    final cUser = context.read<CUser>();
    final controllerInput = TextEditingController();
    cComment.setComments(topic);
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 0,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              topic.title,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(fontSize: 14),
            ),
            Text(
              topic.user!.username,
              style: TextStyle(fontSize: 12, color: Colors.white70),
            ),
          ],
        ),
      ),
      body: Stack(
        children: [
          Consumer<CComment>(
            builder: (contextConsumer, _, child) {
              if (_.comments.isEmpty) {
                return DView.empty('No comments yet.');
              }
              return ListView.builder(
                itemCount: _.comments.length,
                itemBuilder: (context, index) {
                  Comment comment = _.comments[index];
                  return Container(
                    margin: EdgeInsets.fromLTRB(8, index == 0 ? 8 : 4, 8, index == 0 ? 80 : 8),
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.blue[50],
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: ,
                  );
                },
              );
            },
          ),
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: Material(
              elevation: 8,
              color: AppColor.primary,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Consumer<CComment>(
                    builder: (contextConsumer, _, child) {
                      if (_.replyTo == null) return DView.nothing();
                      return Padding(
                        padding: const EdgeInsets.fromLTRB(8, 4, 8, 0),
                        child: Row(
                          children: [
                            const Text(
                              'To: ',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 12),
                            ),
                            Text(
                              _.replyTo!.username,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                              ),
                            )
                          ],
                        ),
                      );
                    },
                  ),
                  Consumer<CComment>(
                    builder: (contextConsumer, _, child) {
                      if (_.image == '') return DView.nothing();
                      return Padding(
                          padding: const EdgeInsets.fromLTRB(8, 4, 8, 0),
                          child: Text(
                            'Image: ${_.image}',
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                            ),
                          ));
                    },
                  ),
                  Row(
                    children: [
                      IconButton(
                        onPressed: () =>
                            cComment.pickImage(ImageSource.gallery),
                        icon: const Icon(Icons.image, color: Colors.white),
                      ),
                      IconButton(
                        onPressed: () =>
                            cComment.pickImage(ImageSource.gallery),
                        icon:
                            const Icon(Icons.photo_camera, color: Colors.white),
                      ),
                      Expanded(
                        child: Container(
                          margin: const EdgeInsets.symmetric(vertical: 4),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: TextField(
                            controller: controllerInput,
                            minLines: 1,
                            maxLines: 5,
                            decoration: const InputDecoration(
                              border: InputBorder.none,
                              isDense: true,
                              contentPadding: EdgeInsets.symmetric(
                                horizontal: 8,
                                vertical: 12,
                              ),
                            ),
                            style: TextStyle(height: 1, fontSize: 14),
                          ),
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          CommentSource.create(
                            topic.id,
                            cUser.data!.id,
                            context.read<CComment>().replyTo!.id,
                            controllerInput.text,
                            context.read<CComment>().image,
                            context.read<CComment>().imageBase64code,
                          ).then((success) {
                            if (success) {
                              controllerInput.clear();
                              cComment.setComments(topic);
                            }
                          });
                        },
                        icon: const Icon(Icons.send, color: Colors.white),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
