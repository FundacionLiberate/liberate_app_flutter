import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:liberate/services/auth_service.dart';
import 'package:liberate/services/permission_service.dart';
import 'package:provider/provider.dart';
import 'app.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  //await Firebase.initializeApp();
  runApp(
    MultiProvider(
      providers: [
        Provider<AuthService>(create: (context)=>AuthService()),
        Provider<PermissionService>(create: (context)=>PermissionService()),
      ],
      child: const App(),
    ),
  );
}

