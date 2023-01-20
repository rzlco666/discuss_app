import 'package:d_view/d_view.dart';
import 'package:discuss_app/config/app_route.dart';
import 'package:discuss_app/config/session.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: DView.appBarCenter('Home'),
      body: Center(
        child: ElevatedButton(
            onPressed: () {
              Session.clearUser();
              context.go(AppRoute.login);
            },
            child: const Text('Logout')
        ),
      ),
    );
  }
}
