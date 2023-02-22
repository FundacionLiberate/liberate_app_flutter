import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class App extends StatelessWidget {
  const App({super.key});
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
        statusBarIconBrightness: Brightness.light,
    ));

    return  MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Container(),
    );
  }
}