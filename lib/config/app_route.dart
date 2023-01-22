import 'package:discuss_app/config/session.dart';
import 'package:discuss_app/controller/c_add_topic.dart';
import 'package:discuss_app/controller/c_comment.dart';
import 'package:discuss_app/controller/c_follower.dart';
import 'package:discuss_app/controller/c_following.dart';
import 'package:discuss_app/controller/c_profile.dart';
import 'package:discuss_app/controller/c_search.dart';
import 'package:discuss_app/page/add_topic.dart';
import 'package:discuss_app/page/error_page.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../model/user.dart';
import '../page/home_page.dart';
import '../page/login_page.dart';
import '../page/register_page.dart';

class AppRoute {
  static const home = '/';
  static const login = '/login';
  static const register = '/register';
  static const addTopic = '/add-topic';
  static const profile = '/profile';
  static const search = '/search';
  static const follower = '/follower';
  static const following = '/following';
  static const comment = '/comment';
  static const detailTopic = '/detail-topic';
  static const updateTopic = '/update-topic';

  static GoRouter routerConfig = GoRouter(
      errorBuilder: (context, state) => ErrorPage(
            title: 'Error',
            description: state.error.toString(),
          ), // untuk error page
      debugLogDiagnostics: true, // untuk debug
      redirect: (context, state) async {
        User? user =
            await Session.getUser(); // untuk mendapatkan user dari session
        if (user == null) {
          if (state.location == login || state.location == register) {
            // jika user belum login dan sedang berada di halaman login atau register maka akan di redirect ke halaman login
            return null;
          }

          return login;
        }

        return null;
      },
      routes: [
        GoRoute(
          path: home,
          builder: (context, state) => const HomePage(),
        ),
        GoRoute(
          path: login,
          builder: (context, state) => LoginPage(),
        ),
        GoRoute(
          path: register,
          builder: (context, state) => RegisterPage(),
        ),
        GoRoute(
          path: addTopic,
          builder: (context, state) => ChangeNotifierProvider(
              create: (_) => CAddTopic(),
              child: AddTopic(),
          ),
        ),
        GoRoute(
          path: profile,
          builder: (context, state) => ChangeNotifierProvider(
              create: (_) => CProfile(),
              child: const Scaffold()
          ),
        ),
        GoRoute(
          path: search,
          builder: (context, state) => ChangeNotifierProvider(
              create: (_) => CSearch(),
              child: const Scaffold()
          ),
        ),
        GoRoute(
          path: follower,
          builder: (context, state) => ChangeNotifierProvider(
              create: (_) => CFollower(),
              child: const Scaffold()
          ),
        ),
        GoRoute(
          path: following,
          builder: (context, state) => ChangeNotifierProvider(
              create: (_) => CFollowing(),
              child: const Scaffold()
          ),
        ),
        GoRoute(
          path: comment,
          builder: (context, state) => ChangeNotifierProvider(
              create: (_) => CComment(),
              child: const Scaffold()
          ),
        ),
      ]);
}
