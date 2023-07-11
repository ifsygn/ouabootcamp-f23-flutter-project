// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:untitled4/common/helper/route/route_constant.dart';
import 'package:untitled4/view/shelter/shelter_search_view.dart';
import '../../../blogpage/home_page.dart';
import '../../../intro/introduction_screen.dart';
import '../../../view/authentication/login_view.dart';

class RouterGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {

      case RouteConstant.introductionScreenRoute:
        return MaterialPageRoute(builder: (_) => IntroductionScreenWidget());

      case RouteConstant.loginScreenRoute:
        return MaterialPageRoute(builder: (_) => const LoginView());

      case RouteConstant.homePageRoute:
        return MaterialPageRoute(builder: (_) => HomePage());

      case RouteConstant.shelterSearchRoute:
        return MaterialPageRoute(builder: (_) => ShelterSearchView());
    /*
      case RouteConstant.loginScreenRoute:
        return MaterialPageRoute(builder: (_) => const LoginView());

      case RouteConstant.signupScreenRoute:
        return MaterialPageRoute(builder: (_) => const SignupPage());

      case RouteConstant.forgotPassRoute:
        return MaterialPageRoute(builder: (_) => const ForgotPassword());

      case RouteConstant.registerScreenRoute:
        return MaterialPageRoute(builder: (_) => const RegisterPage());


      case RouteConstant.homeScreenRoute:
        return MaterialPageRoute(builder: (_) => const DrawerPage());

      case RouteConstant.profileRoute:
        return MaterialPageRoute(builder: (_) => const ProfilePage());

      case RouteConstant.feedBackScreenRoute:
        return MaterialPageRoute(builder: (_) => const FeedBackPage());

      case RouteConstant.aboutScreenRoute:
        return MaterialPageRoute(builder: (_) => const AboutPage());

      case RouteConstant.onBoardScreenRoute:
        return MaterialPageRoute(builder: (_) => const OnBoard());

      case RouteConstant.formScreenRoute:
        return MaterialPageRoute(builder: (_) => const FormPage());

      case RouteConstant.donateScreenRoute:
        return MaterialPageRoute(builder: (_) => const DonatePage());

      case RouteConstant.blogScreenRoute:
        return MaterialPageRoute(builder: (_) => BlogPage());

        */
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            appBar: AppBar(),
            body: const Center(
              child: Text('Ters giden birşeyler oldu'),
            ),
          ),
        );
    }
  }
}