import 'package:discuss_app/config/session.dart';
import 'package:discuss_app/page/error_page.dart';
import 'package:go_router/go_router.dart';

import '../model/user.dart';
import '../page/home_page.dart';
import '../page/login_page.dart';
import '../page/register_page.dart';

class AppRoute {
  static const home = '/';
  static const login = '/login';
  static const register = '/register';

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
          builder: (context, state) => const LoginPage(),
        ),
        GoRoute(
          path: register,
          builder: (context, state) => const RegisterPage(),
        ),
      ]);
}
