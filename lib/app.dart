import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:liberate/themes/ownTheme.dart';
import 'package:liberate/ui/screens/welcome_screen.dart';

import 'constant/routes.dart';

class App extends StatelessWidget {
  const App({super.key});
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
        statusBarIconBrightness: Brightness.light,
    ));

    return  MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: MyTheme.defaultTheme,
      routes: Routes().routes(),
      initialRoute: Routes.welcomeScreen,
    );
  }
}