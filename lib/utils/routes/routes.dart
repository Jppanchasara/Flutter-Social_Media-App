import 'package:flutter/material.dart';
import 'package:tech_media/utils/routes/route_name.dart';
import 'package:tech_media/view/dashbord/profile/profile_Screen.dart';
import 'package:tech_media/view/forgot_password.dart/forgot_password_Screen.dart';
import 'package:tech_media/view/login/login_screen.dart';
import 'package:tech_media/view/signup/sign_up_screen.dart';
import 'package:tech_media/view/splash/splash_screen.dart';

import '../../view/dashbord/dashbord_screen.dart';


class Routes {

  static Route<dynamic> generateRoute(RouteSettings settings) {
    final arguments = settings.arguments;
    switch (settings.name) {
      case RouteName.splashScreen:
        return MaterialPageRoute(builder: (_) => const SplashScreen());
      case RouteName.LoginView:
        return MaterialPageRoute(builder: (_) => const LoginScreen());
      case RouteName.SignUpView:
        return MaterialPageRoute(builder: (_) => const SignUpScreen());
      case RouteName.DashBordView:
        return MaterialPageRoute(builder: (_) => const DashBordScreen());
      case RouteName.ForgotPasswordView:
        return MaterialPageRoute(builder: (_) => const ForgotPasswordScreen());
 
      default:
        return MaterialPageRoute(builder: (_) {
          return Scaffold(
            body: Center(
              child: Text('No route defined for ${settings.name}'),
            ),
          );
        });
    }
  }
}