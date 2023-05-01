import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:liberate/provider/currentUser_provider.dart';
import 'package:liberate/services/auth_service.dart';
import 'package:liberate/services/database_service.dart';
import 'package:liberate/services/permission_service.dart';
import 'package:liberate/services/storage_service.dart';
import 'package:provider/provider.dart';
import 'app.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  await Firebase.initializeApp();
  await FlutterDownloader.initialize();
  runApp(
    MultiProvider(
      providers: [
        Provider<AuthService>(create: (context)=>AuthService()),
        Provider<DatabaseService>(create: (context)=>DatabaseService()),
        Provider<StorageService>(create: (context)=>StorageService()),
        Provider<PermissionService>(create: (context)=>PermissionService()),
        ChangeNotifierProvider(create: (context) => CurrentUserProvider()),
      ],
      child: const App(),
    ),
  );
}

