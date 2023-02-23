import 'package:flutter/cupertino.dart';
import 'package:liberate/ui/screens/welcome_screen.dart';
import '../ui/screens/logIn_screen.dart';
import '../ui/screens/sign_up_screen.dart';
import '../ui/screens/srtart_screen.dart';



class Routes{

  static String welcomeScreen= "welcomeScreen";
  static String loginScreen= "loginScreen";
  static String signUpScreen ="signUpScreen";
  static String startScreen= "StartScreen";


  Map<String, WidgetBuilder> routes(){
    return {
      loginScreen: (context) => const LoginScreen(),
      welcomeScreen: (context) => const WelcomeScreen(),
      signUpScreen: (context) => const SignUpScreen(),
      startScreen: (context) => const StartScreen(),
    };
  }



}