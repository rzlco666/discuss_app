import 'package:d_info/d_info.dart';
import 'package:d_input/d_input.dart';
import 'package:d_view/d_view.dart';
import 'package:discuss_app/config/app_route.dart';
import 'package:discuss_app/config/session.dart';
import 'package:discuss_app/controller/c_user.dart';
import 'package:discuss_app/model/user.dart';
import 'package:discuss_app/source/user_source.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatelessWidget {
  LoginPage({super.key});

  final controllerUsername = TextEditingController();
  final controllerPassword = TextEditingController();

  login(BuildContext context) {
    UserSource.login(controllerUsername.text, controllerPassword.text).then((responseBody) {
      if (responseBody['success']) {
        var mapUser = Map<String, dynamic>.from(responseBody['data']);
        User user = User.fromJson(mapUser);
        Session.setUser(user);
        context.read<CUser>().data = user;

        DInfo.dialogSuccess(context, 'Sign In Success');
        DInfo.closeDialog(context, actionAfterClose: () {
          //context.go(AppRoute.home);
        });
      }else{
        DInfo.snackBarError(context, 'Sign In Failed');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Colors.blueAccent, Colors.blueGrey],
        )),
        child: LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  minHeight: constraints.maxHeight,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    DView.nothing(),
                    Card(
                      margin: const EdgeInsets.all(16),
                      elevation: 8,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          children: [
                            DView.textTitle('Sign In'),
                            DView.spaceHeight(8),
                            const Divider(color: Colors.blue,),
                            DView.spaceHeight(4),
                            DInput(
                              controller: controllerUsername,
                              title: 'Username',
                              spaceTitle: 4,
                            ),
                            DView.spaceHeight(),
                            DInput(
                              controller: controllerPassword,
                              title: 'Password',
                              spaceTitle: 4,
                            ),
                            DView.spaceHeight(),
                            SizedBox(
                              width: double.infinity,
                              child: ElevatedButton(
                                  onPressed: () => login(context),
                                  child: Text('Sign In')
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            'Don\'t have an account?',
                            style: TextStyle(color: Colors.white70),
                          ),
                          TextButton(
                            onPressed: () {
                              context.push(
                                AppRoute.register
                              );
                            },
                            child: const Text(
                              'Sign Up',
                              style: TextStyle(color: Colors.white),
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          }
        ),
      ),
    );
  }
}
