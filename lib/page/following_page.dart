import 'package:d_view/d_view.dart';
import 'package:discuss_app/controller/c_follower.dart';
import 'package:discuss_app/controller/c_following.dart';
import 'package:discuss_app/model/user.dart';
import 'package:discuss_app/widget/item_user.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FollowingPage extends StatelessWidget {
  const FollowingPage({super.key, required this.user});

  final User user;

  @override
  Widget build(BuildContext context) {
    final cFollowing = context.read<CFollowing>();
    cFollowing.setList(user.id);
    return Scaffold(
      appBar: DView.appBarLeft("${user.username}'s Following"),
      body: Consumer<CFollowing>(
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
