import 'package:discuss_app/config/app_color.dart';
import 'package:discuss_app/config/app_route.dart';
import 'package:discuss_app/controller/c_feed.dart';
import 'package:discuss_app/controller/c_user.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'controller/c_home.dart';

void main() {
  WidgetsFlutterBinding
      .ensureInitialized(); // to ensure that the binding is initialized
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => CUser()),
        ChangeNotifierProvider(create: (_) => CHome()),
        ChangeNotifierProvider(create: (_) => CFeed()),
      ],
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false, // to remove debug banner
        theme: ThemeData(
          primaryColor: AppColor.primary,
          colorScheme: const ColorScheme.light().copyWith(
            primary: AppColor.primary,
          ),
        ),
        routerConfig: AppRoute.routerConfig,
      ),
    );
  }
}
