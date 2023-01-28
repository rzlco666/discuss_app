import 'package:d_view/d_view.dart';
import 'package:discuss_app/config/api.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../model/user.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key, required this.user});

  final User user;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            color: Colors.blue,
            child: AspectRatio(
              aspectRatio: 1.3,
              child: Stack(
                children: [
                  AspectRatio(
                    aspectRatio: 1.5,
                    child: Image.network(
                      '${Api.imageUser}/${user.image}',
                      fit: BoxFit.cover,
                    ),
                  ),
                  Positioned(
                    left: 16,
                    top: 30,
                    child: FloatingActionButton(
                      heroTag: 'back-navigation',
                      mini: true,
                      onPressed: () => context.pop(),
                      child: const Icon(Icons.navigate_before),
                    ),
                  ),
                  Positioned(
                    left: 16,
                    bottom: 0,
                    right: 16,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 2,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.grey.withOpacity(0.3),
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: DView.textTitle(
                            user.username,
                            color: Colors.white,
                          ),
                        ),
                        DView.spaceHeight(8),
                        
                      ],
                    ),
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
