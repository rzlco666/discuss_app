import 'package:d_view/d_view.dart';
import 'package:discuss_app/controller/c_follower.dart';
import 'package:discuss_app/model/user.dart';
import 'package:discuss_app/widget/item_user.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FollowerPage extends StatelessWidget {
  const FollowerPage({super.key, required this.user});

  final User user;

  @override
  Widget build(BuildContext context) {
    final cFollower = context.read<CFollower>();
    cFollower.setList(user.id);
    return Scaffold(
      appBar: DView.appBarLeft("${user.username}'s Followers"),
      body: Consumer<CFollower>(
        builder: (contextConsumer, _, child) {
          if (_.list.isEmpty) return DView.empty();
          return ListView.builder(
            itemCount: _.list.length,
            itemBuilder: (context, index) {
              return ItemUser(user: _.list[index]);
            },
          );
        },
      ),
    );
  }
}
