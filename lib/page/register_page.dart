import 'package:d_info/d_info.dart';
import 'package:d_input/d_input.dart';
import 'package:d_view/d_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../config/session.dart';
import '../model/user.dart';
import '../source/user_source.dart';

class RegisterPage extends StatelessWidget {
  RegisterPage({super.key});

  final controllerUsername = TextEditingController();
  final controllerPassword = TextEditingController();

  register(BuildContext context) {
    UserSource.register(controllerUsername.text, controllerPassword.text).then((responseBody) {
      if (responseBody['success']) {


        DInfo.dialogSuccess(context, 'Sign Up Success');
        DInfo.closeDialog(context, actionAfterClose: () {
          context.pop();
        });
      }else{
        if (responseBody['message'] == 'username') {
          DInfo.snackBarError(context, 'Username already exist');
        }else{
          DInfo.snackBarError(context, 'Sign Up Failed');
        }
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
                              DView.textTitle('Sign Up'),
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
                                    onPressed: () => register(context),
                                    child: Text('Sign Up')
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
                              'Already have an account?',
                              style: TextStyle(color: Colors.white70),
                            ),
                            TextButton(
                              onPressed: () {
                                context.pop();
                              },
                              child: const Text(
                                'Sign In',
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
