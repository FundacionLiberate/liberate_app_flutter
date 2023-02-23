import 'package:flutter/material.dart';
import 'package:liberate/ui/screens/welcome_screen.dart';
import 'package:provider/provider.dart';
import '../../../services/auth_service.dart';
import 'home_screen.dart';


class StartScreen extends StatefulWidget {
  const StartScreen({Key? key}) : super(key: key);

  @override
  _StartScreenState createState() => _StartScreenState();
}

class _StartScreenState extends State<StartScreen> {

  @override
  Widget build(BuildContext context) {
    final authService= Provider.of<AuthService>(context);

    return StreamBuilder(
      stream: authService.authStatus,
      builder: (BuildContext context, AsyncSnapshot snapshot){
        if(!snapshot.hasData || snapshot.hasError){
          return const WelcomeScreen();
        }
        else{
          return HomeScreen();
        }
      },
    );
  }
}
